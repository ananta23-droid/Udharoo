import 'package:flutter_test/flutter_test.dart';
import 'package:udhaaro/core/utils/input_validators.dart';
import 'package:udhaaro/data/local/app_database.dart';
import 'package:udhaaro/features/audit/data/audit_repository.dart';
import 'package:udhaaro/features/ledger/models/ledger_transaction.dart';
import 'package:udhaaro/features/settings/data/settings_repository.dart';
import 'package:udhaaro/features/settings/models/shop_settings.dart';
import 'package:udhaaro/features/staff/data/staff_repository.dart';
import 'package:udhaaro/features/staff/models/staff.dart';

void main() {
  group('InputValidators Tests', () {
    test('Customer Name validation', () {
      expect(InputValidators.validateCustomerName(''), 'Customer name is required');
      expect(InputValidators.validateCustomerName('A'), 'Name must be at least 2 characters');
      expect(InputValidators.validateCustomerName('Sita Devi'), isNull);
    });

    test('Mandatory Phone validation', () {
      expect(InputValidators.validatePhone('', required: true), 'Phone number is required');
      expect(InputValidators.validatePhone('123', required: true), 'Enter a valid phone number (7-15 digits)');
      expect(InputValidators.validatePhone('9841234567', required: true), isNull);
      expect(InputValidators.validatePhone('980-123-4567', required: true), isNull);
    });

    test('Mandatory Email validation', () {
      expect(InputValidators.validateEmail('', required: true), 'Email address is required');
      expect(InputValidators.validateEmail('invalid-email', required: true), 'Enter a valid email address');
      expect(InputValidators.validateEmail('ram@gmail.com', required: true), isNull);
      expect(InputValidators.validateEmail(null, required: false), isNull);
    });
  });

  group('Staff & Roles Tests', () {
    late AppDatabase db;
    late StaffRepository staffRepo;

    setUp(() {
      db = AppDatabase.memory();
      staffRepo = StaffRepository(db);
    });

    tearDown(() async {
      await db.close();
    });

    test('Staff CRUD and activation toggle', () async {
      final now = DateTime.now();
      final cashier = Staff(
        id: 'staff-1',
        shopId: 'shop-1',
        name: 'Hari Prasad',
        email: 'hari@udhaaro.local',
        phone: '9841000001',
        role: StaffRole.cashier,
        isActive: true,
        createdAt: now,
        updatedAt: now,
      );

      await staffRepo.createStaff(cashier);

      final list = await staffRepo.getStaffForShop('shop-1');
      expect(list.length, 1);
      expect(list.first.name, 'Hari Prasad');
      expect(list.first.roleDisplay, 'Cashier');
      expect(list.first.isActive, isTrue);

      // Toggle inactive
      await staffRepo.toggleStaffStatus('staff-1', false);
      final activeList = await staffRepo.watchActiveStaff('shop-1').first;
      expect(activeList, isEmpty);

      // Toggle active
      await staffRepo.toggleStaffStatus('staff-1', true);
      final activeList2 = await staffRepo.watchActiveStaff('shop-1').first;
      expect(activeList2.length, 1);
    });

    test('StaffRole permissions', () {
      expect(StaffRole.owner.canModifySettings, isTrue);
      expect(StaffRole.cashier.canModifySettings, isFalse);
      expect(StaffRole.cashier.canRecordTransactions, isTrue);
      expect(StaffRole.readOnly.canRecordTransactions, isFalse);
    });
  });

  group('Shop Settings & Payment Terms Tests', () {
    late AppDatabase db;
    late SettingsRepository settingsRepo;

    setUp(() {
      db = AppDatabase.memory();
      settingsRepo = SettingsRepository(db);
    });

    tearDown(() async {
      await db.close();
    });

    test('Save and retrieve configurable repayment terms and reminders', () async {
      final customSettings = ShopSettings(
        shopId: 'shop-1',
        defaultRepaymentDays: 45,
        emailRemindersEnabled: true,
        senderEmail: 'shop@nepal.com',
        reminderIntervalDays: 7,
        smsRemindersEnabled: true,
        updatedAt: DateTime.now(),
      );

      await settingsRepo.saveSettings(customSettings);
      final retrieved = await settingsRepo.getSettings('shop-1');

      expect(retrieved.defaultRepaymentDays, 45);
      expect(retrieved.emailRemindersEnabled, isTrue);
      expect(retrieved.smsRemindersEnabled, isTrue);
      expect(retrieved.reminderIntervalDays, 7);
    });
  });

  group('Audit Repository Tests', () {
    late AppDatabase db;
    late AuditRepository auditRepo;

    setUp(() {
      db = AppDatabase.memory();
      auditRepo = AuditRepository(db);
    });

    tearDown(() async {
      await db.close();
    });

    test('Log and watch audit actions', () async {
      final t1 = DateTime(2026, 1, 1, 10, 0, 0);
      final t2 = DateTime(2026, 1, 1, 10, 0, 10);

      await auditRepo.logAction(
        shopId: 'shop-1',
        actorId: 'owner-1',
        actorName: 'Shop Owner',
        action: 'credit_created',
        entityType: 'transaction',
        entityId: 'tx-1',
        detailsJson: '{"amount": 5000}',
        createdAt: t1,
      );

      await auditRepo.logAction(
        shopId: 'shop-1',
        actorId: 'staff-1',
        actorName: 'Cashier Ram',
        action: 'payment_recorded',
        entityType: 'transaction',
        entityId: 'tx-2',
        detailsJson: '{"amount": 2000}',
        createdAt: t2,
      );

      final logs = await auditRepo.watchAuditLogs('shop-1').first;
      expect(logs.length, 2);
      expect(logs.first.action, 'payment_recorded'); // newest first
      expect(logs.first.actionDisplayText, 'Payment Received');
      expect(logs.last.action, 'credit_created');
      expect(logs.last.actionDisplayText, 'Credit Recorded');
    });
  });

  group('LedgerTransaction Overdue Logic', () {
    test('Calculates overdue correctly based on dueDate', () {
      final now = DateTime.now();

      final overdueTx = LedgerTransaction(
        id: 'tx-1',
        shopId: 'shop-1',
        customerId: 'c-1',
        type: TransactionType.credit,
        amountInPaisa: 100000,
        dueDate: now.subtract(const Duration(days: 5)),
        createdAt: now.subtract(const Duration(days: 35)),
      );
      expect(overdueTx.isOverdue, isTrue);

      final futureTx = LedgerTransaction(
        id: 'tx-2',
        shopId: 'shop-1',
        customerId: 'c-1',
        type: TransactionType.credit,
        amountInPaisa: 100000,
        dueDate: now.add(const Duration(days: 10)),
        createdAt: now,
      );
      expect(futureTx.isOverdue, isFalse);

      final paymentTx = LedgerTransaction(
        id: 'tx-3',
        shopId: 'shop-1',
        customerId: 'c-1',
        type: TransactionType.payment,
        amountInPaisa: 50000,
        dueDate: now.subtract(const Duration(days: 5)),
        createdAt: now,
      );
      expect(paymentTx.isOverdue, isFalse);
    });
  });
}
