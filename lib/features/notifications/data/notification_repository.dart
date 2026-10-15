import 'package:drift/drift.dart';
import '../../../data/local/app_database.dart';
import '../models/notification_preferences.dart';
import '../models/shop_notification.dart';

abstract class NotificationRepository {
  Stream<List<ShopNotification>> watchNotifications(
    String shopId, {
    String? recipientStaffId,
  });

  Future<List<ShopNotification>> getNotifications(
    String shopId, {
    String? recipientStaffId,
  });

  Stream<int> watchUnreadCount(
    String shopId, {
    String? recipientStaffId,
  });

  Future<void> saveNotification(ShopNotification notification);

  Future<void> markAsRead(String id);

  Future<void> markAllAsRead(
    String shopId, {
    String? recipientStaffId,
  });

  Future<void> dismissNotification(String id);

  Future<NotificationPreferences> getPreferences(
    String shopId,
    String staffId,
  );

  Stream<NotificationPreferences> watchPreferences(
    String shopId,
    String staffId,
  );

  Future<void> savePreferences(NotificationPreferences preferences);

  Future<void> registerDeviceToken({
    required String shopId,
    required String staffId,
    required String token,
    required String platform,
  });

  Future<void> removeDeviceToken(String token);

  Future<List<DeviceTokensTableData>> getDeviceTokensForShop(String shopId);
}

class DriftNotificationRepository implements NotificationRepository {
  final AppDatabase _db;

  DriftNotificationRepository(this._db);

  ShopNotification _toDomain(NotificationsTableData row) {
    return ShopNotification(
      id: row.id,
      shopId: row.shopId,
      recipientStaffId: row.recipientStaffId ?? 'all',
      actorStaffId: row.actorStaffId,
      actorStaffName: row.actorStaffName,
      eventType: NotificationEventType.fromString(row.eventType),
      title: row.title,
      message: row.message,
      customerId: row.customerId,
      customerName: row.customerName,
      transactionId: row.transactionId,
      amountInPaisa: row.amountInPaisa,
      remainingBalanceInPaisa: row.remainingBalanceInPaisa,
      isRead: row.isRead,
      readAt: row.readAt,
      createdAt: row.createdAt,
    );
  }

  NotificationPreferences _prefsToDomain(NotificationPreferencesTableData row) {
    return NotificationPreferences(
      staffId: row.staffId,
      shopId: row.shopId,
      notifyOnCredit: row.notifyOnCredit,
      notifyOnPayment: row.notifyOnPayment,
      notifyOnFullClearance: row.notifyOnFullClearance,
      notifyOwnTransactions: row.notifyOwnTransactions,
      pushEnabled: row.pushEnabled,
      updatedAt: row.updatedAt,
    );
  }

  @override
  Stream<List<ShopNotification>> watchNotifications(
    String shopId, {
    String? recipientStaffId,
  }) {
    final query = _db.select(_db.notificationsTable)
      ..where((tbl) {
        final shopMatch = tbl.shopId.equals(shopId);
        if (recipientStaffId != null) {
          final recipientMatch = tbl.recipientStaffId.equals(recipientStaffId) |
              tbl.recipientStaffId.equals('all') |
              tbl.recipientStaffId.isNull();
          return shopMatch & recipientMatch;
        }
        return shopMatch;
      })
      ..orderBy([
        (tbl) => OrderingTerm(
              expression: tbl.createdAt,
              mode: OrderingMode.desc,
            ),
      ]);

    return query.watch().map((rows) => rows.map(_toDomain).toList());
  }

  @override
  Future<List<ShopNotification>> getNotifications(
    String shopId, {
    String? recipientStaffId,
  }) async {
    final query = _db.select(_db.notificationsTable)
      ..where((tbl) {
        final shopMatch = tbl.shopId.equals(shopId);
        if (recipientStaffId != null) {
          final recipientMatch = tbl.recipientStaffId.equals(recipientStaffId) |
              tbl.recipientStaffId.equals('all') |
              tbl.recipientStaffId.isNull();
          return shopMatch & recipientMatch;
        }
        return shopMatch;
      })
      ..orderBy([
        (tbl) => OrderingTerm(
              expression: tbl.createdAt,
              mode: OrderingMode.desc,
            ),
      ]);

    final rows = await query.get();
    return rows.map(_toDomain).toList();
  }

  @override
  Stream<int> watchUnreadCount(
    String shopId, {
    String? recipientStaffId,
  }) {
    final query = _db.selectOnly(_db.notificationsTable)
      ..addColumns([_db.notificationsTable.id.count()])
      ..where(_db.notificationsTable.shopId.equals(shopId))
      ..where(_db.notificationsTable.isRead.equals(false));

    if (recipientStaffId != null) {
      query.where(
        _db.notificationsTable.recipientStaffId.equals(recipientStaffId) |
            _db.notificationsTable.recipientStaffId.equals('all') |
            _db.notificationsTable.recipientStaffId.isNull(),
      );
    }

    return query.watchSingle().map((row) {
      return row.read(_db.notificationsTable.id.count()) ?? 0;
    });
  }

  @override
  Future<void> saveNotification(ShopNotification n) async {
    await _db.into(_db.notificationsTable).insertOnConflictUpdate(
          NotificationsTableCompanion.insert(
            id: n.id,
            shopId: n.shopId,
            recipientStaffId: Value(n.recipientStaffId),
            actorStaffId: Value(n.actorStaffId),
            actorStaffName: n.actorStaffName ?? 'Shop Staff',
            eventType: n.eventType.value,
            title: n.title,
            message: n.message,
            customerId: n.customerId ?? '',
            customerName: n.customerName ?? '',
            transactionId: Value(n.transactionId),
            amountInPaisa: Value(n.amountInPaisa ?? 0),
            remainingBalanceInPaisa: Value(n.remainingBalanceInPaisa ?? 0),
            isRead: Value(n.isRead),
            readAt: Value(n.readAt),
            createdAt: n.createdAt,
          ),
        );
  }

  @override
  Future<void> markAsRead(String id) async {
    await (_db.update(_db.notificationsTable)..where((t) => t.id.equals(id)))
        .write(
      NotificationsTableCompanion(
        isRead: const Value(true),
        readAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> markAllAsRead(
    String shopId, {
    String? recipientStaffId,
  }) async {
    final updateQuery = _db.update(_db.notificationsTable)
      ..where((t) {
        final shopMatch = t.shopId.equals(shopId);
        if (recipientStaffId != null) {
          final recipientMatch = t.recipientStaffId.equals(recipientStaffId) |
              t.recipientStaffId.equals('all') |
              t.recipientStaffId.isNull();
          return shopMatch & recipientMatch;
        }
        return shopMatch;
      });

    await updateQuery.write(
      NotificationsTableCompanion(
        isRead: const Value(true),
        readAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> dismissNotification(String id) async {
    await (_db.delete(_db.notificationsTable)..where((t) => t.id.equals(id)))
        .go();
  }

  @override
  Future<NotificationPreferences> getPreferences(
    String shopId,
    String staffId,
  ) async {
    final query = _db.select(_db.notificationPreferencesTable)
      ..where((t) => t.shopId.equals(shopId) & t.staffId.equals(staffId));
    final row = await query.getSingleOrNull();
    if (row == null) {
      return NotificationPreferences.defaultPreferences(
        staffId: staffId,
        shopId: shopId,
      );
    }
    return _prefsToDomain(row);
  }

  @override
  Stream<NotificationPreferences> watchPreferences(
    String shopId,
    String staffId,
  ) {
    final query = _db.select(_db.notificationPreferencesTable)
      ..where((t) => t.shopId.equals(shopId) & t.staffId.equals(staffId));
    return query.watchSingleOrNull().map((row) {
      if (row == null) {
        return NotificationPreferences.defaultPreferences(
          staffId: staffId,
          shopId: shopId,
        );
      }
      return _prefsToDomain(row);
    });
  }

  @override
  Future<void> savePreferences(NotificationPreferences prefs) async {
    await _db.into(_db.notificationPreferencesTable).insertOnConflictUpdate(
          NotificationPreferencesTableCompanion.insert(
            staffId: prefs.staffId,
            shopId: prefs.shopId,
            notifyOnCredit: Value(prefs.notifyOnCredit),
            notifyOnPayment: Value(prefs.notifyOnPayment),
            notifyOnFullClearance: Value(prefs.notifyOnFullClearance),
            notifyOwnTransactions: Value(prefs.notifyOwnTransactions),
            pushEnabled: Value(prefs.pushEnabled),
            updatedAt: prefs.updatedAt,
          ),
        );
  }

  @override
  Future<void> registerDeviceToken({
    required String shopId,
    required String staffId,
    required String token,
    required String platform,
  }) async {
    final tokenId = '${staffId}_${token.hashCode}';
    await _db.into(_db.deviceTokensTable).insertOnConflictUpdate(
          DeviceTokensTableCompanion.insert(
            id: tokenId,
            shopId: shopId,
            staffId: staffId,
            deviceToken: token,
            platform: platform,
            updatedAt: DateTime.now(),
          ),
        );
  }

  @override
  Future<void> removeDeviceToken(String token) async {
    await (_db.delete(_db.deviceTokensTable)
          ..where((t) => t.deviceToken.equals(token)))
        .go();
  }

  @override
  Future<List<DeviceTokensTableData>> getDeviceTokensForShop(
    String shopId,
  ) async {
    final query = _db.select(_db.deviceTokensTable)
      ..where((t) => t.shopId.equals(shopId));
    return query.get();
  }
}
