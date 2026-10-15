const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();
const db = admin.firestore();

/**
 * Format paisa integer to formatted NPR string, e.g. "Rs. 5,000"
 */
function formatPaisa(paisa) {
  if (!paisa || isNaN(paisa)) return 'Rs. 0';
  const rupees = paisa / 100;
  return `Rs. ${rupees.toLocaleString('en-IN')}`;
}

/**
 * Cloud Function triggered on new transaction committed to Firestore.
 * Dispatches real-time persistent notifications and multi-device FCM push.
 */
exports.onTransactionCreated = functions.firestore
  .document('shops/{shopId}/transactions/{transactionId}')
  .onCreate(async (snapshot, context) => {
    const { shopId, transactionId } = context.params;
    const tx = snapshot.data();

    if (!tx || !tx.type || !tx.amountInPaisa) {
      console.log('Skipping invalid transaction document:', transactionId);
      return null;
    }

    const eventId = `${tx.type}_${transactionId}`;
    const dedupeRef = db.collection('shops').doc(shopId).collection('dispatched_events').doc(eventId);

    // 1. Idempotency Check: Prevent duplicate processing across retries
    const dedupeDoc = await dedupeRef.get();
    if (dedupeDoc.exists) {
      console.log(`Event ${eventId} already processed. Skipping duplicate dispatch.`);
      return null;
    }

    // 2. Fetch Customer Details
    let customerName = 'Customer';
    let previousDebt = 0;
    let newDebt = 0;

    if (tx.customerId) {
      try {
        const customerSnap = await db.collection('shops').doc(shopId).collection('customers').doc(tx.customerId).get();
        if (customerSnap.exists) {
          const customerData = customerSnap.data();
          customerName = customerData.name || customerName;
          previousDebt = customerData.totalDebtInPaisa || 0;
        }
      } catch (err) {
        console.error('Error fetching customer details:', err);
      }
    }

    const actorStaffId = tx.staffId || null;
    const actorStaffName = tx.staffName || 'Shop Staff';
    const amountStr = formatPaisa(tx.amountInPaisa);

    let eventType = '';
    let title = '';
    let message = '';

    if (tx.type === 'credit') {
      eventType = 'CREDIT_CREATED';
      title = 'New Credit Recorded';
      if (tx.creditTakenBy && tx.creditTakenBy.trim().toLowerCase() !== customerName.trim().toLowerCase()) {
        message = `${tx.creditTakenBy.trim()} took ${amountStr} credit for ${customerName}. Recorded by ${actorStaffName}.`;
      } else {
        message = `${actorStaffName} gave ${amountStr} credit to ${customerName}.`;
      }
      newDebt = previousDebt + tx.amountInPaisa;
    } else if (tx.type === 'payment') {
      newDebt = Math.max(0, previousDebt - tx.amountInPaisa);

      if (previousDebt > 0 && newDebt === 0) {
        eventType = 'CUSTOMER_ACCOUNT_FULLY_SETTLED';
        title = 'Customer Due Fully Cleared';
        message = `${customerName} has cleared the outstanding due of ${formatPaisa(previousDebt)}. Final payment of ${amountStr} received by ${actorStaffName}.`;
      } else {
        eventType = 'PAYMENT_RECEIVED';
        title = 'Customer Payment Received';
        message = `${actorStaffName} received ${amountStr} from ${customerName}. Remaining due: ${formatPaisa(newDebt)}.`;
      }
    } else {
      console.log(`Unhandled transaction type: ${tx.type}`);
      return null;
    }

    // 3. Create Persistent Notification Record in Shop
    const notificationId = `notif_${transactionId}`;
    const notificationRecord = {
      id: notificationId,
      shopId: shopId,
      recipientStaffId: 'all',
      actorStaffId: actorStaffId,
      actorStaffName: actorStaffName,
      eventType: eventType,
      title: title,
      message: message,
      customerId: tx.customerId || '',
      customerName: customerName,
      transactionId: transactionId,
      amountInPaisa: tx.amountInPaisa,
      remainingBalanceInPaisa: newDebt,
      isRead: false,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    await db.collection('shops').doc(shopId).collection('notifications').doc(notificationId).set(notificationRecord);

    // 4. Fetch Registered Device Tokens for Shop
    const tokensSnap = await db.collection('shops').doc(shopId).collection('device_tokens').get();
    if (tokensSnap.empty) {
      console.log(`No registered device tokens for shop: ${shopId}`);
      await dedupeRef.set({ processedAt: admin.firestore.FieldValue.serverTimestamp(), recipientTokens: 0 });
      return null;
    }

    // 5. Filter Tokens by Staff Notification Preferences
    const eligibleTokens = [];
    const staleTokens = [];

    for (const doc of tokensSnap.docs) {
      const tokenData = doc.data();
      const token = tokenData.deviceToken;
      const staffId = tokenData.staffId;

      if (!token) continue;

      // Check staff preferences
      let prefs = { notifyOnCredit: true, notifyOnPayment: true, notifyOnFullClearance: true, notifyOwnTransactions: false, pushEnabled: true };
      if (staffId) {
        try {
          const prefDoc = await db.collection('shops').doc(shopId).collection('preferences').doc(staffId).get();
          if (prefDoc.exists) {
            prefs = Object.assign(prefs, prefDoc.data());
          }
        } catch (e) {
          console.warn(`Could not read prefs for staff ${staffId}:`, e);
        }
      }

      if (!prefs.pushEnabled) continue;
      if (eventType === 'CREDIT_CREATED' && !prefs.notifyOnCredit) continue;
      if (eventType === 'PAYMENT_RECEIVED' && !prefs.notifyOnPayment) continue;
      if (eventType === 'CUSTOMER_ACCOUNT_FULLY_SETTLED' && !prefs.notifyOnFullClearance) continue;
      if (actorStaffId && staffId === actorStaffId && !prefs.notifyOwnTransactions) continue;

      eligibleTokens.push({ docId: doc.id, token: token });
    }

    if (eligibleTokens.length === 0) {
      console.log('No eligible tokens after applying staff notification preferences.');
      await dedupeRef.set({ processedAt: admin.firestore.FieldValue.serverTimestamp(), recipientTokens: 0 });
      return null;
    }

    // 6. Dispatch FCM Push Notifications
    const pushPayload = {
      notification: {
        title: title,
        body: message,
      },
      data: {
        shopId: shopId,
        transactionId: transactionId,
        customerId: tx.customerId || '',
        eventType: eventType,
        click_action: 'FLUTTER_NOTIFICATION_CLICK',
      },
      tokens: eligibleTokens.map(t => t.token),
    };

    try {
      const response = await admin.messaging().sendEachForMulticast(pushPayload);
      console.log(`FCM Multicast sent: ${response.successCount} success, ${response.failureCount} failure`);

      // 7. Cleanup Stale / Expired Tokens
      const deletePromises = [];
      response.responses.forEach((resp, idx) => {
        if (!resp.success && resp.error) {
          const errCode = resp.error.code;
          if (
            errCode === 'messaging/invalid-registration-token' ||
            errCode === 'messaging/registration-token-not-registered'
          ) {
            console.log(`Cleaning up expired device token: ${eligibleTokens[idx].token}`);
            deletePromises.push(
              db.collection('shops').doc(shopId).collection('device_tokens').doc(eligibleTokens[idx].docId).delete()
            );
          }
        }
      });
      await Promise.all(deletePromises);

      // 8. Record Idempotency & Audit
      await dedupeRef.set({
        processedAt: admin.firestore.FieldValue.serverTimestamp(),
        recipientTokens: eligibleTokens.length,
        successCount: response.successCount,
        failureCount: response.failureCount,
        eventType: eventType,
      });

      await db.collection('shops').doc(shopId).collection('dispatch_audit').add({
        eventId: eventId,
        transactionId: transactionId,
        title: title,
        message: message,
        totalEligible: eligibleTokens.length,
        successCount: response.successCount,
        failureCount: response.failureCount,
        dispatchedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    } catch (err) {
      console.error('FCM Multicast Dispatch error:', err);
    }

    return null;
  });
