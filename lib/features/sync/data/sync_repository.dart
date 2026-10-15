import 'package:drift/drift.dart';

import '../../../data/local/app_database.dart';
import '../models/pending_sync_op.dart';

class SyncRepository {
  final AppDatabase _db;

  SyncRepository(this._db);

  /// Queues an operation for cloud synchronization in SQLite.
  Future<void> queueOperation(PendingSyncOp op) async {
    await _db
        .into(_db.pendingSyncOperationsTable)
        .insert(
          PendingSyncOperationsTableCompanion.insert(
            id: op.id,
            shopId: op.shopId,
            entityType: op.entityType,
            entityId: op.entityId,
            operationType: op.operationType,
            payloadJson: op.payloadJson,
            createdAt: op.createdAt,
            retryCount: Value(op.retryCount),
            lastError: Value(op.lastError),
          ),
          mode: InsertMode.insertOrReplace,
        );
  }

  /// Retrieves all pending operations for the shop ordered by creation time.
  Future<List<PendingSyncOp>> getPendingOperations(String shopId) async {
    final query = _db.select(_db.pendingSyncOperationsTable)
      ..where((tbl) => tbl.shopId.equals(shopId))
      ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]);

    final rows = await query.get();
    return rows.map(_mapRowToPendingOp).toList();
  }

  /// Removes an operation once successfully synchronized.
  Future<void> removeOperation(String opId) async {
    await (_db.delete(
      _db.pendingSyncOperationsTable,
    )..where((t) => t.id.equals(opId))).go();
  }

  /// Increments retry count and records error message.
  Future<void> recordRetry(String opId, String error) async {
    final query = _db.select(_db.pendingSyncOperationsTable)
      ..where((tbl) => tbl.id.equals(opId));
    final existing = await query.getSingleOrNull();
    if (existing == null) return;

    await (_db.update(
      _db.pendingSyncOperationsTable,
    )..where((t) => t.id.equals(opId))).write(
      PendingSyncOperationsTableCompanion(
        retryCount: Value(existing.retryCount + 1),
        lastError: Value(error),
      ),
    );
  }

  /// Streams pending operation count.
  Stream<int> watchPendingCount(String shopId) {
    final query = _db.select(_db.pendingSyncOperationsTable)
      ..where((tbl) => tbl.shopId.equals(shopId));
    return query.watch().map((rows) => rows.length);
  }

  /// Gets pending operation count.
  Future<int> getPendingCount(String shopId) async {
    final query = _db.select(_db.pendingSyncOperationsTable)
      ..where((tbl) => tbl.shopId.equals(shopId));
    final rows = await query.get();
    return rows.length;
  }

  PendingSyncOp _mapRowToPendingOp(PendingSyncOperationsTableData row) {
    return PendingSyncOp(
      id: row.id,
      shopId: row.shopId,
      entityType: row.entityType,
      entityId: row.entityId,
      operationType: row.operationType,
      payloadJson: row.payloadJson,
      createdAt: row.createdAt,
      retryCount: row.retryCount,
      lastError: row.lastError,
    );
  }
}
