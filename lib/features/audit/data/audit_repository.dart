import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../data/local/app_database.dart';
import '../models/audit_log_entry.dart';

class AuditRepository {
  final AppDatabase _db;

  AuditRepository(this._db);

  /// Logs a new audit entry for any significant action in the shop.
  Future<void> logAction({
    required String shopId,
    String? actorId,
    String? actorName,
    required String action,
    required String entityType,
    required String entityId,
    String detailsJson = '{}',
    DateTime? createdAt,
  }) async {
    final timestamp = createdAt ?? DateTime.now();
    await _db.into(_db.auditLogsTable).insert(
          AuditLogsTableCompanion.insert(
            id: const Uuid().v4(),
            shopId: shopId,
            actorId: Value(actorId),
            actorName: Value(actorName),
            action: action,
            entityType: entityType,
            entityId: entityId,
            detailsJson: detailsJson,
            createdAt: timestamp,
          ),
        );
  }

  /// Watch audit logs for a shop, newest first (limited to [limit]).
  Stream<List<AuditLogEntry>> watchAuditLogs(String shopId, {int limit = 50}) {
    final query = _db.select(_db.auditLogsTable)
      ..where((t) => t.shopId.equals(shopId))
      ..orderBy([
        (t) => OrderingTerm.desc(t.createdAt),
        (t) => OrderingTerm.desc(t.rowId),
      ])
      ..limit(limit);

    return query.map((row) {
      return AuditLogEntry(
        id: row.id,
        shopId: row.shopId,
        actorId: row.actorId,
        actorName: row.actorName,
        action: row.action,
        entityType: row.entityType,
        entityId: row.entityId,
        detailsJson: row.detailsJson,
        createdAt: row.createdAt,
      );
    }).watch();
  }

  /// Get audit logs for a specific entity (e.g. a transaction or customer).
  Future<List<AuditLogEntry>> getLogsForEntity(
    String shopId,
    String entityType,
    String entityId,
  ) async {
    final query = _db.select(_db.auditLogsTable)
      ..where(
        (t) =>
            t.shopId.equals(shopId) &
            t.entityType.equals(entityType) &
            t.entityId.equals(entityId),
      )
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);

    final rows = await query.get();
    return rows
        .map((row) => AuditLogEntry(
              id: row.id,
              shopId: row.shopId,
              actorId: row.actorId,
              actorName: row.actorName,
              action: row.action,
              entityType: row.entityType,
              entityId: row.entityId,
              detailsJson: row.detailsJson,
              createdAt: row.createdAt,
            ))
        .toList();
  }
}
