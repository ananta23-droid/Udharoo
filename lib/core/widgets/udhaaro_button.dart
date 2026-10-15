import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';

enum UdhaaroButtonVariant { primary, secondary, destructive, text }

class UdhaaroButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final UdhaaroButtonVariant variant;
  final IconData? icon;
  final double? width;
  final double height;

  const UdhaaroButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.variant = UdhaaroButtonVariant.primary,
    this.icon,
    this.width,
    this.height = AppDimens.minTouchTarget,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = isLoading ? null : onPressed;

    Widget child;
    if (isLoading) {
      final spinnerColor =
          variant == UdhaaroButtonVariant.primary ||
              variant == UdhaaroButtonVariant.destructive
          ? Colors.white
          : AppColors.primary;
      child = SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2.2,
          valueColor: AlwaysStoppedAnimation<Color>(spinnerColor),
        ),
      );
    } else {
      if (icon != null) {
        child = Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: AppDimens.space8),
            Text(text),
          ],
        );
      } else {
        child = Text(text);
      }
    }

    switch (variant) {
      case UdhaaroButtonVariant.primary:
        return SizedBox(
          width: width,
          height: height,
          child: ElevatedButton(
            onPressed: effectiveOnPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: child,
          ),
        );

      case UdhaaroButtonVariant.secondary:
        return SizedBox(
          width: width,
          height: height,
          child: OutlinedButton(
            onPressed: effectiveOnPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.border, width: 1.5),
              backgroundColor: AppColors.surface,
            ),
            child: child,
          ),
        );

      case UdhaaroButtonVariant.destructive:
        return SizedBox(
          width: width,
          height: height,
          child: ElevatedButton(
            onPressed: effectiveOnPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: child,
          ),
        );

      case UdhaaroButtonVariant.text:
        return SizedBox(
          width: width,
          height: height,
          child: TextButton(onPressed: effectiveOnPressed, child: child),
        );
    }
  }
}
