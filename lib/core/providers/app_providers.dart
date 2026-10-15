import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/app_database.dart';
import '../../features/auth/data/auth_repository.dart';
import '../../features/auth/models/shop.dart';
import '../../features/customers/data/customer_repository.dart';
import '../../features/customers/models/customer.dart';
import '../../features/ledger/data/transaction_repository.dart';
import '../../features/ledger/models/balance_summary.dart';
import '../../features/ledger/models/ledger_transaction.dart';
import '../../features/sync/data/sync_repository.dart';
import '../../features/sync/data/sync_service.dart';
import '../../features/staff/data/staff_repository.dart';
import '../../features/staff/models/staff.dart';
import '../../features/settings/data/settings_repository.dart';
import '../../features/settings/models/shop_settings.dart';
import '../../features/audit/data/audit_repository.dart';
import '../../features/audit/models/audit_log_entry.dart';
import '../../features/notifications/data/notification_repository.dart';
import '../../features/notifications/data/notification_dispatch_service.dart';
import '../../features/notifications/models/shop_notification.dart';
import '../../features/notifications/models/notification_preferences.dart';
import '../../features/notifications/data/fcm_token_manager.dart';

// Database Provider
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

// Repository Providers
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(databaseProvider));
});

final customerRepositoryProvider = Provider<CustomerRepository>((ref) {
  return CustomerRepository(ref.watch(databaseProvider));
});

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  return TransactionRepository(ref.watch(databaseProvider));
});

final syncRepositoryProvider = Provider<SyncRepository>((ref) {
  return SyncRepository(ref.watch(databaseProvider));
});

final syncServiceProvider = Provider<SyncService>((ref) {
  final service = SyncService(
    syncRepo: ref.watch(syncRepositoryProvider),
    customerRepo: ref.watch(customerRepositoryProvider),
    txRepo: ref.watch(transactionRepositoryProvider),
  );
  ref.onDispose(() => service.dispose());
  return service;
});

final auditRepositoryProvider = Provider<AuditRepository>((ref) {
  return AuditRepository(ref.watch(databaseProvider));
});

final staffRepositoryProvider = Provider<StaffRepository>((ref) {
  return StaffRepository(ref.watch(databaseProvider));
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepository(ref.watch(databaseProvider));
});

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return DriftNotificationRepository(ref.watch(databaseProvider));
});

final notificationDispatchServiceProvider =
    Provider<NotificationDispatchService>((ref) {
  return NotificationDispatchService(
    notificationRepository: ref.watch(notificationRepositoryProvider),
    staffRepository: ref.watch(staffRepositoryProvider),
  );
});

final fcmTokenManagerProvider = Provider<FcmTokenManager>((ref) {
  return FcmTokenManager(ref.watch(notificationRepositoryProvider));
});

// Current Active Shop Stream
final currentShopProvider = StreamProvider<Shop?>((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  return authRepo.watchCurrentShop();
});

// Shop Customers Stream
final customersListProvider = StreamProvider<List<Customer>>((ref) {
  final shopAsync = ref.watch(currentShopProvider);
  final shop = shopAsync.value;
  if (shop == null) return Stream.value([]);
  final customerRepo = ref.watch(customerRepositoryProvider);
  return customerRepo.watchCustomers(shop.id);
});

// Single Customer Stream
final customerDetailProvider = StreamProvider.family<Customer?, String>((
  ref,
  customerId,
) {
  final customerRepo = ref.watch(customerRepositoryProvider);
  return customerRepo.watchCustomerById(customerId);
});

// Customer Transactions Stream
final customerTransactionsProvider =
    StreamProvider.family<List<LedgerTransaction>, String>((ref, customerId) {
      final txRepo = ref.watch(transactionRepositoryProvider);
      return txRepo.watchTransactionsForCustomer(customerId);
    });

// Customer Balance Stream
final customerBalanceProvider = StreamProvider.family<BalanceSummary, String>((
  ref,
  customerId,
) {
  final txRepo = ref.watch(transactionRepositoryProvider);
  return txRepo.watchCustomerBalance(customerId);
});

// Shop Total Balance Stream
final shopTotalBalanceProvider = StreamProvider<BalanceSummary>((ref) {
  final shopAsync = ref.watch(currentShopProvider);
  final shop = shopAsync.value;
  if (shop == null) return Stream.value(BalanceSummary.zero);
  final txRepo = ref.watch(transactionRepositoryProvider);
  return txRepo.watchShopTotalBalance(shop.id);
});

// Recent Shop Transactions Stream
final recentTransactionsProvider = StreamProvider<List<LedgerTransaction>>((
  ref,
) {
  final shopAsync = ref.watch(currentShopProvider);
  final shop = shopAsync.value;
  if (shop == null) return Stream.value([]);
  final txRepo = ref.watch(transactionRepositoryProvider);
  return txRepo.watchRecentTransactions(shop.id, limit: 10);
});

// Pending Sync Count Stream
final pendingSyncCountProvider = StreamProvider<int>((ref) {
  final shopAsync = ref.watch(currentShopProvider);
  final shop = shopAsync.value;
  if (shop == null) return Stream.value(0);
  final syncRepo = ref.watch(syncRepositoryProvider);
  return syncRepo.watchPendingCount(shop.id);
});

// Shop Staff Stream (all staff)
final staffListProvider = StreamProvider<List<Staff>>((ref) {
  final shopAsync = ref.watch(currentShopProvider);
  final shop = shopAsync.value;
  if (shop == null) return Stream.value([]);
  final staffRepo = ref.watch(staffRepositoryProvider);
  return staffRepo.watchStaff(shop.id);
});

// Active Staff Stream (for transaction dropdowns)
final activeStaffListProvider = StreamProvider<List<Staff>>((ref) {
  final shopAsync = ref.watch(currentShopProvider);
  final shop = shopAsync.value;
  if (shop == null) return Stream.value([]);
  final staffRepo = ref.watch(staffRepositoryProvider);
  return staffRepo.watchActiveStaff(shop.id);
});

// Shop Settings Stream
final shopSettingsProvider = StreamProvider<ShopSettings>((ref) {
  final shopAsync = ref.watch(currentShopProvider);
  final shop = shopAsync.value;
  if (shop == null) return Stream.value(ShopSettings.defaultSettings(''));
  final settingsRepo = ref.watch(settingsRepositoryProvider);
  return settingsRepo.watchSettings(shop.id);
});

// Shop Audit Logs Stream
final shopAuditLogsProvider = StreamProvider<List<AuditLogEntry>>((ref) {
  final shopAsync = ref.watch(currentShopProvider);
  final shop = shopAsync.value;
  if (shop == null) return Stream.value([]);
  final auditRepo = ref.watch(auditRepositoryProvider);
  return auditRepo.watchAuditLogs(shop.id);
});

// Currently Active Staff Actor for ledger transactions
class CurrentStaffActorNotifier extends Notifier<Staff?> {
  @override
  Staff? build() => null;

  void setStaff(Staff? staff) {
    state = staff;
  }

  @override
  set state(Staff? val) => super.state = val;
}

final currentStaffActorProvider =
    NotifierProvider<CurrentStaffActorNotifier, Staff?>(
  CurrentStaffActorNotifier.new,
);

// Shop Notifications Stream
final shopNotificationsProvider =
    StreamProvider<List<ShopNotification>>((ref) {
  final shopAsync = ref.watch(currentShopProvider);
  final shop = shopAsync.value;
  if (shop == null) return Stream.value([]);
  final activeStaff = ref.watch(currentStaffActorProvider);
  final notificationRepo = ref.watch(notificationRepositoryProvider);
  return notificationRepo.watchNotifications(
    shop.id,
    recipientStaffId: activeStaff?.id,
  );
});

// Real-Time Unread Notification Count Stream
final unreadNotificationCountProvider = StreamProvider<int>((ref) {
  final shopAsync = ref.watch(currentShopProvider);
  final shop = shopAsync.value;
  if (shop == null) return Stream.value(0);
  final activeStaff = ref.watch(currentStaffActorProvider);
  final notificationRepo = ref.watch(notificationRepositoryProvider);
  return notificationRepo.watchUnreadCount(
    shop.id,
    recipientStaffId: activeStaff?.id,
  );
});

// Staff Notification Preferences Stream
final staffNotificationPreferencesProvider =
    StreamProvider.family<NotificationPreferences, String>((ref, staffId) {
  final shopAsync = ref.watch(currentShopProvider);
  final shop = shopAsync.value;
  if (shop == null) {
    return Stream.value(
      NotificationPreferences.defaultPreferences(
        staffId: staffId,
        shopId: '',
      ),
    );
  }
  final notificationRepo = ref.watch(notificationRepositoryProvider);
  return notificationRepo.watchPreferences(shop.id, staffId);
});

