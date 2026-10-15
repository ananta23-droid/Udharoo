import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/utils/input_validators.dart';
import '../../../core/widgets/udhaaro_button.dart';
import '../../../core/widgets/udhaaro_text_field.dart';
import '../../sync/models/pending_sync_op.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _shopNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _shopNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _handleCreateShop() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final authRepo = ref.read(authRepositoryProvider);
      final syncRepo = ref.read(syncRepositoryProvider);

      final shop = await authRepo.createShop(
        name: _shopNameController.text.trim(),
        phone: _phoneController.text.trim().isEmpty
            ? null
            : _phoneController.text.trim(),
        address: _addressController.text.trim().isEmpty
            ? null
            : _addressController.text.trim(),
      );

      // Queue cloud sync operation
      await syncRepo.queueOperation(
        PendingSyncOp(
          id: 'op_${DateTime.now().millisecondsSinceEpoch}_shop',
          shopId: shop.id,
          entityType: 'shop',
          entityId: shop.id,
          operationType: 'create',
          payloadJson: jsonEncode(shop.toMap()),
          createdAt: DateTime.now(),
        ),
      );

      if (!mounted) return;
      context.go('/dashboard');
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Could not set up shop: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(title: const Text('Setup Your Shop'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimens.space24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header card
                Container(
                  padding: const EdgeInsets.all(AppDimens.space20),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: AppDimens.rounded16,
                    border: Border.all(color: const Color(0xFFC4E4D2)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppDimens.space12),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.storefront_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: AppDimens.space16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Welcome to Udhaaro',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryDark,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Your offline-first digital ledger is ready to replace your paper khata.',
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.secondaryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppDimens.space24),

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

                // Shop Name
                UdhaaroTextField(
                  controller: _shopNameController,
                  label: 'Shop Name *',
                  hintText: 'e.g. Kathmandu Kirana Pasal',
                  prefixIcon: const Icon(Icons.store_outlined, size: 20),
                  validator: InputValidators.validateShopName,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppDimens.space16),

                // Phone
                UdhaaroTextField(
                  controller: _phoneController,
                  label: 'Merchant Phone (Optional)',
                  hintText: 'e.g. 9801234567',
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Icon(Icons.phone_outlined, size: 20),
                  validator: (v) =>
                      InputValidators.validatePhone(v, required: false),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppDimens.space16),

                // Address
                UdhaaroTextField(
                  controller: _addressController,
                  label: 'Location / Address (Optional)',
                  hintText: 'e.g. Ason, Kathmandu',
                  prefixIcon: const Icon(Icons.location_on_outlined, size: 20),
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _handleCreateShop(),
                ),
                const SizedBox(height: AppDimens.space32),

                // Submit Button
                UdhaaroButton(
                  text: 'Create Shop & Open Ledger',
                  isLoading: _isLoading,
                  onPressed: _handleCreateShop,
                  icon: Icons.check_circle_outline_rounded,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
