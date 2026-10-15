import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';
import '../constants/app_typography.dart';
import '../utils/currency_formatter.dart';
import 'udhaaro_badge.dart';

class UdhaaroCustomerTile extends StatelessWidget {
  final String name;
  final String? phone;
  final int balanceInPaisa;
  final VoidCallback onTap;
  final String? syncStatus; // 'synced', 'pending', 'failed'

  const UdhaaroCustomerTile({
    super.key,
    required this.name,
    this.phone,
    required this.balanceInPaisa,
    required this.onTap,
    this.syncStatus,
  });

  String _getInitials(String input) {
    final parts = input.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts[0].isEmpty) return '?';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final initial = _getInitials(name);
    final hasBalance = balanceInPaisa > 0;

    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: AppDimens.rounded16,
        side: const BorderSide(color: AppColors.border, width: 1),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppDimens.rounded16,
        splashColor: AppColors.primaryLight.withValues(alpha: 0.4),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.space16,
            vertical: AppDimens.space12,
          ),
          child: Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 22,
                backgroundColor: hasBalance
                    ? AppColors.primaryLight
                    : AppColors.surfaceSecondary,
                child: Text(
                  initial,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: hasBalance
                        ? AppColors.primary
                        : AppColors.secondaryText,
                  ),
                ),
              ),
              const SizedBox(width: AppDimens.space12),

              // Name and Phone
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            name,
                            style: AppTypography.customerName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (syncStatus == 'pending') ...[
                          const SizedBox(width: AppDimens.space8),
                          const UdhaaroBadge(
                            label: 'Pending',
                            type: UdhaaroBadgeType.pendingSync,
                          ),
                        ],
                      ],
                    ),
                    if (phone != null && phone!.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        phone!,
                        style: AppTypography.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: AppDimens.space12),

              // Balance Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    CurrencyFormatter.formatPaisa(balanceInPaisa),
                    style: AppTypography.monetaryAmount.copyWith(
                      color: hasBalance ? AppColors.credit : AppColors.mainText,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    hasBalance ? 'UDHAARO' : 'SETTLED',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.6,
                      color: hasBalance ? AppColors.credit : AppColors.success,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: AppDimens.space4),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.mutedText,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
