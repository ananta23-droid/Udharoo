import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';

class UdhaaroCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color borderColor;
  final BorderRadius borderRadius;
  final List<BoxShadow>? shadows;

  const UdhaaroCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppDimens.space16),
    this.onTap,
    this.backgroundColor = AppColors.surface,
    this.borderColor = AppColors.border,
    this.borderRadius = AppDimens.rounded16,
    this.shadows = AppDimens.subtleCardShadow,
  });

  @override
  Widget build(BuildContext context) {
    final cardContent = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        border: Border.all(color: borderColor, width: 1),
        boxShadow: shadows,
      ),
      child: child,
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          splashColor: AppColors.primaryLight.withValues(alpha: 0.4),
          highlightColor: AppColors.primaryLight.withValues(alpha: 0.2),
          child: cardContent,
        ),
      );
    }

    return cardContent;
  }
}
