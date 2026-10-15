import 'package:drift/drift.dart';

import '../../../data/local/app_database.dart';
import '../../auth/models/shop.dart';
import '../models/staff.dart';

class StaffRepository {
  final AppDatabase _db;

  StaffRepository(this._db);

  Stream<List<Staff>> watchStaffForShop(String shopId) {
    final query = _db.select(_db.staffTable)
      ..where((tbl) => tbl.shopId.equals(shopId))
      ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]);

    return query.watch().map((rows) => rows.map((r) => _mapRowToStaff(r)).toList());
  }

  Stream<List<Staff>> watchStaff(String shopId) => watchStaffForShop(shopId);

  Stream<List<Staff>> watchActiveStaff(String shopId) {
    return watchStaffForShop(shopId).map(
      (list) => list.where((s) => s.isActive).toList(),
    );
  }

  Future<List<Staff>> getStaffForShop(String shopId) async {
    final query = _db.select(_db.staffTable)
      ..where((tbl) => tbl.shopId.equals(shopId))
      ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]);

    final rows = await query.get();
    return rows.map((r) => _mapRowToStaff(r)).toList();
  }

  Future<Staff?> getStaffById(String staffId) async {
    final query = _db.select(_db.staffTable)
      ..where((tbl) => tbl.id.equals(staffId));
    final row = await query.getSingleOrNull();
    if (row == null) return null;
    return _mapRowToStaff(row);
  }

  Future<void> createStaff(Staff staff) async {
    await _db.into(_db.staffTable).insert(
          StaffTableCompanion.insert(
            id: staff.id,
            shopId: staff.shopId,
            name: staff.name.trim(),
            email: staff.email.trim().toLowerCase(),
            phone: Value(staff.phone?.trim()),
            role: Value(staff.role.name),
            isActive: Value(staff.isActive),
            createdAt: staff.createdAt,
            updatedAt: staff.updatedAt,
          ),
          mode: InsertMode.insertOrReplace,
        );
  }

  Future<void> addStaff(Staff staff) => createStaff(staff);

  Future<void> updateStaff(Staff staff) async {
    await (_db.update(_db.staffTable)..where((t) => t.id.equals(staff.id))).write(
      StaffTableCompanion(
        name: Value(staff.name.trim()),
        email: Value(staff.email.trim().toLowerCase()),
        phone: Value(staff.phone?.trim()),
        role: Value(staff.role.name),
        isActive: Value(staff.isActive),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> toggleStaffStatus(String staffId, bool isActive) async {
    await (_db.update(_db.staffTable)..where((t) => t.id.equals(staffId))).write(
      StaffTableCompanion(
        isActive: Value(isActive),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Ensures a default Shop Owner staff record exists for the shop
  Future<Staff> ensureDefaultOwner(Shop shop) async {
    final existingStaff = await getStaffForShop(shop.id);
    final existingOwner =
        existingStaff.where((s) => s.role == StaffRole.owner).firstOrNull;
    if (existingOwner != null) return existingOwner;

    final now = DateTime.now();
    final owner = Staff(
      id: 'staff_owner_${shop.id.substring(0, 8)}',
      shopId: shop.id,
      name: '${shop.name} Owner',
      email: 'owner@${shop.id.substring(0, 6)}.udhaaro.local',
      phone: shop.phone,
      role: StaffRole.owner,
      isActive: true,
      createdAt: now,
      updatedAt: now,
    );
    await createStaff(owner);
    return owner;
  }

  Staff _mapRowToStaff(StaffTableData row) {
    return Staff(
      id: row.id,
      shopId: row.shopId,
      name: row.name,
      email: row.email,
      phone: row.phone,
      role: StaffRole.values.byName(row.role),
      isActive: row.isActive,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}
