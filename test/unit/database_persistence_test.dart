import 'package:flutter_test/flutter_test.dart';
import 'package:udhaaro/data/local/app_database.dart';
import 'package:udhaaro/features/auth/data/auth_repository.dart';
import 'package:udhaaro/features/customers/data/customer_repository.dart';
import 'package:udhaaro/features/customers/models/customer.dart';
import 'package:udhaaro/features/ledger/data/transaction_repository.dart';
import 'package:udhaaro/features/ledger/models/ledger_transaction.dart';
import 'package:udhaaro/features/sync/data/sync_repository.dart';
import 'package:udhaaro/features/sync/models/pending_sync_op.dart';

void main() {
  late AppDatabase db;
  late AuthRepository authRepo;
  late CustomerRepository customerRepo;
  late TransactionRepository txRepo;
  late SyncRepository syncRepo;

  setUp(() {
    db = AppDatabase.memory();
    authRepo = AuthRepository(db);
    customerRepo = CustomerRepository(db);
    txRepo = TransactionRepository(db);
    syncRepo = SyncRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('Shop & Authentication Persistence', () {
    test(
      'Creates and retrieves shop profile with isolated owner UID',
      () async {
        final shop = await authRepo.createShop(
          name: 'Everest Kirana',
          phone: '9841000000',
          address: 'Thamel, Kathmandu',
        );

        expect(shop.name, 'Everest Kirana');
        expect(shop.phone, '9841000000');
        expect(shop.address, 'Thamel, Kathmandu');

        final currentShop = await authRepo.getCurrentShop();
        expect(currentShop, isNotNull);
        expect(currentShop!.id, shop.id);
        expect(currentShop.ownerUid, shop.ownerUid);
      },
    );

    test('Sign out clears the active shop session', () async {
      await authRepo.createShop(name: 'Test Shop');
      expect(await authRepo.getCurrentShop(), isNotNull);

      await authRepo.signOut();
      expect(await authRepo.getCurrentShop(), isNull);
    });
  });

  group('Customer Persistence and Search', () {
    test('Persists customer and enforces shop isolation', () async {
      final shop1 = await authRepo.createShop(name: 'Shop 1');
      final shop2 = await authRepo.createShop(name: 'Shop 2');

      final now = DateTime.now();
      final customer1 = Customer(
        id: 'cust_1',
        shopId: shop1.id,
        name: 'Hari Bahadur',
        phone: '9841111111',
        createdAt: now,
        updatedAt: now,
      );

      final customer2 = Customer(
        id: 'cust_2',
        shopId: shop2.id,
        name: 'Shyam Sundar',
        phone: '9842222222',
        createdAt: now,
        updatedAt: now,
      );

      await customerRepo.createCustomer(customer1);
      await customerRepo.createCustomer(customer2);

      // Verify shop 1 customers are isolated
      final shop1Customers = await customerRepo.getCustomers(shop1.id);
      expect(shop1Customers.length, 1);
      expect(shop1Customers.first.name, 'Hari Bahadur');

      // Verify search by name and phone
      final searchByName = await customerRepo.searchCustomers(shop1.id, 'hari');
      expect(searchByName.length, 1);

      final searchByPhone = await customerRepo.searchCustomers(
        shop1.id,
        '9841',
      );
      expect(searchByPhone.length, 1);

      final searchNotFound = await customerRepo.searchCustomers(
        shop1.id,
        'unknown',
      );
      expect(searchNotFound.isEmpty, isTrue);
    });
  });

  group('Financial Transactions & Authoritative Balances', () {
    test('Mandatory End-to-End User Journey ledger operations', () async {
      final shop = await authRepo.createShop(name: 'Main Khata');
      final now = DateTime.now();
      final customer = Customer(
        id: 'cust_main',
        shopId: shop.id,
        name: 'Bikash Shrestha',
        phone: '9851000000',
        createdAt: now,
        updatedAt: now,
      );
      await customerRepo.createCustomer(customer);

      // Initial balance must be zero
      final initialBalance = await txRepo.getCustomerBalance(customer.id);
      expect(initialBalance.outstandingBalanceInPaisa, 0);

      // Step 4 & 5: Record NPR 1,000 credit (100,000 paisa)
      final creditTx = LedgerTransaction(
        id: 'tx_credit_1',
        shopId: shop.id,
        customerId: customer.id,
        type: TransactionType.credit,
        amountInPaisa: 100000,
        note: 'Rice and cooking oil',
        createdAt: now,
      );
      await txRepo.recordTransaction(creditTx);

      final balanceAfterCredit = await txRepo.getCustomerBalance(customer.id);
      expect(
        balanceAfterCredit.outstandingBalanceInPaisa,
        100000,
      ); // Exactly Rs 1,000

      // Step 6 & 7: Record NPR 300 payment (30,000 paisa)
      final paymentTx = LedgerTransaction(
        id: 'tx_payment_1',
        shopId: shop.id,
        customerId: customer.id,
        type: TransactionType.payment,
        amountInPaisa: 30000,
        note: 'Partial cash payment',
        createdAt: now.add(const Duration(minutes: 10)),
      );
      await txRepo.recordTransaction(paymentTx);

      final balanceAfterPayment = await txRepo.getCustomerBalance(customer.id);
      expect(
        balanceAfterPayment.outstandingBalanceInPaisa,
        70000,
      ); // Exactly Rs 700

      // Step 8: Inspect transaction history (reverse chronological order)
      final history = await txRepo.getTransactionsForCustomer(customer.id);
      expect(history.length, 2);
      expect(history.first.id, 'tx_payment_1'); // newest first
      expect(history.last.id, 'tx_credit_1');
    });

    test('Prevents accidental overpayment via transaction boundary', () async {
      final shop = await authRepo.createShop(name: 'Shop');
      final now = DateTime.now();
      final customer = Customer(
        id: 'cust_overpay',
        shopId: shop.id,
        name: 'Overpay Test',
        createdAt: now,
        updatedAt: now,
      );
      await customerRepo.createCustomer(customer);

      // Give 500 Rs credit (50,000 paisa)
      await txRepo.recordTransaction(
        LedgerTransaction(
          id: 'tx_c',
          shopId: shop.id,
          customerId: customer.id,
          type: TransactionType.credit,
          amountInPaisa: 50000,
          createdAt: now,
        ),
      );

      // Attempting to record 600 Rs payment (60,000 paisa) must fail with StateError
      expect(
        () => txRepo.recordTransaction(
          LedgerTransaction(
            id: 'tx_p_fail',
            shopId: shop.id,
            customerId: customer.id,
            type: TransactionType.payment,
            amountInPaisa: 60000,
            createdAt: now.add(const Duration(seconds: 1)),
          ),
        ),
        throwsA(isA<StateError>()),
      );

      // Balance remains strictly Rs 500
      final balance = await txRepo.getCustomerBalance(customer.id);
      expect(balance.outstandingBalanceInPaisa, 50000);
    });
  });

  group('Offline Sync Queue Durability', () {
    test('Queues and removes pending operations correctly', () async {
      final shop = await authRepo.createShop(name: 'Sync Shop');
      final now = DateTime.now();

      final op1 = PendingSyncOp(
        id: 'op_1',
        shopId: shop.id,
        entityType: 'customer',
        entityId: 'c1',
        operationType: 'create',
        payloadJson: '{"id":"c1"}',
        createdAt: now,
      );

      final op2 = PendingSyncOp(
        id: 'op_2',
        shopId: shop.id,
        entityType: 'transaction',
        entityId: 't1',
        operationType: 'create',
        payloadJson: '{"id":"t1"}',
        createdAt: now.add(const Duration(seconds: 1)),
      );

      await syncRepo.queueOperation(op1);
      await syncRepo.queueOperation(op2);

      expect(await syncRepo.getPendingCount(shop.id), 2);

      final ops = await syncRepo.getPendingOperations(shop.id);
      expect(ops.length, 2);
      expect(ops.first.id, 'op_1');

      // Remove first op when synced
      await syncRepo.removeOperation('op_1');
      expect(await syncRepo.getPendingCount(shop.id), 1);
    });
  });
}
