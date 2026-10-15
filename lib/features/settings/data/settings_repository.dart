import 'package:drift/drift.dart';

import '../../../data/local/app_database.dart';
import '../models/shop_settings.dart';

class SettingsRepository {
  final AppDatabase _db;

  SettingsRepository(this._db);

  Stream<ShopSettings> watchSettings(String shopId) {
    final query = _db.select(_db.shopSettingsTable)..where((tbl) => tbl.shopId.equals(shopId));
    return query.watchSingleOrNull().map((row) {
      if (row == null) return ShopSettings.defaultForShop(shopId);
      return _mapRowToSettings(row);
    });
  }

  Future<ShopSettings> getSettings(String shopId) async {
    final query = _db.select(_db.shopSettingsTable)..where((tbl) => tbl.shopId.equals(shopId));
    final row = await query.getSingleOrNull();
    if (row == null) return ShopSettings.defaultForShop(shopId);
    return _mapRowToSettings(row);
  }

  Future<void> saveSettings(ShopSettings settings) async {
    await _db.into(_db.shopSettingsTable).insert(
          ShopSettingsTableCompanion.insert(
            shopId: settings.shopId,
            defaultRepaymentDays: Value(settings.defaultRepaymentDays),
            emailRemindersEnabled: Value(settings.emailRemindersEnabled),
            senderEmail: Value(settings.senderEmail),
            reminderIntervalDays: Value(settings.reminderIntervalDays),
            smsRemindersEnabled: Value(settings.smsRemindersEnabled),
            smsProviderConfigJson: Value(settings.smsProviderConfigJson),
            updatedAt: DateTime.now(),
          ),
          mode: InsertMode.insertOrReplace,
        );
  }

  ShopSettings _mapRowToSettings(ShopSettingsTableData row) {
    return ShopSettings(
      shopId: row.shopId,
      defaultRepaymentDays: row.defaultRepaymentDays,
      emailRemindersEnabled: row.emailRemindersEnabled,
      senderEmail: row.senderEmail,
      reminderIntervalDays: row.reminderIntervalDays,
      smsRemindersEnabled: row.smsRemindersEnabled,
      smsProviderConfigJson: row.smsProviderConfigJson,
      updatedAt: row.updatedAt,
    );
  }
}
