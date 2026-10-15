import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../data/local/app_database.dart';
import '../models/shop.dart';

class AuthRepository {
  final AppDatabase _db;
  static const _uuid = Uuid();

  AuthRepository(this._db);

  /// Gets the currently active shop profile from local persistence.
  Future<Shop?> getCurrentShop() async {
    final query = _db.select(_db.shopsTable)..limit(1);
    final row = await query.getSingleOrNull();
    if (row == null) return null;
    return _mapRowToShop(row);
  }

  /// Watches the active shop profile.
  Stream<Shop?> watchCurrentShop() {
    return (_db.select(_db.shopsTable)..limit(1)).watchSingleOrNull().map(
      (row) => row != null ? _mapRowToShop(row) : null,
    );
  }

  /// Creates a new shop and persists it locally.
  Future<Shop> createShop({
    required String name,
    String? phone,
    String? address,
    String? ownerUid,
  }) async {
    final now = DateTime.now();
    final shopId = _uuid.v4();
    final effectiveOwnerUid = ownerUid ?? 'owner_${_uuid.v4().substring(0, 8)}';

    final shop = Shop(
      id: shopId,
      ownerUid: effectiveOwnerUid,
      name: name.trim(),
      phone: phone?.trim(),
      address: address?.trim(),
      createdAt: now,
      updatedAt: now,
    );

    await _db
        .into(_db.shopsTable)
        .insert(
          ShopsTableCompanion.insert(
            id: shop.id,
            ownerUid: shop.ownerUid,
            name: shop.name,
            phone: Value(shop.phone),
            address: Value(shop.address),
            createdAt: shop.createdAt,
            updatedAt: shop.updatedAt,
          ),
          mode: InsertMode.insertOrReplace,
        );

    return shop;
  }

  /// Updates existing shop details.
  Future<Shop> updateShop(Shop shop) async {
    final updated = shop.copyWith(updatedAt: DateTime.now());
    await (_db.update(
      _db.shopsTable,
    )..where((t) => t.id.equals(shop.id))).write(
      ShopsTableCompanion(
        name: Value(updated.name),
        phone: Value(updated.phone),
        address: Value(updated.address),
        updatedAt: Value(updated.updatedAt),
      ),
    );
    return updated;
  }

  /// Sign out removes local active shop record.
  Future<void> signOut() async {
    await _db.delete(_db.shopsTable).go();
  }

  Shop _mapRowToShop(ShopsTableData row) {
    return Shop(
      id: row.id,
      ownerUid: row.ownerUid,
      name: row.name,
      phone: row.phone,
      address: row.address,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}
