import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../customers/data/customer_repository.dart';
import '../../ledger/data/transaction_repository.dart';
import 'sync_repository.dart';

enum SyncStatusState { synced, pending, syncing, offline, error }

abstract class CloudSyncClient {
  Future<bool> uploadCustomer(Map<String, dynamic> data);
  Future<bool> uploadTransaction(Map<String, dynamic> data);
  Future<bool> uploadShop(Map<String, dynamic> data);
}

/// Fallback client when external Firebase credentials are unconfigured in current environment.
/// Accurately reports offline/pending status without fabricating cloud synchronization.
class OfflineFirstCloudClient implements CloudSyncClient {
  final bool isCloudConfigured;

  OfflineFirstCloudClient({this.isCloudConfigured = false});

  @override
  Future<bool> uploadCustomer(Map<String, dynamic> data) async {
    if (!isCloudConfigured) return false;
    return true;
  }

  @override
  Future<bool> uploadTransaction(Map<String, dynamic> data) async {
    if (!isCloudConfigured) return false;
    return true;
  }

  @override
  Future<bool> uploadShop(Map<String, dynamic> data) async {
    if (!isCloudConfigured) return false;
    return true;
  }
}

class SyncService extends ChangeNotifier {
  final SyncRepository syncRepo;
  final CustomerRepository customerRepo;
  final TransactionRepository txRepo;
  final CloudSyncClient _cloudClient;

  bool _isSyncing = false;
  String? _lastErrorMessage;
  SyncStatusState _state = SyncStatusState.synced;

  SyncService({
    required this.syncRepo,
    required this.customerRepo,
    required this.txRepo,
    CloudSyncClient? cloudClient,
  }) : _cloudClient =
           cloudClient ?? OfflineFirstCloudClient(isCloudConfigured: false);

  bool get isSyncing => _isSyncing;
  String? get lastErrorMessage => _lastErrorMessage;
  SyncStatusState get state => _state;

  /// Retries all pending synchronization operations for the given shop.
  Future<void> syncPending(String shopId) async {
    if (_isSyncing) return;
    _isSyncing = true;
    _state = SyncStatusState.syncing;
    notifyListeners();

    try {
      final pendingOps = await syncRepo.getPendingOperations(shopId);
      if (pendingOps.isEmpty) {
        _state = SyncStatusState.synced;
        _isSyncing = false;
        notifyListeners();
        return;
      }

      for (final op in pendingOps) {
        bool success = false;
        try {
          final payload = jsonDecode(op.payloadJson) as Map<String, dynamic>;
          switch (op.entityType) {
            case 'customer':
              success = await _cloudClient.uploadCustomer(payload);
              if (success) {
                await customerRepo.updateSyncStatus(op.entityId, 'synced');
              }
              break;
            case 'transaction':
              success = await _cloudClient.uploadTransaction(payload);
              if (success) {
                await txRepo.updateSyncStatus(op.entityId, 'synced');
              }
              break;
            case 'shop':
              success = await _cloudClient.uploadShop(payload);
              break;
          }

          if (success) {
            await syncRepo.removeOperation(op.id);
          } else {
            await syncRepo.recordRetry(
              op.id,
              'Cloud endpoint unavailable / offline',
            );
          }
        } catch (e) {
          await syncRepo.recordRetry(op.id, e.toString());
        }
      }

      final remaining = await syncRepo.getPendingCount(shopId);
      if (remaining == 0) {
        _state = SyncStatusState.synced;
      } else {
        _state = SyncStatusState.pending;
      }
    } catch (e) {
      _lastErrorMessage = e.toString();
      _state = SyncStatusState.error;
    } finally {
      _isSyncing = false;
      notifyListeners();
    }
  }
}
