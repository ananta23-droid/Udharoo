import 'package:flutter/material.dart';

class AppDimens {
  AppDimens._();

  // Spacing (4-point scale)
  static const double space4 = 4.0;
  static const double space8 = 8.0;
  static const double space12 = 12.0;
  static const double space14 = 14.0; // Added for notification padding
  static const double space16 = 16.0;
  static const double space20 = 20.0;
  static const double space24 = 24.0;
  static const double space32 = 32.0;
  static const double space40 = 40.0;
  static const double space48 = 48.0;

  // Radius scale
  static const double radius8 = 8.0;
  static const double radius12 = 12.0;
  static const double radius16 = 16.0;
  static const double radius20 = 20.0;
  static const double radius24 = 24.0;
  static const double radiusFull = 999.0;

  // Touch target
  static const double minTouchTarget = 48.0;

  // Common Border Radii
  static const BorderRadius rounded8 = BorderRadius.all(
    Radius.circular(radius8),
  );
  static const BorderRadius rounded12 = BorderRadius.all(
    Radius.circular(radius12),
  );
  static const BorderRadius rounded16 = BorderRadius.all(
    Radius.circular(radius16),
  );
  static const BorderRadius rounded20 = BorderRadius.all(
    Radius.circular(radius20),
  );
  static const BorderRadius rounded24 = BorderRadius.all(
    Radius.circular(radius24),
  );
  static const BorderRadius roundedFull = BorderRadius.all(
    Radius.circular(radiusFull),
  );

  // Common Shadows
  static const List<BoxShadow> subtleCardShadow = [
    BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 2)),
  ];

  static const List<BoxShadow> elevationMedium = [
    BoxShadow(color: Color(0x14000000), blurRadius: 16, offset: Offset(0, 4)),
  ];
}
