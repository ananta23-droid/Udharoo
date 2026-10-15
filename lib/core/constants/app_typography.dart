import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  // Screen Headings (26–30, bold)
  static const TextStyle screenHeading = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.mainText,
    letterSpacing: -0.5,
    height: 1.2,
  );

  // Section Headings (18–22, semibold)
  static const TextStyle sectionHeading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.mainText,
    letterSpacing: -0.2,
    height: 1.25,
  );

  // Main Balance (30–38, bold, tabular numbers)
  static const TextStyle mainBalance = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w800,
    color: AppColors.mainText,
    letterSpacing: -0.8,
    fontFeatures: [FontFeature.tabularFigures()],
    height: 1.15,
  );

  // Customer Name / Card Title (16–18, semibold)
  static const TextStyle customerName = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColors.mainText,
    letterSpacing: -0.1,
    height: 1.3,
  );

  // Subtitle / Section title
  static const TextStyle titleMedium = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.mainText,
    height: 1.3,
  );

  // Body Text (14–16, regular)
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.mainText,
    height: 1.4,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryText,
    height: 1.35,
  );

  // Supporting Labels (12–14, medium)
  static const TextStyle label = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.secondaryText,
    letterSpacing: 0.1,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.secondaryText,
    letterSpacing: 0.2,
  );

  // Button Labels (14–16, semibold)
  static const TextStyle button = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );

  // Monetary numbers
  static const TextStyle monetaryAmount = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontFeatures: [FontFeature.tabularFigures()],
  );
  // New styles for notifications screen
  static const TextStyle screenTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.mainText,
  );

  static const TextStyle error = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.error,
  );

  static const TextStyle timestamp = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryText,
  );

}
