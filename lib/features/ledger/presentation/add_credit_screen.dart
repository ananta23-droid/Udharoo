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
import '../../../core/utils/date_formatter.dart';
import '../../../core/utils/input_validators.dart';
import '../../../core/widgets/udhaaro_button.dart';
import '../../../core/widgets/udhaaro_text_field.dart';
import '../../staff/models/staff.dart';
import '../../sync/models/pending_sync_op.dart';
import '../models/ledger_transaction.dart';

class AddCreditScreen extends ConsumerStatefulWidget {
  final String customerId;

  const AddCreditScreen({super.key, required this.customerId});

  @override
  ConsumerState<AddCreditScreen> createState() => _AddCreditScreenState();
}

class _AddCreditScreenState extends ConsumerState<AddCreditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  final _creditTakenByController = TextEditingController();

  DateTime? _selectedDueDate;
  Staff? _selectedStaff;
  bool _isInit = false;
  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    _creditTakenByController.dispose();
    super.dispose();
  }

  void _initDefaults() {
    if (_isInit) return;
    _isInit = true;

    final settings = ref.read(shopSettingsProvider).value;
    final defaultDays = settings?.defaultRepaymentDays ?? 30;
    _selectedDueDate = DateTime.now().add(Duration(days: defaultDays));

    final currentActor = ref.read(currentStaffActorProvider);
    _selectedStaff = currentActor;
  }

  Future<void> _pickDueDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDueDate ?? now.add(const Duration(days: 30)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _selectedDueDate = picked;
      });
    }
  }

  Future<void> _handleSubmit() async {
    if (_isSubmitting) return;
    if (!_formKey.currentState!.validate()) return;

    final parsedPaisa = CurrencyFormatter.parseInputToPaisa(
      _amountController.text,
    );
    if (parsedPaisa == null || parsedPaisa <= 0) {
      setState(() {
        _errorMessage = 'Please enter a valid positive amount';
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
        type: TransactionType.credit,
        amountInPaisa: parsedPaisa,
        note: _noteController.text.trim().isEmpty
            ? null
            : _noteController.text.trim(),
        staffId: staffId,
        staffName: staffName,
        dueDate: _selectedDueDate,
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
        action: 'credit_created',
        entityType: 'transaction',
        entityId: txId,
        detailsJson: jsonEncode({
          'customerId': widget.customerId,
          'amountInPaisa': parsedPaisa,
          'staff': staffName,
          'dueDate': _selectedDueDate?.toIso8601String(),
          'note': transaction.note,
          'creditTakenBy': _creditTakenByController.text.trim().isNotEmpty
              ? _creditTakenByController.text.trim()
              : null,
        }),
      );

      // 4. Dispatch shop-wide real-time notification
      final dispatchService = ref.read(notificationDispatchServiceProvider);
      final customer =
          ref.read(customerDetailProvider(widget.customerId)).value;
      final customerName = customer?.name ?? 'Customer';
      final currentBalance =
          ref.read(customerBalanceProvider(widget.customerId)).value;
      final newBalancePaisa =
          (currentBalance?.outstandingBalanceInPaisa ?? 0) + parsedPaisa;

      await dispatchService.notifyCreditCreated(
        shopId: shop.id,
        actorStaffId: staffId,
        actorStaffName: staffName,
        customerId: widget.customerId,
        customerName: customerName,
        transactionId: txId,
        amountInPaisa: parsedPaisa,
        remainingBalanceInPaisa: newBalancePaisa,
        creditTakenBy: _creditTakenByController.text.trim().isNotEmpty
            ? _creditTakenByController.text.trim()
            : null,
        timestamp: now,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Udhaaro of ${CurrencyFormatter.formatPaisa(parsedPaisa)} recorded successfully',
          ),
          backgroundColor: AppColors.primary,
          duration: const Duration(seconds: 2),
        ),
      );

      context.pop();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Could not record credit: ${e.toString()}';
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _initDefaults();

    final customerAsync = ref.watch(customerDetailProvider(widget.customerId));
    final activeStaffAsync = ref.watch(activeStaffListProvider);
    final customer = customerAsync.value;
    final staffList = activeStaffAsync.value ?? [];

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(title: const Text('Give Udhaaro (Credit)')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimens.space24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Customer banner
                Container(
                  padding: const EdgeInsets.all(AppDimens.space16),
                  decoration: BoxDecoration(
                    color: AppColors.creditSurface,
                    borderRadius: AppDimens.rounded16,
                    border: Border.all(color: const Color(0xFFF6C9CC)),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.credit,
                        child: Icon(
                          Icons.arrow_outward_rounded,
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
                            const Text(
                              'Credit increases the customer\'s outstanding balance',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.credit,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppDimens.space20),

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
                  label: 'Amount (in Rupees) *',
                  hintText: '0',
                  prefixText: 'Rs  ',
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: InputValidators.validateCreditAmount,
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                ),
                const SizedBox(height: AppDimens.space20),

                // Note Input
                UdhaaroTextField(
                  controller: _noteController,
                  label: 'Note / Items Taken (Optional)',
                  hintText: 'e.g. 2 bags rice, cooking oil',
                  maxLines: 2,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppDimens.space16),

                // Credit Taken By / Received By (Optional)
                UdhaaroTextField(
                  controller: _creditTakenByController,
                  label: 'Credit Taken By / Received By (Optional)',
                  hintText: 'Leave empty if customer took it directly',
                  prefixIcon: const Icon(Icons.person_outline, size: 20),
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: AppDimens.space20),

                // Repayment Terms / Due Date Section
                const Text('Repayment Due Date', style: AppTypography.label),
                const SizedBox(height: AppDimens.space8),
                Container(
                  padding: const EdgeInsets.all(AppDimens.space12),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: AppDimens.rounded12,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today_rounded,
                                size: 18,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _selectedDueDate != null
                                    ? DateFormatter.formatDisplayDate(
                                        _selectedDueDate!,
                                      )
                                    : 'No due date set',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: _pickDueDate,
                            child: const Text('Change Date'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Quick term presets
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _termChip('15 Days', 15),
                            const SizedBox(width: 8),
                            _termChip('30 Days', 30),
                            const SizedBox(width: 8),
                            _termChip('60 Days', 60),
                            const SizedBox(width: 8),
                            _termChip('90 Days', 90),
                            const SizedBox(width: 8),
                            ActionChip(
                              label: const Text('Clear'),
                              onPressed: () =>
                                  setState(() => _selectedDueDate = null),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppDimens.space20),

                // Recorded By (Staff Attribution)
                const Text(
                  'Recorded By (Staff / Owner)',
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
                const SizedBox(height: AppDimens.space32),

                // Submit Button
                UdhaaroButton(
                  text: 'Confirm & Save Udhaaro',
                  variant: UdhaaroButtonVariant.destructive,
                  isLoading: _isSubmitting,
                  onPressed: _handleSubmit,
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

  Widget _termChip(String label, int days) {
    final targetDate = DateTime.now().add(Duration(days: days));
    final isSelected = _selectedDueDate != null &&
        _selectedDueDate!.year == targetDate.year &&
        _selectedDueDate!.month == targetDate.month &&
        _selectedDueDate!.day == targetDate.day;

    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) {
        setState(() {
          _selectedDueDate = targetDate;
        });
      },
    );
  }
}
