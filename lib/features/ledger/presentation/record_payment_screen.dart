import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/input_validators.dart';
import '../../../core/widgets/udhaaro_button.dart';
import '../../../core/widgets/udhaaro_text_field.dart';
import '../../staff/models/staff.dart';
import '../../sync/models/pending_sync_op.dart';
import '../models/ledger_transaction.dart';

class RecordPaymentScreen extends ConsumerStatefulWidget {
  final String customerId;

  const RecordPaymentScreen({super.key, required this.customerId});

  @override
  ConsumerState<RecordPaymentScreen> createState() =>
      _RecordPaymentScreenState();
}

class _RecordPaymentScreenState extends ConsumerState<RecordPaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  String _selectedPaymentMethod = 'Cash';
  Staff? _selectedStaff;
  bool _isInit = false;
  bool _isSubmitting = false;
  String? _errorMessage;

  static const List<String> _paymentMethods = [
    'Cash',
    'Fonepay / QR',
    'eSewa',
    'Khalti',
    'Bank Transfer',
    'Cheque',
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _initDefaults() {
    if (_isInit) return;
    _isInit = true;
    final currentActor = ref.read(currentStaffActorProvider);
    _selectedStaff = currentActor;
  }

  void _setPercentageAmount(int balancePaisa, double factor) {
    final targetPaisa = (balancePaisa * factor).round();
    _amountController.text = CurrencyFormatter.paisaToEditableString(
      targetPaisa,
    );
  }

  Future<void> _handleSubmit(int currentBalancePaisa) async {
    if (_isSubmitting) return;
    if (!_formKey.currentState!.validate()) return;

    final parsedPaisa = CurrencyFormatter.parseInputToPaisa(
      _amountController.text,
    );
    if (parsedPaisa == null || parsedPaisa <= 0) {
      setState(() {
        _errorMessage = 'Please enter a valid positive payment amount';
      });
      return;
    }

    if (parsedPaisa > currentBalancePaisa) {
      setState(() {
        _errorMessage =
            'Payment cannot exceed the outstanding balance of ${CurrencyFormatter.formatPaisa(currentBalancePaisa)}';
      });
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    try {
      final shop = ref.read(currentShopProvider).value;
      if (shop == null) throw StateError('Active shop not found');

      final txRepo = ref.read(transactionRepositoryProvider);
      final syncRepo = ref.read(syncRepositoryProvider);
      final auditRepo = ref.read(auditRepositoryProvider);
      final now = DateTime.now();
      final txId = const Uuid().v4();

      final staffId = _selectedStaff?.id;
      final staffName = _selectedStaff?.name ?? 'Shop Owner';

      final transaction = LedgerTransaction(
        id: txId,
        shopId: shop.id,
        customerId: widget.customerId,
        type: TransactionType.payment,
        amountInPaisa: parsedPaisa,
        note: _noteController.text.trim().isEmpty
            ? null
            : _noteController.text.trim(),
        staffId: staffId,
        staffName: staffName,
        paymentMethod: _selectedPaymentMethod,
        createdAt: now,
        syncStatus: 'pending',
      );

      // 1. Commit locally to SQLite atomically
      await txRepo.recordTransaction(transaction);

      // 2. Queue for cloud synchronization
      await syncRepo.queueOperation(
        PendingSyncOp(
          id: 'op_${now.millisecondsSinceEpoch}_$txId',
          shopId: shop.id,
          entityType: 'transaction',
          entityId: txId,
          operationType: 'create',
          payloadJson: jsonEncode(transaction.toMap()),
          createdAt: now,
        ),
      );

      // 3. Record audit log
      await auditRepo.logAction(
        shopId: shop.id,
        actorId: staffId,
        actorName: staffName,
        action: 'payment_recorded',
        entityType: 'transaction',
        entityId: txId,
        detailsJson: jsonEncode({
          'customerId': widget.customerId,
          'amountInPaisa': parsedPaisa,
          'staff': staffName,
          'paymentMethod': _selectedPaymentMethod,
          'remainingBalanceInPaisa': currentBalancePaisa - parsedPaisa,
        }),
      );

      // 4. Dispatch shop-wide real-time notification
      final dispatchService = ref.read(notificationDispatchServiceProvider);
      final customer =
          ref.read(customerDetailProvider(widget.customerId)).value;
      final customerName = customer?.name ?? 'Customer';
      final remainingBalancePaisa =
          (currentBalancePaisa - parsedPaisa) < 0
              ? 0
              : (currentBalancePaisa - parsedPaisa);

      await dispatchService.notifyPaymentReceived(
        shopId: shop.id,
        actorStaffId: staffId,
        actorStaffName: staffName,
        customerId: widget.customerId,
        customerName: customerName,
        transactionId: txId,
        amountInPaisa: parsedPaisa,
        previousBalanceInPaisa: currentBalancePaisa,
        remainingBalanceInPaisa: remainingBalancePaisa,
        isCustomerAccountFullySettled: remainingBalancePaisa == 0,
        totalCreditClearedInPaisa: currentBalancePaisa,
        timestamp: now,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Payment of ${CurrencyFormatter.formatPaisa(parsedPaisa)} recorded successfully',
          ),
          backgroundColor: AppColors.success,
          duration: const Duration(seconds: 2),
        ),
      );

      context.pop();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Could not record payment: ${e.toString()}';
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _initDefaults();

    final customerAsync = ref.watch(customerDetailProvider(widget.customerId));
    final balanceAsync = ref.watch(customerBalanceProvider(widget.customerId));
    final activeStaffAsync = ref.watch(activeStaffListProvider);

    final customer = customerAsync.value;
    final balance = balanceAsync.value?.outstandingBalanceInPaisa ?? 0;
    final staffList = activeStaffAsync.value ?? [];

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(title: const Text('Record Payment')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimens.space24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Balance & Customer banner
                Container(
                  padding: const EdgeInsets.all(AppDimens.space16),
                  decoration: BoxDecoration(
                    color: AppColors.paymentSurface,
                    borderRadius: AppDimens.rounded16,
                    border: Border.all(color: const Color(0xFFC4E4D2)),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.primary,
                        child: Icon(
                          Icons.arrow_downward_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: AppDimens.space12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              customer?.name ?? 'Customer',
                              style: AppTypography.customerName,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Current Udhaaro: ${CurrencyFormatter.formatPaisa(balance)}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.primaryDark,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppDimens.space16),

                // Quick Partial Payment Chips
                if (balance > 0) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Quick Payment Amount',
                        style: AppTypography.label,
                      ),
                      Text(
                        'Total: ${CurrencyFormatter.formatPaisa(balance)}',
                        style: AppTypography.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ActionChip(
                          avatar: const Icon(Icons.pie_chart_outline, size: 14),
                          label: const Text('25%'),
                          onPressed: () => _setPercentageAmount(balance, 0.25),
                        ),
                        const SizedBox(width: 8),
                        ActionChip(
                          avatar: const Icon(Icons.pie_chart, size: 14),
                          label: const Text('50%'),
                          onPressed: () => _setPercentageAmount(balance, 0.50),
                        ),
                        const SizedBox(width: 8),
                        ActionChip(
                          avatar: const Icon(Icons.pie_chart, size: 14),
                          label: const Text('75%'),
                          onPressed: () => _setPercentageAmount(balance, 0.75),
                        ),
                        const SizedBox(width: 8),
                        ActionChip(
                          avatar: const Icon(Icons.check_circle_outline, size: 14),
                          label: const Text('Full Pay (100%)'),
                          backgroundColor: AppColors.primaryLight,
                          onPressed: () => _setPercentageAmount(balance, 1.0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimens.space16),
                ],

                if (_errorMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.all(AppDimens.space12),
                    decoration: BoxDecoration(
                      color: AppColors.errorSurface,
                      borderRadius: AppDimens.rounded12,
                      border: Border.all(
                        color: AppColors.error.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.error_outline_rounded,
                          color: AppColors.error,
                          size: 20,
                        ),
                        const SizedBox(width: AppDimens.space8),
                        Expanded(
                          child: Text(
                            _errorMessage!,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.error,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimens.space16),
                ],

                // Amount Input
                UdhaaroTextField(
                  controller: _amountController,
                  label: 'Payment Amount (in Rupees) *',
                  hintText: '0',
                  prefixText: 'Rs  ',
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (v) =>
                      InputValidators.validatePaymentAmount(v, balance),
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                ),
                const SizedBox(height: AppDimens.space20),

                // Payment Method Selector
                const Text('Payment Method', style: AppTypography.label),
                const SizedBox(height: AppDimens.space8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.space12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: AppDimens.rounded12,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _selectedPaymentMethod,
                      items: _paymentMethods.map((method) {
                        IconData icon;
                        switch (method) {
                          case 'Cash':
                            icon = Icons.payments_outlined;
                            break;
                          case 'Fonepay / QR':
                          case 'eSewa':
                          case 'Khalti':
                            icon = Icons.qr_code_scanner_rounded;
                            break;
                          case 'Bank Transfer':
                            icon = Icons.account_balance_outlined;
                            break;
                          default:
                            icon = Icons.receipt_outlined;
                        }
                        return DropdownMenuItem<String>(
                          value: method,
                          child: Row(
                            children: [
                              Icon(icon, size: 18, color: AppColors.primary),
                              const SizedBox(width: 8),
                              Text(method),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() => _selectedPaymentMethod = val);
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: AppDimens.space20),

                // Recorded By (Staff Attribution)
                const Text(
                  'Received By (Staff / Owner)',
                  style: AppTypography.label,
                ),
                const SizedBox(height: AppDimens.space8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.space12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: AppDimens.rounded12,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String?>(
                      isExpanded: true,
                      value: _selectedStaff?.id,
                      hint: const Text('Shop Owner (Default)'),
                      items: [
                        const DropdownMenuItem<String?>(
                          value: null,
                          child: Row(
                            children: [
                              Icon(Icons.store, size: 18, color: AppColors.primary),
                              SizedBox(width: 8),
                              Text('Shop Owner (Owner)'),
                            ],
                          ),
                        ),
                        ...staffList.map((staff) {
                          return DropdownMenuItem<String?>(
                            value: staff.id,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.badge_outlined,
                                  size: 18,
                                  color: AppColors.secondaryText,
                                ),
                                const SizedBox(width: 8),
                                Text('${staff.name} (${staff.roleDisplay})'),
                              ],
                            ),
                          );
                        }),
                      ],
                      onChanged: (id) {
                        setState(() {
                          if (id == null) {
                            _selectedStaff = null;
                          } else {
                            _selectedStaff = staffList.firstWhere(
                              (s) => s.id == id,
                              orElse: () => staffList.first,
                            );
                          }
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: AppDimens.space20),

                // Note Input
                UdhaaroTextField(
                  controller: _noteController,
                  label: 'Note / Reference (Optional)',
                  hintText: 'e.g. Transaction ID / Bank ref / partial payment note',
                  maxLines: 2,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _handleSubmit(balance),
                ),
                const SizedBox(height: AppDimens.space32),

                // Submit Button
                UdhaaroButton(
                  text: 'Confirm & Save Payment',
                  variant: UdhaaroButtonVariant.primary,
                  isLoading: _isSubmitting,
                  onPressed: () => _handleSubmit(balance),
                  icon: Icons.check_circle_outline_rounded,
                ),
                const SizedBox(height: AppDimens.space12),

                UdhaaroButton(
                  text: 'Cancel',
                  variant: UdhaaroButtonVariant.text,
                  onPressed: () => context.pop(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
