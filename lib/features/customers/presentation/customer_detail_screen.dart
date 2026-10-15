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
import '../../../core/widgets/udhaaro_empty_state.dart';
import '../../../core/widgets/udhaaro_financial_card.dart';
import '../../ledger/models/ledger_transaction.dart';

enum TransactionFilter { all, credits, payments, overdue }

class CustomerDetailScreen extends ConsumerStatefulWidget {
  final String customerId;

  const CustomerDetailScreen({super.key, required this.customerId});

  @override
  ConsumerState<CustomerDetailScreen> createState() =>
      _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends ConsumerState<CustomerDetailScreen> {
  TransactionFilter _currentFilter = TransactionFilter.all;

  @override
  Widget build(BuildContext context) {
    final customerAsync = ref.watch(customerDetailProvider(widget.customerId));
    final balanceAsync = ref.watch(customerBalanceProvider(widget.customerId));
    final transactionsAsync = ref.watch(
      customerTransactionsProvider(widget.customerId),
    );

    final customer = customerAsync.value;
    final balance = balanceAsync.value;
    final transactions = transactionsAsync.value ?? [];

    if (customerAsync.isLoading && customer == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (customer == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Customer Details')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Customer not found'),
              const SizedBox(height: AppDimens.space16),
              UdhaaroButton(
                text: 'Go to Customers',
                onPressed: () => context.go('/customers'),
                width: 180,
              ),
            ],
          ),
        ),
      );
    }

    final int outstandingBalance = balance?.outstandingBalanceInPaisa ?? 0;
    final int totalCredit = balance?.totalCreditInPaisa ?? 0;
    final int totalPayment = balance?.totalPaymentInPaisa ?? 0;

    final credits = transactions
        .where((t) => t.type == TransactionType.credit)
        .toList();
    final payments = transactions
        .where((t) => t.type == TransactionType.payment)
        .toList();
    final overdues = transactions
        .where((t) => t.isOverdue)
        .toList();

    List<LedgerTransaction> filteredTransactions;
    switch (_currentFilter) {
      case TransactionFilter.all:
        filteredTransactions = transactions;
        break;
      case TransactionFilter.credits:
        filteredTransactions = credits;
        break;
      case TransactionFilter.payments:
        filteredTransactions = payments;
        break;
      case TransactionFilter.overdue:
        filteredTransactions = overdues;
        break;
    }

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        title: Text(customer.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Edit Customer',
            onPressed: () =>
                context.push('/customers/${widget.customerId}/edit'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Header / Balance section
          Padding(
            padding: const EdgeInsets.all(AppDimens.space16),
            child: Column(
              children: [
                // Incomplete Contact Banner if phone or email is missing
                if (customer.hasIncompleteContact) ...[
                  InkWell(
                    onTap: () =>
                        context.push('/customers/${widget.customerId}/edit'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: AppDimens.rounded12,
                        border: Border.all(color: const Color(0xFFFDE68A)),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.warning_amber_rounded,
                            size: 18,
                            color: Color(0xFFD97706),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Incomplete contact info. Tap to add required phone/email for reminders.',
                              style: AppTypography.bodySmall.copyWith(
                                color: const Color(0xFF92400E),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right,
                            size: 18,
                            color: Color(0xFFD97706),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],

                // Financial Card
                UdhaaroFinancialCard(
                  title: 'Outstanding Balance',
                  balanceInPaisa: outstandingBalance,
                  subtitle: customer.email != null && customer.email!.isNotEmpty
                      ? 'Tel: ${customer.phone ?? "N/A"}  •  ${customer.email}'
                      : (customer.phone != null
                          ? 'Phone: ${customer.phone}'
                          : null),
                  trailingBadge: customer.syncStatus == 'pending'
                      ? const UdhaaroBadge(
                          label: 'Pending Sync',
                          type: UdhaaroBadgeType.pendingSync,
                        )
                      : null,
                ),
                const SizedBox(height: AppDimens.space12),

                // Metrics breakdown strip
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.creditSurface,
                          borderRadius: AppDimens.rounded8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Total Udhaaro',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.credit,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              CurrencyFormatter.formatPaisa(totalCredit),
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.credit,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: AppDimens.space8),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.paymentSurface,
                          borderRadius: AppDimens.rounded8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Total Paid',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.payment,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              CurrencyFormatter.formatPaisa(totalPayment),
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.payment,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimens.space16),

                // Primary Ledger Actions: Add Credit & Record Payment
                Row(
                  children: [
                    Expanded(
                      child: UdhaaroButton(
                        text: 'Give Udhaaro (+)',
                        icon: Icons.arrow_outward_rounded,
                        variant: UdhaaroButtonVariant.destructive,
                        onPressed: () => context.push(
                          '/customers/${widget.customerId}/add-credit',
                        ),
                      ),
                    ),
                    const SizedBox(width: AppDimens.space12),
                    Expanded(
                      child: UdhaaroButton(
                        text: 'Take Payment (-)',
                        icon: Icons.arrow_downward_rounded,
                        variant: UdhaaroButtonVariant.primary,
                        onPressed: outstandingBalance > 0
                            ? () => context.push(
                                '/customers/${widget.customerId}/record-payment',
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Filters & Section Title
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ledger History (${filteredTransactions.length})',
                  style: AppTypography.sectionHeading.copyWith(fontSize: 16),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _filterChip('All', TransactionFilter.all),
                      const SizedBox(width: 4),
                      _filterChip('Credit', TransactionFilter.credits),
                      const SizedBox(width: 4),
                      _filterChip('Paid', TransactionFilter.payments),
                      if (overdues.isNotEmpty) ...[
                        const SizedBox(width: 4),
                        _filterChip(
                          'Overdue (${overdues.length})',
                          TransactionFilter.overdue,
                          isAlert: true,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Transactions List
          Expanded(
            child: transactionsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) =>
                  Center(child: Text('Error loading transactions: $err')),
              data: (_) {
                if (filteredTransactions.isEmpty) {
                  return UdhaaroEmptyState(
                    icon: Icons.receipt_long_rounded,
                    title: _currentFilter == TransactionFilter.all
                        ? 'No Transactions Yet'
                        : 'No Matching Transactions',
                    message: _currentFilter == TransactionFilter.all
                        ? 'Record credit or payment to start tracking this customer\'s ledger.'
                        : 'No transactions found under the selected filter.',
                    actionLabel: 'Give Udhaaro (Credit)',
                    onAction: () => context.push(
                      '/customers/${widget.customerId}/add-credit',
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.space16,
                    vertical: AppDimens.space8,
                  ),
                  itemCount: filteredTransactions.length,
                  itemBuilder: (context, index) {
                    final tx = filteredTransactions[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppDimens.space8),
                      child: _TransactionHistoryTile(transaction: tx),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String label, TransactionFilter filter,
      {bool isAlert = false}) {
    final isSelected = _currentFilter == filter;
    return InkWell(
      onTap: () => setState(() => _currentFilter = filter),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? (isAlert ? AppColors.error : AppColors.primary)
              : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: isSelected
                ? Colors.white
                : (isAlert ? AppColors.error : AppColors.secondaryText),
          ),
        ),
      ),
    );
  }
}

class _TransactionHistoryTile extends StatelessWidget {
  final LedgerTransaction transaction;

  const _TransactionHistoryTile({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isCredit = transaction.type == TransactionType.credit;
    final formattedAmount = CurrencyFormatter.formatPaisa(
      transaction.amountInPaisa,
    );

    return UdhaaroCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.space16,
        vertical: AppDimens.space12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon indicator
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

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      isCredit ? 'Udhaaro Given' : 'Payment Received',
                      style: AppTypography.customerName.copyWith(fontSize: 14),
                    ),
                    if (transaction.syncStatus == 'pending') ...[
                      const SizedBox(width: AppDimens.space8),
                      const UdhaaroBadge(
                        label: 'Pending',
                        type: UdhaaroBadgeType.pendingSync,
                      ),
                    ],
                    if (transaction.isOverdue) ...[
                      const SizedBox(width: AppDimens.space8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.errorSurface,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: AppColors.error.withValues(alpha: 0.3),
                          ),
                        ),
                        child: const Text(
                          'OVERDUE',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: AppColors.error,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  DateFormatter.formatTransactionDate(transaction.createdAt),
                  style: AppTypography.bodySmall,
                ),

                // Due date if credit
                if (transaction.dueDate != null) ...[
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Icons.event_outlined,
                        size: 11,
                        color: transaction.isOverdue
                            ? AppColors.error
                            : AppColors.mutedText,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        'Due: ${DateFormatter.formatDisplayDate(transaction.dueDate!)}',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: transaction.isOverdue
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: transaction.isOverdue
                              ? AppColors.error
                              : AppColors.mutedText,
                        ),
                      ),
                    ],
                  ),
                ],

                // Payment method if payment
                if (transaction.paymentMethod != null) ...[
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(
                        Icons.payments_outlined,
                        size: 11,
                        color: AppColors.mutedText,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        'Method: ${transaction.paymentMethod}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.mutedText,
                        ),
                      ),
                    ],
                  ),
                ],

                // Staff member attribution
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

                if (transaction.note != null &&
                    transaction.note!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Note: ${transaction.note}',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.mainText,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: AppDimens.space12),

          // Amount
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isCredit ? '+' : '-'}$formattedAmount',
                style: AppTypography.monetaryAmount.copyWith(
                  color: isCredit ? AppColors.credit : AppColors.payment,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                isCredit ? 'CREDIT' : 'PAYMENT',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                  color: isCredit ? AppColors.credit : AppColors.payment,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
