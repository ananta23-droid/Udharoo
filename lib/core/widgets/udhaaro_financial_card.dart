import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';
import '../constants/app_typography.dart';
import '../utils/currency_formatter.dart';

class UdhaaroFinancialCard extends StatelessWidget {
  final String title;
  final int balanceInPaisa;
  final String? subtitle;
  final Widget? trailingBadge;
  final Widget? actionButton;
  final bool isDarkTheme;

  const UdhaaroFinancialCard({
    super.key,
    required this.title,
    required this.balanceInPaisa,
    this.subtitle,
    this.trailingBadge,
    this.actionButton,
    this.isDarkTheme = true,
  });

  @override
  Widget build(BuildContext context) {
    final formattedBalance = CurrencyFormatter.formatPaisa(balanceInPaisa);

    if (isDarkTheme) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppDimens.space24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primaryDark, Color(0xFF1B6B46)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: AppDimens.rounded20,
          boxShadow: const [
            BoxShadow(
              color: Color(0x26104C35),
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    title.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFC0E2D1),
                      letterSpacing: 1.1,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (trailingBadge != null) ...[
                  const SizedBox(width: 8),
                  trailingBadge!,
                ],
              ],
            ),
            const SizedBox(height: AppDimens.space12),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                formattedBalance,
                style: AppTypography.mainBalance.copyWith(color: Colors.white),
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: AppDimens.space8),
              Text(
                subtitle!,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFE4F3EA),
                ),
              ),
            ],
            if (actionButton != null) ...[
              const SizedBox(height: AppDimens.space16),
              actionButton!,
            ],
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimens.space20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppDimens.rounded20,
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: AppDimens.subtleCardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  title.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondaryText,
                    letterSpacing: 1.0,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (trailingBadge != null) ...[
                const SizedBox(width: 8),
                trailingBadge!,
              ],
            ],
          ),
          const SizedBox(height: AppDimens.space8),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              formattedBalance,
              style: AppTypography.mainBalance.copyWith(
                color: balanceInPaisa > 0
                    ? AppColors.credit
                    : AppColors.mainText,
              ),
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: AppDimens.space4),
            Text(subtitle!, style: AppTypography.bodySmall),
          ],
        ],
      ),
    );
  }
}
