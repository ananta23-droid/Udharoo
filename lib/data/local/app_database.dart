import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class ShopsTable extends Table {
  @override
  String get tableName => 'shops';

  TextColumn get id => text()();
  TextColumn get ownerUid => text()();
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get address => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class CustomersTable extends Table {
  @override
  String get tableName => 'customers';

  TextColumn get id => text()();
  TextColumn get shopId => text()();
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

class TransactionsTable extends Table {
  @override
  String get tableName => 'transactions';

  TextColumn get id => text()();
  TextColumn get shopId => text()();
  TextColumn get customerId => text()();
  TextColumn get type => text()(); // 'credit', 'payment'
  IntColumn get amountInPaisa => integer()();
  TextColumn get note => text().nullable()();
  TextColumn get staffId => text().nullable()();
  TextColumn get staffName => text().nullable()();
  DateTimeColumn get dueDate => dateTime().nullable()();
  TextColumn get paymentMethod => text().nullable()(); // 'cash', 'fonepay', 'esewa', 'bank_transfer', etc.
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

class StaffTable extends Table {
  @override
  String get tableName => 'staff';

  TextColumn get id => text()();
  TextColumn get shopId => text()();
  TextColumn get name => text()();
  TextColumn get email => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get role => text().withDefault(const Constant('cashier'))(); // 'owner', 'manager', 'accountant', 'cashier', 'read_only'
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class ShopSettingsTable extends Table {
  @override
  String get tableName => 'shop_settings';

  TextColumn get shopId => text()();
  IntColumn get defaultRepaymentDays => integer().withDefault(const Constant(30))();
  BoolColumn get emailRemindersEnabled => boolean().withDefault(const Constant(false))();
  TextColumn get senderEmail => text().nullable()();
  IntColumn get reminderIntervalDays => integer().withDefault(const Constant(3))();
  BoolColumn get smsRemindersEnabled => boolean().withDefault(const Constant(false))();
  TextColumn get smsProviderConfigJson => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {shopId};
}

class AuditLogsTable extends Table {
  @override
  String get tableName => 'audit_logs';

  TextColumn get id => text()();
  TextColumn get shopId => text()();
  TextColumn get actorId => text().nullable()();
  TextColumn get actorName => text().nullable()();
  TextColumn get action => text()();
  TextColumn get entityType => text()();
  TextColumn get entityId => text()();
  TextColumn get detailsJson => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class ReminderLogsTable extends Table {
  @override
  String get tableName => 'reminder_logs';

  TextColumn get id => text()();
  TextColumn get shopId => text()();
  TextColumn get customerId => text()();
  TextColumn get customerName => text()();
  TextColumn get recipient => text()();
  TextColumn get type => text()(); // 'email', 'sms'
  TextColumn get title => text()();
  TextColumn get content => text()();
  TextColumn get status => text().withDefault(const Constant('sent'))();
  DateTimeColumn get scheduledFor => dateTime()();
  DateTimeColumn get sentAt => dateTime().nullable()();
  TextColumn get errorMessage => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class PendingSyncOperationsTable extends Table {
  @override
  String get tableName => 'pending_sync_operations';

  TextColumn get id => text()();
  TextColumn get shopId => text()();
  TextColumn get entityType => text()(); // 'customer', 'transaction', 'shop', 'staff', 'settings', 'notification'
  TextColumn get entityId => text()();
  TextColumn get operationType => text()(); // 'create', 'update'
  TextColumn get payloadJson => text()();
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class NotificationsTable extends Table {
  @override
  String get tableName => 'notifications';

  TextColumn get id => text()();
  TextColumn get shopId => text()();
  TextColumn get recipientStaffId => text().nullable()(); // null means all shop staff
  TextColumn get actorStaffId => text().nullable()();
  TextColumn get actorStaffName => text()();
  TextColumn get eventType => text()(); // 'credit_created', 'payment_received', 'invoice_cleared', 'customer_settled', 'credit_updated', 'payment_reversed'
  TextColumn get title => text()();
  TextColumn get message => text()();
  TextColumn get customerId => text()();
  TextColumn get customerName => text()();
  TextColumn get transactionId => text().nullable()();
  IntColumn get amountInPaisa => integer().withDefault(const Constant(0))();
  IntColumn get remainingBalanceInPaisa => integer().withDefault(const Constant(0))();
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
  DateTimeColumn get readAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class DeviceTokensTable extends Table {
  @override
  String get tableName => 'device_tokens';

  TextColumn get id => text()();
  TextColumn get shopId => text()();
  TextColumn get staffId => text()();
  TextColumn get deviceToken => text()();
  TextColumn get platform => text()(); // 'android', 'ios', 'web'
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class NotificationPreferencesTable extends Table {
  @override
  String get tableName => 'notification_preferences';

  TextColumn get staffId => text()();
  TextColumn get shopId => text()();
  BoolColumn get notifyOnCredit => boolean().withDefault(const Constant(true))();
  BoolColumn get notifyOnPayment => boolean().withDefault(const Constant(true))();
  BoolColumn get notifyOnFullClearance => boolean().withDefault(const Constant(true))();
  BoolColumn get notifyOwnTransactions => boolean().withDefault(const Constant(false))();
  BoolColumn get pushEnabled => boolean().withDefault(const Constant(true))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {staffId};
}

@DriftDatabase(
  tables: [
    ShopsTable,
    CustomersTable,
    TransactionsTable,
    StaffTable,
    ShopSettingsTable,
    AuditLogsTable,
    ReminderLogsTable,
    PendingSyncOperationsTable,
    NotificationsTable,
    DeviceTokensTable,
    NotificationPreferencesTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        // Create indexes for efficient querying
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_customers_shop_id ON customers(shop_id);',
        );
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_transactions_customer_id ON transactions(customer_id);',
        );
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_transactions_shop_id ON transactions(shop_id);',
        );
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_staff_shop_id ON staff(shop_id);',
        );
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_audit_shop_id ON audit_logs(shop_id);',
        );
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_reminder_shop_id ON reminder_logs(shop_id);',
        );
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_pending_sync_shop_id ON pending_sync_operations(shop_id);',
        );
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_notifications_shop_id ON notifications(shop_id);',
        );
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_notifications_recipient ON notifications(recipient_staff_id);',
        );
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_device_tokens_shop_id ON device_tokens(shop_id);',
        );
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.addColumn(customersTable, customersTable.email);
          await m.addColumn(transactionsTable, transactionsTable.staffId);
          await m.addColumn(transactionsTable, transactionsTable.staffName);
          await m.addColumn(transactionsTable, transactionsTable.dueDate);
          await m.addColumn(transactionsTable, transactionsTable.paymentMethod);
          await m.createTable(staffTable);
          await m.createTable(shopSettingsTable);
          await m.createTable(auditLogsTable);
          await m.createTable(reminderLogsTable);
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_staff_shop_id ON staff(shop_id);',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_audit_shop_id ON audit_logs(shop_id);',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_reminder_shop_id ON reminder_logs(shop_id);',
          );
        }
        if (from < 3) {
          await m.createTable(notificationsTable);
          await m.createTable(deviceTokensTable);
          await m.createTable(notificationPreferencesTable);
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_notifications_shop_id ON notifications(shop_id);',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_notifications_recipient ON notifications(recipient_staff_id);',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_device_tokens_shop_id ON device_tokens(shop_id);',
          );
        }
      },
      beforeOpen: (details) async {
        // Enforce SQLite Foreign Keys & WAL mode for high performance
        await customStatement('PRAGMA foreign_keys = ON');
        await customStatement('PRAGMA journal_mode = WAL');
      },
    );
  }

  // Factory constructor for memory database (ideal for unit & business-logic tests)
  factory AppDatabase.memory() {
    return AppDatabase(NativeDatabase.memory());
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'udhaaro_ledger.sqlite'));
    return NativeDatabase(file);
  });
}
