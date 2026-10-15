import 'package:drift/drift.dart';

import '../../../data/local/app_database.dart';
import '../models/customer.dart';

class CustomerRepository {
  final AppDatabase _db;

  CustomerRepository(this._db);

  /// Streams all customers belonging to the shop, ordered by most recently updated.
  Stream<List<Customer>> watchCustomers(String shopId) {
    final query = _db.select(_db.customersTable)
      ..where((tbl) => tbl.shopId.equals(shopId))
      ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]);

    return query.watch().map((rows) => rows.map(_mapRowToCustomer).toList());
  }

  /// Gets all customers belonging to the shop.
  Future<List<Customer>> getCustomers(String shopId) async {
    final query = _db.select(_db.customersTable)
      ..where((tbl) => tbl.shopId.equals(shopId))
      ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]);

    final rows = await query.get();
    return rows.map(_mapRowToCustomer).toList();
  }

  /// Gets a specific customer by ID.
  Future<Customer?> getCustomerById(String customerId) async {
    final query = _db.select(_db.customersTable)
      ..where((tbl) => tbl.id.equals(customerId));
    final row = await query.getSingleOrNull();
    if (row == null) return null;
    return _mapRowToCustomer(row);
  }

  /// Watches a specific customer by ID.
  Stream<Customer?> watchCustomerById(String customerId) {
    final query = _db.select(_db.customersTable)
      ..where((tbl) => tbl.id.equals(customerId));
    return query.watchSingleOrNull().map(
      (row) => row != null ? _mapRowToCustomer(row) : null,
    );
  }

  /// Creates a new customer in SQLite.
  Future<void> createCustomer(Customer customer) async {
    await _db
        .into(_db.customersTable)
        .insert(
          CustomersTableCompanion.insert(
            id: customer.id,
            shopId: customer.shopId,
            name: customer.name.trim(),
            phone: Value(customer.phone?.trim()),
            email: Value(customer.email?.trim().toLowerCase()),
            createdAt: customer.createdAt,
            updatedAt: customer.updatedAt,
            syncStatus: Value(customer.syncStatus),
          ),
          mode: InsertMode.insertOrReplace,
        );
  }

  /// Updates an existing customer in SQLite.
  Future<void> updateCustomer(Customer customer) async {
    await (_db.update(
      _db.customersTable,
    )..where((t) => t.id.equals(customer.id))).write(
      CustomersTableCompanion(
        name: Value(customer.name.trim()),
        phone: Value(customer.phone?.trim()),
        email: Value(customer.email?.trim().toLowerCase()),
        updatedAt: Value(customer.updatedAt),
        syncStatus: Value(customer.syncStatus),
      ),
    );
  }

  /// Searches customers by name, phone, or email within the given shop.
  Future<List<Customer>> searchCustomers(String shopId, String query) async {
    final cleanQuery = query.trim().toLowerCase();
    if (cleanQuery.isEmpty) {
      return getCustomers(shopId);
    }

    final queryObj = _db.select(_db.customersTable)
      ..where(
        (tbl) =>
            tbl.shopId.equals(shopId) &
            (tbl.name.lower().contains(cleanQuery) |
                tbl.phone.lower().contains(cleanQuery) |
                tbl.email.lower().contains(cleanQuery)),
      )
      ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]);

    final rows = await queryObj.get();
    return rows.map(_mapRowToCustomer).toList();
  }

  /// Deletes customer if no transactions exist, preventing orphaned records.
  Future<void> deleteCustomer(String customerId) async {
    await (_db.delete(_db.customersTable)..where((t) => t.id.equals(customerId))).go();
  }

  /// Updates customer sync status.
  Future<void> updateSyncStatus(String customerId, String status) async {
    await (_db.update(_db.customersTable)
          ..where((t) => t.id.equals(customerId)))
        .write(CustomersTableCompanion(syncStatus: Value(status)));
  }

  Customer _mapRowToCustomer(CustomersTableData row) {
    return Customer(
      id: row.id,
      shopId: row.shopId,
      name: row.name,
      phone: row.phone,
      email: row.email,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      syncStatus: row.syncStatus,
    );
  }
}
