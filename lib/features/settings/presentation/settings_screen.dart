import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/widgets/udhaaro_badge.dart';
import '../../../core/widgets/udhaaro_button.dart';
import '../../../core/widgets/udhaaro_card.dart';
import '../models/shop_settings.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _isManualSyncing = false;

  Future<void> _handleManualSync(String shopId) async {
    setState(() => _isManualSyncing = true);
    try {
      await ref.read(syncServiceProvider).syncPending(shopId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('All pending records synced successfully'),
            backgroundColor: AppColors.primary,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isManualSyncing = false);
    }
  }

  Future<void> _updateSettings(ShopSettings newSettings) async {
    try {
      final settingsRepo = ref.read(settingsRepositoryProvider);
      final auditRepo = ref.read(auditRepositoryProvider);
      await settingsRepo.saveSettings(newSettings);

      await auditRepo.logAction(
        shopId: newSettings.shopId,
        action: 'settings_changed',
        entityType: 'settings',
        entityId: newSettings.shopId,
        detailsJson: jsonEncode(newSettings.toMap()),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Shop settings updated successfully'),
            duration: Duration(seconds: 2),
            backgroundColor: AppColors.primary,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update settings: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _handleSignOut() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Sign Out Shop'),
        content: const Text(
          'Are you sure you want to sign out? Your records remain safely stored in your local database.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final authRepo = ref.read(authRepositoryProvider);
      await authRepo.signOut();
      if (!mounted) return;
      context.go('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    final shopAsync = ref.watch(currentShopProvider);
    final pendingCountAsync = ref.watch(pendingSyncCountProvider);
    final settingsAsync = ref.watch(shopSettingsProvider);
    final staffListAsync = ref.watch(staffListProvider);

    final shop = shopAsync.value;
    final pendingCount = pendingCountAsync.value ?? 0;
    final settings =
        settingsAsync.value ?? ShopSettings.defaultSettings(shop?.id ?? '');
    final staffList = staffListAsync.value ?? [];

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(title: const Text('Shop Settings & Management')),
      body: ListView(
        padding: const EdgeInsets.all(AppDimens.space16),
        children: [
          // Shop Profile Card
          UdhaaroCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: AppColors.primaryLight,
                      child: const Icon(
                        Icons.storefront_rounded,
                        color: AppColors.primary,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: AppDimens.space16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            shop?.name ?? 'Shop Profile',
                            style: AppTypography.customerName.copyWith(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            shop?.phone ?? 'No phone specified',
                            style: AppTypography.bodySmall,
                          ),
                          if (shop?.address != null &&
                              shop!.address!.isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Text(
                              shop.address!,
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.mutedText,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimens.space16),
                const Divider(),
                const SizedBox(height: AppDimens.space12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Shop Identifier', style: AppTypography.label),
                    Text(
                      shop?.id.substring(0, 13) ?? '—',
                      style: AppTypography.bodySmall.copyWith(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimens.space8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Owner Account UID', style: AppTypography.label),
                    Text(
                      shop?.ownerUid.substring(0, 14) ?? '—',
                      style: AppTypography.bodySmall.copyWith(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.space24),

          // Configurable Payment Terms
          const Text(
            'Credit Terms & Repayment Period',
            style: AppTypography.sectionHeading,
          ),
          const SizedBox(height: AppDimens.space12),
          UdhaaroCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Default Due Period',
                            style: AppTypography.titleMedium,
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Standard repayment days given to customers on new credits.',
                            style: AppTypography.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    DropdownButton<int>(
                      value: settings.defaultRepaymentDays,
                      items: const [
                        DropdownMenuItem(value: 7, child: Text('7 Days')),
                        DropdownMenuItem(value: 15, child: Text('15 Days')),
                        DropdownMenuItem(value: 30, child: Text('30 Days')),
                        DropdownMenuItem(value: 45, child: Text('45 Days')),
                        DropdownMenuItem(value: 60, child: Text('60 Days')),
                        DropdownMenuItem(value: 90, child: Text('90 Days')),
                      ],
                      onChanged: (days) {
                        if (days != null && shop != null) {
                          _updateSettings(
                            settings.copyWith(
                              shopId: shop.id,
                              defaultRepaymentDays: days,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.space24),

          // Automated Reminders Configuration
          const Text(
            'Automated Due Date Reminders',
            style: AppTypography.sectionHeading,
          ),
          const SizedBox(height: AppDimens.space12),
          UdhaaroCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'Email Reminders',
                    style: AppTypography.titleMedium,
                  ),
                  subtitle: const Text(
                    'Send email statements to customers before due dates.',
                    style: AppTypography.bodySmall,
                  ),
                  value: settings.emailRemindersEnabled,
                  activeThumbColor: AppColors.primary,
                  onChanged: (val) {
                    if (shop != null) {
                      _updateSettings(
                        settings.copyWith(
                          shopId: shop.id,
                          emailRemindersEnabled: val,
                        ),
                      );
                    }
                  },
                ),
                const Divider(),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'SMS Reminders',
                    style: AppTypography.titleMedium,
                  ),
                  subtitle: const Text(
                    'Send SMS alerts to customer mobile numbers.',
                    style: AppTypography.bodySmall,
                  ),
                  value: settings.smsRemindersEnabled,
                  activeThumbColor: AppColors.primary,
                  onChanged: (val) {
                    if (shop != null) {
                      _updateSettings(
                        settings.copyWith(
                          shopId: shop.id,
                          smsRemindersEnabled: val,
                        ),
                      );
                    }
                  },
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Alert Interval', style: AppTypography.titleMedium),
                    DropdownButton<int>(
                      value: settings.reminderIntervalDays,
                      items: const [
                        DropdownMenuItem(value: 1, child: Text('1 Day Before')),
                        DropdownMenuItem(value: 3, child: Text('3 Days Before')),
                        DropdownMenuItem(value: 7, child: Text('7 Days Before')),
                      ],
                      onChanged: (interval) {
                        if (interval != null && shop != null) {
                          _updateSettings(
                            settings.copyWith(
                              shopId: shop.id,
                              reminderIntervalDays: interval,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.space24),

          // Management & Modules
          const Text(
            'Shop Administration',
            style: AppTypography.sectionHeading,
          ),
          const SizedBox(height: AppDimens.space12),
          UdhaaroCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: AppColors.primaryLight,
                    child: Icon(Icons.badge_outlined, color: AppColors.primary),
                  ),
                  title: const Text('Staff & Permissions'),
                  subtitle: Text(
                    '${staffList.length} staff members registered',
                    style: AppTypography.bodySmall,
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/settings/staff'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFFFEF3C7),
                    child: const Icon(
                      Icons.notifications_active_outlined,
                      color: Color(0xFFD97706),
                    ),
                  ),
                  title: const Text('Real-Time Notification Alerts'),
                  subtitle: const Text(
                    'Multi-device staff alerts, push triggers, and preferences',
                    style: AppTypography.bodySmall,
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/settings/notifications'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFFE0E7FF),
                    child: const Icon(
                      Icons.history_edu_rounded,
                      color: Color(0xFF4338CA),
                    ),
                  ),
                  title: const Text('Activity & Audit Trail'),
                  subtitle: const Text(
                    'Track changes, entries, and cashier signatures',
                    style: AppTypography.bodySmall,
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/settings/audit'),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.space24),

          // Cloud Synchronization Card
          const Text(
            'Cloud Synchronization & Storage',
            style: AppTypography.sectionHeading,
          ),
          const SizedBox(height: AppDimens.space12),
          UdhaaroCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Sync Status', style: AppTypography.titleMedium),
                    pendingCount > 0
                        ? UdhaaroBadge(
                            label: '$pendingCount Pending Ops',
                            type: UdhaaroBadgeType.pendingSync,
                          )
                        : const UdhaaroBadge(
                            label: 'All Records Synced',
                            type: UdhaaroBadgeType.synced,
                          ),
                  ],
                ),
                const SizedBox(height: AppDimens.space8),
                Text(
                  pendingCount > 0
                      ? 'You have $pendingCount changes stored locally that are queued for cloud backup.'
                      : 'All customer and ledger transactions are saved securely to your local SQLite database.',
                  style: AppTypography.bodySmall,
                ),
                const SizedBox(height: AppDimens.space16),
                UdhaaroButton(
                  text: 'Sync Queue Now',
                  icon: Icons.sync_rounded,
                  variant: UdhaaroButtonVariant.secondary,
                  isLoading: _isManualSyncing,
                  onPressed: shop != null
                      ? () => _handleManualSync(shop.id)
                      : null,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.space24),

          // Security & Audit Information
          const Text(
            'Security & Data Integrity',
            style: AppTypography.sectionHeading,
          ),
          const SizedBox(height: AppDimens.space12),
          UdhaaroCard(
            child: Column(
              children: [
                _SettingsInfoRow(
                  icon: Icons.offline_pin_outlined,
                  title: 'Offline-First Engine',
                  subtitle:
                      'Full credit & payment operations work offline without connectivity.',
                ),
                const Divider(),
                _SettingsInfoRow(
                  icon: Icons.verified_user_outlined,
                  title: 'Shop Data Isolation',
                  subtitle:
                      'Ledger entries are strictly scoped to your shop identifier.',
                ),
                const Divider(),
                _SettingsInfoRow(
                  icon: Icons.calculate_outlined,
                  title: 'Integer Financial Precision',
                  subtitle:
                      'Monetary sums calculated in Paisa minor units, avoiding floating-point errors.',
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.space32),

          // Sign Out Action
          UdhaaroButton(
            text: 'Sign Out / Switch Shop',
            variant: UdhaaroButtonVariant.destructive,
            icon: Icons.logout_rounded,
            onPressed: _handleSignOut,
          ),
          const SizedBox(height: AppDimens.space40),
        ],
      ),
    );
  }
}

class _SettingsInfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _SettingsInfoRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.space8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: AppColors.primary),
          const SizedBox(width: AppDimens.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.titleMedium),
                const SizedBox(height: 2),
                Text(subtitle, style: AppTypography.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
