import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/utils/input_validators.dart';
import '../../../core/widgets/udhaaro_button.dart';
import '../../../core/widgets/udhaaro_text_field.dart';
import '../../sync/models/pending_sync_op.dart';
import '../models/customer.dart';

class AddEditCustomerScreen extends ConsumerStatefulWidget {
  final String? customerId; // Null for add, non-null for edit

  const AddEditCustomerScreen({super.key, this.customerId});

  @override
  ConsumerState<AddEditCustomerScreen> createState() =>
      _AddEditCustomerScreenState();
}

class _AddEditCustomerScreenState extends ConsumerState<AddEditCustomerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  String _initialName = '';
  String _initialPhone = '';
  String _initialEmail = '';

  bool _isInit = false;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _loadExistingCustomer(Customer? customer) {
    if (_isInit || customer == null) return;
    _isInit = true;
    _nameController.text = customer.name;
    _phoneController.text = customer.phone ?? '';
    _emailController.text = customer.email ?? '';
    _initialName = customer.name;
    _initialPhone = customer.phone ?? '';
    _initialEmail = customer.email ?? '';
  }

  bool _hasUnsavedChanges() {
    return _nameController.text.trim() != _initialName.trim() ||
        _phoneController.text.trim() != _initialPhone.trim() ||
        _emailController.text.trim() != _initialEmail.trim();
  }

  Future<bool> _confirmDiscard() async {
    if (!_hasUnsavedChanges()) return true;

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Discard Changes?'),
        content: const Text(
          'You have unsaved changes. Are you sure you want to discard them and exit?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Keep Editing'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Discard'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final shop = ref.read(currentShopProvider).value;
      if (shop == null) {
        throw StateError('No active shop found');
      }

      final customerRepo = ref.read(customerRepositoryProvider);
      final syncRepo = ref.read(syncRepositoryProvider);
      final auditRepo = ref.read(auditRepositoryProvider);
      final activeStaff = ref.read(currentStaffActorProvider);
      final now = DateTime.now();

      final name = _nameController.text.trim();
      final phone = _phoneController.text.trim();
      final email = _emailController.text.trim();

      if (widget.customerId == null) {
        // Create new customer
        final newCustomer = Customer(
          id: const Uuid().v4(),
          shopId: shop.id,
          name: name,
          phone: phone,
          email: email,
          createdAt: now,
          updatedAt: now,
          syncStatus: 'pending',
        );

        await customerRepo.createCustomer(newCustomer);

        // Queue sync operation
        await syncRepo.queueOperation(
          PendingSyncOp(
            id: 'op_${now.millisecondsSinceEpoch}_${newCustomer.id}',
            shopId: shop.id,
            entityType: 'customer',
            entityId: newCustomer.id,
            operationType: 'create',
            payloadJson: jsonEncode(newCustomer.toMap()),
            createdAt: now,
          ),
        );

        // Audit log
        await auditRepo.logAction(
          shopId: shop.id,
          actorId: activeStaff?.id,
          actorName: activeStaff?.name ?? 'Shop Owner',
          action: 'customer_created',
          entityType: 'customer',
          entityId: newCustomer.id,
          detailsJson: jsonEncode({
            'name': newCustomer.name,
            'phone': newCustomer.phone,
            'email': newCustomer.email,
          }),
        );

        if (!mounted) return;
        // Navigate directly to the new customer's details ledger
        context.go('/customers/${newCustomer.id}');
      } else {
        // Update existing customer
        final existing = await customerRepo.getCustomerById(widget.customerId!);
        if (existing == null) throw StateError('Customer not found');

        final updatedCustomer = existing.copyWith(
          name: name,
          phone: phone,
          email: email,
          updatedAt: now,
          syncStatus: 'pending',
        );

        await customerRepo.updateCustomer(updatedCustomer);

        // Queue sync operation
        await syncRepo.queueOperation(
          PendingSyncOp(
            id: 'op_${now.millisecondsSinceEpoch}_${updatedCustomer.id}',
            shopId: shop.id,
            entityType: 'customer',
            entityId: updatedCustomer.id,
            operationType: 'update',
            payloadJson: jsonEncode(updatedCustomer.toMap()),
            createdAt: now,
          ),
        );

        // Audit log
        await auditRepo.logAction(
          shopId: shop.id,
          actorId: activeStaff?.id,
          actorName: activeStaff?.name ?? 'Shop Owner',
          action: 'customer_updated',
          entityType: 'customer',
          entityId: updatedCustomer.id,
          detailsJson: jsonEncode({
            'name': updatedCustomer.name,
            'phone': updatedCustomer.phone,
            'email': updatedCustomer.email,
          }),
        );

        if (!mounted) return;
        context.pop();
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Could not save customer: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.customerId != null;

    if (isEditing) {
      final customerAsync = ref.watch(
        customerDetailProvider(widget.customerId!),
      );
      customerAsync.whenData(_loadExistingCustomer);
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final shouldLeave = await _confirmDiscard();
        if (shouldLeave && context.mounted) {
          context.pop();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.appBackground,
        appBar: AppBar(
          title: Text(isEditing ? 'Edit Customer' : 'Add New Customer'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              final shouldLeave = await _confirmDiscard();
              if (shouldLeave && context.mounted) {
                context.pop();
              }
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimens.space24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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

                  // Requirement Notice Card
                  Container(
                    padding: const EdgeInsets.all(AppDimens.space12),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: AppDimens.rounded12,
                      border: Border.all(color: const Color(0xFFC4E4D2)),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          color: AppColors.primaryDark,
                          size: 20,
                        ),
                        const SizedBox(width: AppDimens.space8),
                        Expanded(
                          child: Text(
                            'Both phone and email are required for automated reminders and credit notices.',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.primaryDark,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimens.space20),

                  // Customer Name
                  UdhaaroTextField(
                    controller: _nameController,
                    label: 'Customer Full Name *',
                    hintText: 'e.g. Ram Bahadur Thapa',
                    prefixIcon: const Icon(
                      Icons.person_outline_rounded,
                      size: 20,
                    ),
                    validator: InputValidators.validateCustomerName,
                    textInputAction: TextInputAction.next,
                    autofocus: !isEditing,
                  ),
                  const SizedBox(height: AppDimens.space20),

                  // Customer Phone (Mandatory)
                  UdhaaroTextField(
                    controller: _phoneController,
                    label: 'Mobile / Phone Number *',
                    hintText: 'e.g. 9841234567',
                    keyboardType: TextInputType.phone,
                    prefixIcon: const Icon(Icons.phone_outlined, size: 20),
                    validator: (v) =>
                        InputValidators.validatePhone(v, required: true),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: AppDimens.space20),

                  // Customer Email (Mandatory)
                  UdhaaroTextField(
                    controller: _emailController,
                    label: 'Email Address *',
                    hintText: 'e.g. ram.thapa@gmail.com',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.email_outlined, size: 20),
                    validator: (v) =>
                        InputValidators.validateEmail(v, required: true),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _handleSave(),
                  ),
                  const SizedBox(height: AppDimens.space32),

                  // Submit Button
                  UdhaaroButton(
                    text: isEditing ? 'Save Changes' : 'Save & Open Ledger',
                    isLoading: _isLoading,
                    onPressed: _handleSave,
                    icon: isEditing
                        ? Icons.save_outlined
                        : Icons.person_add_rounded,
                  ),
                  const SizedBox(height: AppDimens.space12),

                  // Cancel Button with unsaved confirmation
                  UdhaaroButton(
                    text: 'Cancel',
                    variant: UdhaaroButtonVariant.text,
                    onPressed: () async {
                      final shouldLeave = await _confirmDiscard();
                      if (shouldLeave && context.mounted) {
                        context.pop();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
