import 'dart:io';
import 'package:flutter/foundation.dart';
import 'notification_repository.dart';

class FcmTokenManager {
  final NotificationRepository _notificationRepo;

  FcmTokenManager(this._notificationRepo);

  /// Returns current platform identifier ('android', 'ios', 'web', etc.)
  String get currentPlatform {
    if (kIsWeb) return 'web';
    if (Platform.isAndroid) return 'android';
    if (Platform.isIOS) return 'ios';
    if (Platform.isMacOS) return 'macos';
    if (Platform.isLinux) return 'linux';
    if (Platform.isWindows) return 'windows';
    return 'unknown';
  }

  /// Registers or updates device token for the current staff member in the shop.
  Future<void> registerDeviceToken({
    required String shopId,
    required String staffId,
    required String token,
  }) async {
    if (shopId.isEmpty || staffId.isEmpty || token.isEmpty) return;

    await _notificationRepo.registerDeviceToken(
      shopId: shopId,
      staffId: staffId,
      token: token.trim(),
      platform: currentPlatform,
    );
  }

  /// Unregisters device token on logout or staff deactivation.
  Future<void> unregisterDeviceToken(String token) async {
    if (token.isEmpty) return;
    await _notificationRepo.removeDeviceToken(token.trim());
  }
}
