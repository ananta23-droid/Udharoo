import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/utils/input_validators.dart';
import '../../../core/widgets/udhaaro_button.dart';
import '../../../core/widgets/udhaaro_card.dart';
import '../../../core/widgets/udhaaro_empty_state.dart';
import '../../../core/widgets/udhaaro_text_field.dart';
import '../models/staff.dart';

class StaffListScreen extends ConsumerStatefulWidget {
  const StaffListScreen({super.key});

  @override
  ConsumerState<StaffListScreen> createState() => _StaffListScreenState();
}

class _StaffListScreenState extends ConsumerState<StaffListScreen> {
  void _openAddEditStaffDialog({Staff? staffToEdit}) {
    final isEditing = staffToEdit != null;
    final nameController = TextEditingController(text: staffToEdit?.name ?? '');
    final emailController =
        TextEditingController(text: staffToEdit?.email ?? '');
    final phoneController =
        TextEditingController(text: staffToEdit?.phone ?? '');
    StaffRole selectedRole = staffToEdit?.role ?? StaffRole.cashier;
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(isEditing ? 'Edit Staff Member' : 'Add New Staff'),
              content: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      UdhaaroTextField(
                        controller: nameController,
                        label: 'Staff Full Name *',
                        hintText: 'e.g. Suman Sharma',
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppDimens.space16),
                      UdhaaroTextField(
                        controller: emailController,
                        label: 'Email Address *',
                        hintText: 'e.g. suman@udhaaro.com',
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) =>
                            InputValidators.validateEmail(v, required: true),
                      ),
                      const SizedBox(height: AppDimens.space16),
                      UdhaaroTextField(
                        controller: phoneController,
                        label: 'Phone Number (Optional)',
                        hintText: 'e.g. 9801234567',
                        keyboardType: TextInputType.phone,
                        validator: (v) =>
                            InputValidators.validatePhone(v, required: false),
                      ),
                      const SizedBox(height: AppDimens.space16),
                      DropdownButtonFormField<StaffRole>(
                        initialValue: selectedRole,
                        decoration: const InputDecoration(
                          labelText: 'Role & Permissions *',
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: StaffRole.manager,
                            child: Text('Manager (Full Operations)'),
                          ),
                          DropdownMenuItem(
                            value: StaffRole.cashier,
                            child: Text('Cashier (Record Credit/Payment)'),
                          ),
                          DropdownMenuItem(
                            value: StaffRole.accountant,
                            child: Text('Accountant (Ledger & Reports)'),
                          ),
                          DropdownMenuItem(
                            value: StaffRole.readOnly,
                            child: Text('Read-Only (Viewer)'),
                          ),
                        ],
                        onChanged: (val) {
                          if (val != null) {
                            setDialogState(() => selectedRole = val);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) return;
                    final shop = ref.read(currentShopProvider).value;
                    if (shop == null) return;

                    final staffRepo = ref.read(staffRepositoryProvider);
                    final auditRepo = ref.read(auditRepositoryProvider);
                    final now = DateTime.now();

                    if (isEditing) {
                      final updated = staffToEdit.copyWith(
                        name: nameController.text.trim(),
                        email: emailController.text.trim(),
                        phone: phoneController.text.trim().isEmpty
                            ? null
                            : phoneController.text.trim(),
                        role: selectedRole,
                        updatedAt: now,
                      );
                      await staffRepo.updateStaff(updated);
                      await auditRepo.logAction(
                        shopId: shop.id,
                        action: 'staff_updated',
                        entityType: 'staff',
                        entityId: updated.id,
                        detailsJson: jsonEncode(updated.toMap()),
                      );
                    } else {
                      final newStaff = Staff(
                        id: const Uuid().v4(),
                        shopId: shop.id,
                        name: nameController.text.trim(),
                        email: emailController.text.trim(),
                        phone: phoneController.text.trim().isEmpty
                            ? null
                            : phoneController.text.trim(),
                        role: selectedRole,
                        isActive: true,
                        createdAt: now,
                        updatedAt: now,
                      );
                      await staffRepo.addStaff(newStaff);
                      await auditRepo.logAction(
                        shopId: shop.id,
                        action: 'staff_created',
                        entityType: 'staff',
                        entityId: newStaff.id,
                        detailsJson: jsonEncode(newStaff.toMap()),
                      );
                    }

                    if (ctx.mounted) Navigator.pop(ctx);
                  },
                  child: Text(isEditing ? 'Save Changes' : 'Add Staff'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _toggleStaffStatus(Staff staff) async {
    final staffRepo = ref.read(staffRepositoryProvider);
    final auditRepo = ref.read(auditRepositoryProvider);
    final newStatus = !staff.isActive;

    await staffRepo.toggleStaffStatus(staff.id, newStatus);
    await auditRepo.logAction(
      shopId: staff.shopId,
      action: newStatus ? 'staff_activated' : 'staff_deactivated',
      entityType: 'staff',
      entityId: staff.id,
      detailsJson: jsonEncode({
        'name': staff.name,
        'role': staff.role.name,
        'newStatus': newStatus,
      }),
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${staff.name} is now ${newStatus ? "Active" : "Deactivated"}',
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final staffListAsync = ref.watch(staffListProvider);
    final staffList = staffListAsync.value ?? [];

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        title: const Text('Staff & Permissions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_rounded),
            tooltip: 'Add Staff Member',
            onPressed: () => _openAddEditStaffDialog(),
          ),
        ],
      ),
      body: staffListAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error loading staff: $e')),
        data: (_) {
          if (staffList.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.space24),
                child: UdhaaroCard(
                  child: UdhaaroEmptyState(
                    icon: Icons.badge_outlined,
                    title: 'No Staff Added Yet',
                    message:
                        'Add cashiers, accountants, or managers to track who records each transaction in your shop.',
                    actionLabel: 'Add First Staff Member',
                    onAction: () => _openAddEditStaffDialog(),
                  ),
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(AppDimens.space16),
            itemCount: staffList.length,
            itemBuilder: (context, index) {
              final staff = staffList[index];
              final isOwner = staff.role == StaffRole.owner;

              return Padding(
                padding: const EdgeInsets.only(bottom: AppDimens.space12),
                child: UdhaaroCard(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: staff.isActive
                            ? AppColors.primaryLight
                            : const Color(0xFFF1F5F9),
                        child: Text(
                          staff.name.isNotEmpty
                              ? staff.name[0].toUpperCase()
                              : 'S',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: staff.isActive
                                ? AppColors.primary
                                : AppColors.mutedText,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppDimens.space12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    staff.name,
                                    style: AppTypography.customerName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: staff.isActive
                                        ? AppColors.primaryLight
                                        : const Color(0xFFF1F5F9),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    staff.roleDisplay,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: staff.isActive
                                          ? AppColors.primaryDark
                                          : AppColors.mutedText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              staff.email,
                              style: AppTypography.bodySmall,
                            ),
                            if (staff.phone != null &&
                                staff.phone!.isNotEmpty) ...[
                              Text(
                                'Phone: ${staff.phone}',
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.mutedText,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (!isOwner) ...[
                        Switch(
                          value: staff.isActive,
                          activeThumbColor: AppColors.primary,
                          onChanged: (_) => _toggleStaffStatus(staff),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit_outlined, size: 20),
                          tooltip: 'Edit Staff',
                          onPressed: () =>
                              _openAddEditStaffDialog(staffToEdit: staff),
                        ),
                      ] else ...[
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Icon(
                            Icons.lock_outline,
                            size: 18,
                            color: AppColors.mutedText,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.space16),
          child: UdhaaroButton(
            text: 'Add Staff Member',
            icon: Icons.person_add_rounded,
            onPressed: () => _openAddEditStaffDialog(),
          ),
        ),
      ),
    );
  }
}
