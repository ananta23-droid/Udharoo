import 'package:drift/drift.dart';

import '../../../data/local/app_database.dart';
import '../models/balance_summary.dart';
import '../models/ledger_transaction.dart';

class TransactionRepository {
  final AppDatabase _db;

  TransactionRepository(this._db);

  /// Streams all transactions for a specific customer in reverse chronological order (newest first).
  Stream<List<LedgerTransaction>> watchTransactionsForCustomer(
    String customerId,
  ) {
    final query = _db.select(_db.transactionsTable)
      ..where((tbl) => tbl.customerId.equals(customerId))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);

    return query.watch().map((rows) => rows.map(_mapRowToTransaction).toList());
  }

  /// Streams recent transactions across the shop.
  Stream<List<LedgerTransaction>> watchRecentTransactions(
    String shopId, {
    int limit = 15,
  }) {
    final query = _db.select(_db.transactionsTable)
      ..where((tbl) => tbl.shopId.equals(shopId))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
      ..limit(limit);

    return query.watch().map((rows) => rows.map(_mapRowToTransaction).toList());
  }

  /// Gets all transactions for a customer.
  Future<List<LedgerTransaction>> getTransactionsForCustomer(
    String customerId,
  ) async {
    final query = _db.select(_db.transactionsTable)
      ..where((tbl) => tbl.customerId.equals(customerId))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);

    final rows = await query.get();
    return rows.map(_mapRowToTransaction).toList();
  }

  /// Gets all transactions for the entire shop.
  Future<List<LedgerTransaction>> getAllTransactionsForShop(
    String shopId,
  ) async {
    final query = _db.select(_db.transactionsTable)
      ..where((tbl) => tbl.shopId.equals(shopId))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);

    final rows = await query.get();
    return rows.map(_mapRowToTransaction).toList();
  }

  /// Calculates authoritative balance for a customer directly from ledger transactions.
  Future<BalanceSummary> getCustomerBalance(String customerId) async {
    final txs = await getTransactionsForCustomer(customerId);
    return BalanceSummary.fromTransactions(txs);
  }

  /// Watches authoritative balance for a customer.
  Stream<BalanceSummary> watchCustomerBalance(String customerId) {
    return watchTransactionsForCustomer(customerId)
        .map((txs) => BalanceSummary.fromTransactions(txs));
  }

  /// Calculates total shop balance across all customers.
  Future<BalanceSummary> getShopTotalBalance(String shopId) async {
    final txs = await getAllTransactionsForShop(shopId);
    return BalanceSummary.fromTransactions(txs);
  }

  /// Watches total shop balance across all transactions.
  Stream<BalanceSummary> watchShopTotalBalance(String shopId) {
    final query = _db.select(_db.transactionsTable)
      ..where((tbl) => tbl.shopId.equals(shopId));

    return query.watch().map((rows) {
      final txs = rows.map(_mapRowToTransaction);
      return BalanceSummary.fromTransactions(txs);
    });
  }

  /// Atomically commits a transaction and touches the customer's updated timestamp.
  /// Validates amount > 0 and overpayment prevention for payments.
  Future<void> recordTransaction(LedgerTransaction transaction) async {
    if (transaction.amountInPaisa <= 0) {
      throw ArgumentError('Transaction amount must be strictly positive');
    }

    await _db.transaction(() async {
      // If it is a payment, re-validate current authoritative balance inside transaction boundary
      if (transaction.type == TransactionType.payment) {
        final existingTxs = await (_db.select(
          _db.transactionsTable,
        )..where((tbl) => tbl.customerId.equals(transaction.customerId))).get();

        final currentBalance = BalanceSummary.fromTransactions(
          existingTxs.map(_mapRowToTransaction),
        ).outstandingBalanceInPaisa;

        if (transaction.amountInPaisa > currentBalance) {
          throw StateError(
            'Payment amount (${transaction.amountInPaisa}) cannot exceed current outstanding balance ($currentBalance)',
          );
        }
      }

      // Insert transaction with idempotent insertOrReplace
      await _db
          .into(_db.transactionsTable)
          .insert(
            TransactionsTableCompanion.insert(
              id: transaction.id,
              shopId: transaction.shopId,
              customerId: transaction.customerId,
              type: transaction.type.name,
              amountInPaisa: transaction.amountInPaisa,
              note: Value(transaction.note?.trim()),
              staffId: Value(transaction.staffId),
              staffName: Value(transaction.staffName),
              dueDate: Value(transaction.dueDate),
              paymentMethod: Value(transaction.paymentMethod),
              createdAt: transaction.createdAt,
              syncStatus: Value(transaction.syncStatus),
            ),
            mode: InsertMode.insertOrReplace,
          );

      // Touch customer updated timestamp
      await (_db.update(
        _db.customersTable,
      )..where((t) => t.id.equals(transaction.customerId))).write(
        CustomersTableCompanion(updatedAt: Value(transaction.createdAt)),
      );
    });
  }

  /// Updates transaction sync status.
  Future<void> updateSyncStatus(String transactionId, String status) async {
    await (_db.update(_db.transactionsTable)
          ..where((t) => t.id.equals(transactionId)))
        .write(TransactionsTableCompanion(syncStatus: Value(status)));
  }

  LedgerTransaction _mapRowToTransaction(TransactionsTableData row) {
    return LedgerTransaction(
      id: row.id,
      shopId: row.shopId,
      customerId: row.customerId,
      type: TransactionType.values.byName(row.type),
      amountInPaisa: row.amountInPaisa,
      note: row.note,
      staffId: row.staffId,
      staffName: row.staffName,
      dueDate: row.dueDate,
      paymentMethod: row.paymentMethod,
      createdAt: row.createdAt,
      syncStatus: row.syncStatus,
    );
  }
}
