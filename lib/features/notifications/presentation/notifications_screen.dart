import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/widgets/udhaaro_empty_state.dart';

import '../models/shop_notification.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(shopNotificationsProvider);
    final currentShop = ref.watch(currentShopProvider).value;
    final activeStaff = ref.watch(currentStaffActorProvider);
    final notificationRepo = ref.watch(notificationRepositoryProvider);

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        title: const Text('Notifications', style: AppTypography.screenTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all_rounded),
            tooltip: 'Mark All as Read',
            onPressed: () async {
              if (currentShop != null) {
                await notificationRepo.markAllAsRead(
                  currentShop.id,
                  recipientStaffId: activeStaff?.id,
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('All notifications marked as read'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.tune_rounded),
            tooltip: 'Notification Preferences',
            onPressed: () {
              context.push('/settings/notifications');
            },
          ),
        ],
      ),
      body: notificationsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text(
            'Failed to load notifications: $err',
            style: AppTypography.error,
          ),
        ),
        data: (notifications) {
          if (notifications.isEmpty) {
            return const UdhaaroEmptyState(
              icon: Icons.notifications_off_outlined,
              title: 'No Notifications Yet',
              message:
                  'You will receive real-time alerts when credit is issued, payments are collected, or customer dues are cleared.',
            );
          }

          // Group by Today, Yesterday, Earlier
          final now = DateTime.now();
          final today = DateTime(now.year, now.month, now.day);
          final yesterday = today.subtract(const Duration(days: 1));

          final todayList = <ShopNotification>[];
          final yesterdayList = <ShopNotification>[];
          final earlierList = <ShopNotification>[];

          for (final n in notifications) {
            final date =
                DateTime(n.createdAt.year, n.createdAt.month, n.createdAt.day);
            if (date.isAtSameMomentAs(today)) {
              todayList.add(n);
            } else if (date.isAtSameMomentAs(yesterday)) {
              yesterdayList.add(n);
            } else {
              earlierList.add(n);
            }
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(shopNotificationsProvider);
            },
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.space16,
                vertical: AppDimens.space12,
              ),
              children: [
                if (todayList.isNotEmpty) ...[
                  _buildSectionHeader('Today'),
                  ...todayList.map((n) => _buildNotificationCard(context, ref, n)),
                  const SizedBox(height: AppDimens.space16),
                ],
                if (yesterdayList.isNotEmpty) ...[
                  _buildSectionHeader('Yesterday'),
                  ...yesterdayList
                      .map((n) => _buildNotificationCard(context, ref, n)),
                  const SizedBox(height: AppDimens.space16),
                ],
                if (earlierList.isNotEmpty) ...[
                  _buildSectionHeader('Earlier'),
                  ...earlierList.map((n) => _buildNotificationCard(context, ref, n)),
                  const SizedBox(height: AppDimens.space16),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: AppColors.secondaryText,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildNotificationCard(
    BuildContext context,
    WidgetRef ref,
    ShopNotification n,
  ) {
    final isUnread = !n.isRead;
    final notificationRepo = ref.read(notificationRepositoryProvider);

    return Dismissible(
      key: Key(n.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: AppColors.errorLight,
          borderRadius: AppDimens.rounded12,
        ),
        child: const Icon(Icons.delete_outline, color: AppColors.error),
      ),
      onDismissed: (_) {
        notificationRepo.dismissNotification(n.id);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Notification dismissed'),
            duration: Duration(seconds: 1),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 10),
        elevation: isUnread ? 1.5 : 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppDimens.rounded12,
          side: BorderSide(
            color: isUnread
                ? AppColors.primary.withValues(alpha: 0.3)
                : AppColors.border,
            width: isUnread ? 1.5 : 1,
          ),
        ),
        color: isUnread ? const Color(0xFFF0FDF4) : AppColors.surface,
        child: InkWell(
          borderRadius: AppDimens.rounded12,
          onTap: () async {
            // Mark as read
            if (!n.isRead) {
              await notificationRepo.markAsRead(n.id);
            }

            // Safe navigation to customer details if customerId is present
            if (context.mounted &&
                n.customerId != null &&
                n.customerId!.isNotEmpty) {
              context.push('/customer/${n.customerId}');
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.space14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Event icon
                _buildEventIcon(n.eventType),
                const SizedBox(width: AppDimens.space12),

                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              n.title,
                              style: AppTypography.customerName.copyWith(
                                fontSize: 15,
                                fontWeight: isUnread
                                    ? FontWeight.w700
                                    : FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (isUnread)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        n.message,
                        style: TextStyle(
                          fontSize: 13,
                          color: isUnread
                              ? AppColors.mainText
                              : AppColors.secondaryText,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormatter.formatDisplayDate(n.createdAt),
                            style: AppTypography.timestamp,
                          ),
                          if (n.actorStaffName != null)
                            Text(
                              'By: ${n.actorStaffName}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.secondaryText,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventIcon(NotificationEventType type) {
    IconData icon;
    Color bgColor;
    Color iconColor;

    switch (type) {
      case NotificationEventType.creditCreated:
        icon = Icons.arrow_outward_rounded;
        bgColor = const Color(0xFFFEE2E2);
        iconColor = AppColors.error;
        break;
      case NotificationEventType.paymentReceived:
        icon = Icons.arrow_downward_rounded;
        bgColor = AppColors.primaryLight;
        iconColor = AppColors.primary;
        break;
      case NotificationEventType.customerAccountFullySettled:
      case NotificationEventType.invoiceFullyPaid:
        icon = Icons.verified_rounded;
        bgColor = const Color(0xFFDCFCE7);
        iconColor = const Color(0xFF16A34A);
        break;
      case NotificationEventType.paymentReversed:
      case NotificationEventType.creditReversed:
        icon = Icons.history_rounded;
        bgColor = const Color(0xFFFEF3C7);
        iconColor = const Color(0xFFD97706);
        break;
      default:
        icon = Icons.notifications_outlined;
        bgColor = const Color(0xFFF1F5F9);
        iconColor = AppColors.secondaryText;
    }

    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: iconColor, size: 20),
    );
  }
}
