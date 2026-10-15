import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Brand
  static const Color primary = Color(0xFF146C43);
  static const Color primaryDark = Color(0xFF104C35);
  static const Color primaryLight = Color(0xFFE4F3EA);

  // Backgrounds & Surfaces
  static const Color appBackground = Color(0xFFF6F8F6);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSecondary = Color(0xFFF0F4F1);

  // Text Colors
  static const Color mainText = Color(0xFF17231D);
  static const Color secondaryText = Color(0xFF68756D);
  static const Color mutedText = Color(0xFF94A39A);

  // Borders & Dividers
  static const Color border = Color(0xFFE3E9E4);
  static const Color borderSubtle = Color(0xFFEFF3EF);

  // Semantic Feedback
  static const Color success = Color(0xFF218653);
  static const Color successSurface = Color(0xFFE7F6ED);
  static const Color error = Color(0xFFC43D45);
  static const Color errorLight = Color(0xFFFCECEE); // Added light variant for notifications
  static const Color errorSurface = Color(0xFFFCECEE);
  static const Color warning = Color(0xFFA86412);
  static const Color warningSurface = Color(0xFFFFF3D9);

  // Financial Semantics
  static const Color credit = Color(
    0xFFC43D45,
  ); // Udhaaro given out (owed to shop)
  static const Color creditSurface = Color(0xFFFDF0F1);
  static const Color payment = Color(0xFF146C43); // Udhaaro collected
  static const Color paymentSurface = Color(0xFFE4F3EA);
}
