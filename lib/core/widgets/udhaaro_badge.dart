import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';

enum UdhaaroBadgeType {
  credit,
  payment,
  synced,
  pendingSync,
  failedSync,
  neutral,
}

class UdhaaroBadge extends StatelessWidget {
  final String label;
  final UdhaaroBadgeType type;
  final IconData? icon;

  const UdhaaroBadge({
    super.key,
    required this.label,
    this.type = UdhaaroBadgeType.neutral,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    IconData? defaultIcon;

    switch (type) {
      case UdhaaroBadgeType.credit:
        bg = AppColors.creditSurface;
        fg = AppColors.credit;
        defaultIcon = Icons.arrow_outward_rounded;
        break;
      case UdhaaroBadgeType.payment:
        bg = AppColors.paymentSurface;
        fg = AppColors.payment;
        defaultIcon = Icons.arrow_downward_rounded;
        break;
      case UdhaaroBadgeType.synced:
        bg = AppColors.successSurface;
        fg = AppColors.success;
        defaultIcon = Icons.cloud_done_rounded;
        break;
      case UdhaaroBadgeType.pendingSync:
        bg = AppColors.warningSurface;
        fg = AppColors.warning;
        defaultIcon = Icons.cloud_queue_rounded;
        break;
      case UdhaaroBadgeType.failedSync:
        bg = AppColors.errorSurface;
        fg = AppColors.error;
        defaultIcon = Icons.cloud_off_rounded;
        break;
      case UdhaaroBadgeType.neutral:
        bg = AppColors.surfaceSecondary;
        fg = AppColors.secondaryText;
        defaultIcon = null;
        break;
    }

    final effectiveIcon = icon ?? defaultIcon;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.space8,
        vertical: AppDimens.space4,
      ),
      decoration: BoxDecoration(color: bg, borderRadius: AppDimens.roundedFull),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (effectiveIcon != null) ...[
            Icon(effectiveIcon, size: 12, color: fg),
            const SizedBox(width: AppDimens.space4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: fg,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
