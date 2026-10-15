import 'package:flutter/foundation.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../staff/data/staff_repository.dart';
import '../models/shop_notification.dart';
import 'notification_repository.dart';

class NotificationDispatchService {
  final NotificationRepository _notificationRepo;
  final StaffRepository _staffRepo;

  NotificationDispatchService({
    required NotificationRepository notificationRepository,
    required StaffRepository staffRepository,
  })  : _notificationRepo = notificationRepository,
        _staffRepo = staffRepository;

  /// Dispatches a notification when new credit (udharo) is recorded.
  Future<void> notifyCreditCreated({
    required String shopId,
    required String? actorStaffId,
    required String actorStaffName,
    required String customerId,
    required String customerName,
    required String transactionId,
    required int amountInPaisa,
    required int remainingBalanceInPaisa,
    String? creditTakenBy,
    DateTime? timestamp,
  }) async {
    final time = timestamp ?? DateTime.now();
    final formattedAmount = CurrencyFormatter.formatPaisa(amountInPaisa);

    final String message;
    if (creditTakenBy != null &&
        creditTakenBy.trim().isNotEmpty &&
        creditTakenBy.trim().toLowerCase() != customerName.trim().toLowerCase()) {
      message =
          '${creditTakenBy.trim()} took $formattedAmount credit for $customerName. Recorded by $actorStaffName.';
    } else {
      message = '$actorStaffName gave $formattedAmount credit to $customerName.';
    }

    final event = ShopNotification(
      id: 'CREDIT_${transactionId}_all',
      shopId: shopId,
      recipientStaffId: 'all',
      actorStaffId: actorStaffId,
      actorStaffName: actorStaffName,
      eventType: NotificationEventType.creditCreated,
      title: 'New Credit Recorded',
      message: message,
      customerId: customerId,
      customerName: customerName,
      transactionId: transactionId,
      amountInPaisa: amountInPaisa,
      remainingBalanceInPaisa: remainingBalanceInPaisa,
      isRead: false,
      createdAt: time,
    );

    await _dispatchToShopMembers(
      event: event,
      shopId: shopId,
      actorStaffId: actorStaffId,
      eventType: NotificationEventType.creditCreated,
    );
  }

  /// Dispatches a notification when payment is received, including handling
  /// full dues clearance transition vs partial payment vs single invoice paid.
  Future<void> notifyPaymentReceived({
    required String shopId,
    required String? actorStaffId,
    required String actorStaffName,
    required String customerId,
    required String customerName,
    required String transactionId,
    required int amountInPaisa,
    required int previousBalanceInPaisa,
    required int remainingBalanceInPaisa,
    bool isInvoiceFullyPaid = false,
    String? invoiceId,
    bool isCustomerAccountFullySettled = false,
    int? totalCreditClearedInPaisa,
    DateTime? timestamp,
  }) async {
    final time = timestamp ?? DateTime.now();
    final formattedAmount = CurrencyFormatter.formatPaisa(amountInPaisa);
    final formattedRemaining =
        CurrencyFormatter.formatPaisa(remainingBalanceInPaisa);

    NotificationEventType eventType;
    String title;
    String message;

    // Detect true transition to zero balance
    final bool isAccountCleared = (isCustomerAccountFullySettled ||
            remainingBalanceInPaisa == 0) &&
        previousBalanceInPaisa > 0 &&
        remainingBalanceInPaisa == 0;

    if (isAccountCleared) {
      eventType = NotificationEventType.customerAccountFullySettled;
      title = 'Customer Due Fully Cleared';
      final clearedAmount = totalCreditClearedInPaisa != null &&
              totalCreditClearedInPaisa > 0
          ? CurrencyFormatter.formatPaisa(totalCreditClearedInPaisa)
          : CurrencyFormatter.formatPaisa(previousBalanceInPaisa);
      message =
          '$customerName has cleared the outstanding due of $clearedAmount. Final payment of $formattedAmount received by $actorStaffName.';
    } else if (isInvoiceFullyPaid && remainingBalanceInPaisa > 0) {
      eventType = NotificationEventType.invoiceFullyPaid;
      title = 'Invoice Fully Paid';
      final invLabel = invoiceId != null && invoiceId.isNotEmpty
          ? 'invoice $invoiceId'
          : 'credit invoice';
      message =
          '$customerName fully paid $invLabel. She still has $formattedRemaining outstanding on other invoices. Received by $actorStaffName.';
    } else {
      eventType = NotificationEventType.paymentReceived;
      title = 'Customer Payment Received';
      message =
          '$actorStaffName received $formattedAmount from $customerName. Remaining due: $formattedRemaining.';
    }

    final event = ShopNotification(
      id: '${eventType.value}_${transactionId}_all',
      shopId: shopId,
      recipientStaffId: 'all',
      actorStaffId: actorStaffId,
      actorStaffName: actorStaffName,
      eventType: eventType,
      title: title,
      message: message,
      customerId: customerId,
      customerName: customerName,
      transactionId: transactionId,
      amountInPaisa: amountInPaisa,
      remainingBalanceInPaisa: remainingBalanceInPaisa,
      isRead: false,
      createdAt: time,
    );

    await _dispatchToShopMembers(
      event: event,
      shopId: shopId,
      actorStaffId: actorStaffId,
      eventType: eventType,
    );
  }

  /// Internal fan-out: saves persistent records for the shop and checks individual preferences.
  Future<void> _dispatchToShopMembers({
    required ShopNotification event,
    required String shopId,
    required String? actorStaffId,
    required NotificationEventType eventType,
  }) async {
    // 1. Save canonical shop-wide notification
    await _notificationRepo.saveNotification(event);

    // 2. Fetch active staff members to verify preferences and ensure recipient isolation
    try {
      final staffList = await _staffRepo.getStaffForShop(shopId);
      final activeStaff = staffList.where((s) => s.isActive).toList();

      for (final staff in activeStaff) {
        final prefs = await _notificationRepo.getPreferences(shopId, staff.id);

        // Check if event type is enabled
        if (eventType == NotificationEventType.creditCreated &&
            !prefs.notifyOnCredit) {
          continue;
        }
        if (eventType == NotificationEventType.paymentReceived &&
            !prefs.notifyOnPayment) {
          continue;
        }
        if ((eventType == NotificationEventType.customerAccountFullySettled ||
                eventType == NotificationEventType.invoiceFullyPaid) &&
            !prefs.notifyOnFullClearance) {
          continue;
        }

        // If this staff member was the actor and opted out of self-notifications
        final isActor = actorStaffId != null && actorStaffId == staff.id;
        if (isActor && !prefs.notifyOwnTransactions) {
          continue;
        }

        // Create deterministic recipient-specific record for persistent notification centers
        final recipientEvent = event.copyWith(
          id: '${eventType.value}_${event.transactionId}_${staff.id}',
          recipientStaffId: staff.id,
        );
        await _notificationRepo.saveNotification(recipientEvent);
      }
    } catch (e) {
      debugPrint('Error evaluating staff preferences: $e');
    }
  }
}
