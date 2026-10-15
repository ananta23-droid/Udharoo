import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/providers/app_providers.dart';
import '../models/notification_preferences.dart';

class NotificationPreferencesScreen extends ConsumerStatefulWidget {
  const NotificationPreferencesScreen({super.key});

  @override
  ConsumerState<NotificationPreferencesScreen> createState() =>
      _NotificationPreferencesScreenState();
}

class _NotificationPreferencesScreenState
    extends ConsumerState<NotificationPreferencesScreen> {
  bool _notifyOnCredit = true;
  bool _notifyOnPayment = true;
  bool _notifyOnFullClearance = true;
  bool _notifyOwnTransactions = false;
  bool _pushEnabled = true;
  bool _isLoaded = false;
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    final currentShop = ref.watch(currentShopProvider).value;
    final activeStaff = ref.watch(currentStaffActorProvider);
    final staffId = activeStaff?.id ?? 'owner';
    final shopId = currentShop?.id ?? '';

    final prefsAsync =
        ref.watch(staffNotificationPreferencesProvider(staffId));

    if (!_isLoaded && prefsAsync.value != null) {
      final p = prefsAsync.value!;
      _notifyOnCredit = p.notifyOnCredit;
      _notifyOnPayment = p.notifyOnPayment;
      _notifyOnFullClearance = p.notifyOnFullClearance;
      _notifyOwnTransactions = p.notifyOwnTransactions;
      _pushEnabled = p.pushEnabled;
      _isLoaded = true;
    }

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        title: const Text('Notification Alerts',
            style: AppTypography.screenTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppDimens.space16),
        children: [
          // Header info card
          Container(
            padding: const EdgeInsets.all(AppDimens.space16),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: AppDimens.rounded12,
              border: Border.all(color: const Color(0xFFC4E4D2)),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: AppColors.primary,
                  radius: 20,
                  child: Icon(Icons.notifications_active,
                      color: Colors.white, size: 20),
                ),
                const SizedBox(width: AppDimens.space12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Profile: ${activeStaff?.name ?? 'Shop Owner'}',
                        style: AppTypography.customerName.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Customize which shop activity alerts trigger push notifications for this device.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.space24),

          // Activity Preferences
          const Text(
            'Transaction Activity Alerts',
            style: AppTypography.sectionHeading,
          ),
          const SizedBox(height: AppDimens.space8),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: AppDimens.rounded12,
              side: const BorderSide(color: AppColors.border),
            ),
            elevation: 0,
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(
                    Icons.arrow_outward_rounded,
                    color: AppColors.error,
                  ),
                  title: const Text('New Credit (Udharo) Alerts'),
                  subtitle: const Text(
                    'Receive alert when another staff member issues credit',
                  ),
                  value: _notifyOnCredit,
                  onChanged: (val) {
                    setState(() => _notifyOnCredit = val);
                    _savePreferences(shopId, staffId);
                  },
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(
                    Icons.arrow_downward_rounded,
                    color: AppColors.primary,
                  ),
                  title: const Text('Customer Payment Received'),
                  subtitle: const Text(
                    'Receive alert when customer makes a partial or invoice payment',
                  ),
                  value: _notifyOnPayment,
                  onChanged: (val) {
                    setState(() => _notifyOnPayment = val);
                    _savePreferences(shopId, staffId);
                  },
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(
                    Icons.verified_rounded,
                    color: Color(0xFF16A34A),
                  ),
                  title: const Text('Customer Due Fully Cleared'),
                  subtitle: const Text(
                    'Receive high-priority alert when an outstanding balance reaches zero',
                  ),
                  value: _notifyOnFullClearance,
                  onChanged: (val) {
                    setState(() => _notifyOnFullClearance = val);
                    _savePreferences(shopId, staffId);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.space24),

          // Device & Self Preferences
          const Text(
            'Device & Delivery Settings',
            style: AppTypography.sectionHeading,
          ),
          const SizedBox(height: AppDimens.space8),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: AppDimens.rounded12,
              side: const BorderSide(color: AppColors.border),
            ),
            elevation: 0,
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(
                    Icons.smartphone_rounded,
                    color: AppColors.primaryDark,
                  ),
                  title: const Text('Push Notifications Enabled'),
                  subtitle: const Text(
                    'Deliver notifications to this device when app is in background or closed',
                  ),
                  value: _pushEnabled,
                  onChanged: (val) {
                    setState(() => _pushEnabled = val);
                    _savePreferences(shopId, staffId);
                  },
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(
                    Icons.person_pin_circle_outlined,
                    color: AppColors.secondaryText,
                  ),
                  title: const Text('Notify My Own Actions'),
                  subtitle: const Text(
                    'Also send push alerts to my phone for transactions I recorded myself',
                  ),
                  value: _notifyOwnTransactions,
                  onChanged: (val) {
                    setState(() => _notifyOwnTransactions = val);
                    _savePreferences(shopId, staffId);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.space20),
          if (_isSaving)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Saving preferences...',
                      style: TextStyle(fontSize: 12, color: AppColors.secondaryText),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _savePreferences(String shopId, String staffId) async {
    if (shopId.isEmpty) return;
    setState(() => _isSaving = true);
    final repo = ref.read(notificationRepositoryProvider);
    final prefs = NotificationPreferences(
      staffId: staffId,
      shopId: shopId,
      notifyOnCredit: _notifyOnCredit,
      notifyOnPayment: _notifyOnPayment,
      notifyOnFullClearance: _notifyOnFullClearance,
      notifyOwnTransactions: _notifyOwnTransactions,
      pushEnabled: _pushEnabled,
      updatedAt: DateTime.now(),
    );
    await repo.savePreferences(prefs);
    if (mounted) {
      setState(() => _isSaving = false);
    }
  }
}
