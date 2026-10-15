import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/widgets/udhaaro_badge.dart';
import '../../../core/widgets/udhaaro_button.dart';
import '../../../core/widgets/udhaaro_card.dart';
import '../../../core/widgets/udhaaro_customer_tile.dart';
import '../../../core/widgets/udhaaro_empty_state.dart';
import '../../../core/widgets/udhaaro_financial_card.dart';
import '../../ledger/models/ledger_transaction.dart';
import '../../staff/models/staff.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  void _showPendingExplanationSheet(
    BuildContext context,
    WidgetRef ref,
    String? shopId,
    int pendingCount,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            bool isSyncing = false;

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.space24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: pendingCount > 0
                              ? const Color(0xFFFEF3C7)
                              : AppColors.primaryLight,
                          child: Icon(
                            pendingCount > 0
                                ? Icons.sync_problem_rounded
                                : Icons.cloud_done_rounded,
                            color: pendingCount > 0
                                ? const Color(0xFFD97706)
                                : AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: AppDimens.space12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pendingCount > 0
                                    ? 'Local Queue: $pendingCount Pending'
                                    : 'Cloud Storage Synchronized',
                                style: AppTypography.customerName.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                pendingCount > 0
                                    ? 'Saved locally, awaiting cloud upload'
                                    : 'All transactions are backed up safely',
                                style: AppTypography.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(ctx),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimens.space20),
                    const Divider(),
                    const SizedBox(height: AppDimens.space16),

                    // Explanation Points
                    _syncExplanationTile(
                      icon: Icons.offline_pin_outlined,
                      title: '100% Offline-First Guarantee',
                      description:
                          'Your customer and ledger records are instantly saved in SQLite on your phone. You will never lose data, even with no cellular signal.',
                    ),
                    const SizedBox(height: AppDimens.space12),
                    _syncExplanationTile(
                      icon: Icons.autorenew_rounded,
                      title: 'Automatic Background Sync',
                      description:
                          'When internet is available, operations upload seamlessly to cloud storage and reconcile with your account.',
                    ),
                    const SizedBox(height: AppDimens.space12),
                    _syncExplanationTile(
                      icon: Icons.shield_outlined,
                      title: 'Atomic Data Safety',
                      description:
                          'Every entry is indexed, encrypted, and tracked by timestamp so credits and balances never go out of sync.',
                    ),
                    const SizedBox(height: AppDimens.space24),

                    if (pendingCount > 0 && shopId != null)
                      UdhaaroButton(
                        text: 'Sync Pending Queue Now',
                        icon: Icons.sync_rounded,
                        isLoading: isSyncing,
                        onPressed: () async {
                          setModalState(() => isSyncing = true);
                          try {
                            await ref
                                .read(syncServiceProvider)
                                .syncPending(shopId);
                            if (ctx.mounted) {
                              Navigator.pop(ctx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Sync completed successfully'),
                                  backgroundColor: AppColors.primary,
                                ),
                              );
                            }
                          } finally {
                            if (ctx.mounted) {
                              setModalState(() => isSyncing = false);
                            }
                          }
                        },
                      )
                    else
                      UdhaaroButton(
                        text: 'Dismiss',
                        variant: UdhaaroButtonVariant.secondary,
                        onPressed: () => Navigator.pop(ctx),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  static Widget _syncExplanationTile({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: AppDimens.space12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.mainText,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.secondaryText,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showStaffSelector(
    BuildContext context,
    WidgetRef ref,
    List<Staff> staffList,
    Staff? currentStaff,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.space20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Select Active Staff Profile',
                      style: AppTypography.sectionHeading,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimens.space8),
                Text(
                  'Ledger entries and audit logs will be signed with this staff member\'s name.',
                  style: AppTypography.bodySmall,
                ),
                const SizedBox(height: AppDimens.space16),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: AppColors.primaryLight,
                    child: Icon(Icons.store, color: AppColors.primary),
                  ),
                  title: const Text('Shop Owner (Default)'),
                  subtitle: const Text('Role: Owner'),
                  selected: currentStaff == null,
                  trailing: currentStaff == null
                      ? const Icon(Icons.check_circle, color: AppColors.primary)
                      : null,
                  onTap: () {
                    ref.read(currentStaffActorProvider.notifier).state = null;
                    Navigator.pop(ctx);
                  },
                ),
                ...staffList.where((s) => s.isActive).map((s) {
                  final isSelected = currentStaff?.id == s.id;
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isSelected
                          ? AppColors.primaryLight
                          : const Color(0xFFF1F5F9),
                      child: Text(
                        s.name.isNotEmpty ? s.name[0].toUpperCase() : 'S',
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.mainText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    title: Text(s.name),
                    subtitle: Text('Role: ${s.roleDisplay}'),
                    selected: isSelected,
                    trailing: isSelected
                        ? const Icon(Icons.check_circle,
                            color: AppColors.primary)
                        : null,
                    onTap: () {
                      ref.read(currentStaffActorProvider.notifier).state = s;
                      Navigator.pop(ctx);
                    },
                  );
                }),
                const SizedBox(height: AppDimens.space12),
                UdhaaroButton(
                  text: 'Manage Staff Members',
                  variant: UdhaaroButtonVariant.secondary,
                  icon: Icons.badge_outlined,
                  onPressed: () {
                    Navigator.pop(ctx);
                    context.push('/settings/staff');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopAsync = ref.watch(currentShopProvider);
    final totalBalanceAsync = ref.watch(shopTotalBalanceProvider);
    final customersAsync = ref.watch(customersListProvider);
    final recentTxsAsync = ref.watch(recentTransactionsProvider);
    final pendingCountAsync = ref.watch(pendingSyncCountProvider);
    final activeStaff = ref.watch(currentStaffActorProvider);
    final staffListAsync = ref.watch(staffListProvider);

    final shop = shopAsync.value;
    final balance = totalBalanceAsync.value;
    final customers = customersAsync.value ?? [];
    final recentTxs = recentTxsAsync.value ?? [];
    final pendingCount = pendingCountAsync.value ?? 0;
    final staffList = staffListAsync.value ?? [];
    final unreadCount = ref.watch(unreadNotificationCountProvider).value ?? 0;

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        titleSpacing: AppDimens.space16,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              shop?.name ?? 'Udhaaro Ledger',
              style: AppTypography.sectionHeading,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (shop?.address != null && shop!.address!.isNotEmpty)
              Text(
                shop.address!,
                style: AppTypography.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
        actions: [
          // Active staff actor chip
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: InkWell(
              onTap: () =>
                  _showStaffSelector(context, ref, staffList, activeStaff),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFC4E4D2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.person_pin,
                      size: 13,
                      color: AppColors.primaryDark,
                    ),
                    const SizedBox(width: 3),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 65),
                      child: Text(
                        activeStaff?.name ?? 'Owner',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryDark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Synchronization status indicator icon
          IconButton(
            icon: Icon(
              pendingCount > 0
                  ? Icons.sync_problem_rounded
                  : Icons.cloud_done_rounded,
              color: pendingCount > 0
                  ? const Color(0xFFD97706)
                  : AppColors.primary,
              size: 20,
            ),
            tooltip: pendingCount > 0
                ? '$pendingCount pending upload'
                : 'Synced to cloud',
            visualDensity: VisualDensity.compact,
            onPressed: () => _showPendingExplanationSheet(
              context,
              ref,
              shop?.id,
              pendingCount,
            ),
          ),

          // Notification Bell Icon with real-time unread badge
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined, size: 22),
                  tooltip: 'Shop Notifications',
                  visualDensity: VisualDensity.compact,
                  onPressed: () => context.push('/notifications'),
                ),
                if (unreadCount > 0)
                  Positioned(
                    right: 4,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Center(
                        child: Text(
                          unreadCount > 99 ? '99+' : '$unreadCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          if (shop != null) {
            await ref.read(syncServiceProvider).syncPending(shop.id);
          }
        },
        child: ListView(
          padding: const EdgeInsets.all(AppDimens.space16),
          children: [
            // Prominent Financial Total Card
            UdhaaroFinancialCard(
              title: 'Total Outstanding Credit',
              balanceInPaisa: balance?.outstandingBalanceInPaisa ?? 0,
              subtitle: '${customers.length} total customers registered',
              trailingBadge: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: AppDimens.roundedFull,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.shield_outlined,
                      size: 12,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'OFFLINE READY',
                      style: AppTypography.labelSmall.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppDimens.space16),

            // Quick Actions (Responsive layout)
            LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  children: [
                    Expanded(
                      child: UdhaaroCard(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppDimens.space12,
                          horizontal: AppDimens.space12,
                        ),
                        backgroundColor: AppColors.surface,
                        onTap: () => context.push('/customers/new'),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_add_outlined,
                              color: AppColors.primary,
                              size: 18,
                            ),
                            SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                'Add Customer',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: AppDimens.space12),
                    Expanded(
                      child: UdhaaroCard(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppDimens.space12,
                          horizontal: AppDimens.space12,
                        ),
                        backgroundColor: AppColors.primaryLight,
                        borderColor: const Color(0xFFC4E4D2),
                        onTap: () => context.go('/customers'),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.people_outline_rounded,
                              color: AppColors.primaryDark,
                              size: 18,
                            ),
                            SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                'View Customers',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryDark,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: AppDimens.space24),

            // Recent Customers Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Customers', style: AppTypography.sectionHeading),
                TextButton(
                  onPressed: () => context.go('/customers'),
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: AppDimens.space8),

            if (customers.isEmpty)
              UdhaaroCard(
                child: UdhaaroEmptyState(
                  icon: Icons.people_outline_rounded,
                  title: 'No Customers Yet',
                  message:
                      'Start by adding your first customer to track credits and payments.',
                  actionLabel: 'Add First Customer',
                  onAction: () => context.push('/customers/new'),
                ),
              )
            else
              ...customers.take(4).map((c) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppDimens.space8),
                  child: _DashboardCustomerItem(customer: c),
                );
              }),

            const SizedBox(height: AppDimens.space24),

            // Recent Transactions Section
            const Text(
              'Recent Ledger Activity',
              style: AppTypography.sectionHeading,
            ),
            const SizedBox(height: AppDimens.space12),

            if (recentTxs.isEmpty)
              const UdhaaroCard(
                child: Padding(
                  padding: EdgeInsets.all(AppDimens.space20),
                  child: Center(
                    child: Text(
                      'No recent transactions recorded yet.',
                      style: AppTypography.bodySmall,
                    ),
                  ),
                ),
              )
            else
              ...recentTxs.map((tx) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppDimens.space8),
                  child: _RecentTransactionTile(transaction: tx),
                );
              }),
            const SizedBox(height: AppDimens.space40),
          ],
        ),
      ),
    );
  }
}

class _DashboardCustomerItem extends ConsumerWidget {
  final dynamic customer;

  const _DashboardCustomerItem({required this.customer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balanceAsync = ref.watch(customerBalanceProvider(customer.id));
    final balance = balanceAsync.value?.outstandingBalanceInPaisa ?? 0;

    return UdhaaroCustomerTile(
      name: customer.name,
      phone: customer.phone,
      balanceInPaisa: balance,
      syncStatus: customer.syncStatus,
      onTap: () => context.push('/customers/${customer.id}'),
    );
  }
}

class _RecentTransactionTile extends ConsumerWidget {
  final LedgerTransaction transaction;

  const _RecentTransactionTile({required this.transaction});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customerAsync = ref.watch(
      customerDetailProvider(transaction.customerId),
    );
    final customerName = customerAsync.value?.name ?? 'Customer';

    final isCredit = transaction.type == TransactionType.credit;
    final formattedAmount = CurrencyFormatter.formatPaisa(
      transaction.amountInPaisa,
    );

    return UdhaaroCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.space16,
        vertical: AppDimens.space12,
      ),
      onTap: () => context.push('/customers/${transaction.customerId}'),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimens.space8),
            decoration: BoxDecoration(
              color: isCredit
                  ? AppColors.creditSurface
                  : AppColors.paymentSurface,
              borderRadius: AppDimens.rounded8,
            ),
            child: Icon(
              isCredit
                  ? Icons.arrow_outward_rounded
                  : Icons.arrow_downward_rounded,
              color: isCredit ? AppColors.credit : AppColors.payment,
              size: 20,
            ),
          ),
          const SizedBox(width: AppDimens.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customerName,
                  style: AppTypography.customerName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  DateFormatter.formatTransactionDate(transaction.createdAt),
                  style: AppTypography.bodySmall,
                ),
                if (transaction.staffName != null &&
                    transaction.staffName!.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(
                        Icons.badge_outlined,
                        size: 11,
                        color: AppColors.mutedText,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        'By: ${transaction.staffName}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.mutedText,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: AppDimens.space12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isCredit ? '+' : '-'}$formattedAmount',
                style: AppTypography.monetaryAmount.copyWith(
                  color: isCredit ? AppColors.credit : AppColors.payment,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              UdhaaroBadge(
                label: isCredit ? 'UDHAARO' : 'PAYMENT',
                type: isCredit
                    ? UdhaaroBadgeType.credit
                    : UdhaaroBadgeType.payment,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
