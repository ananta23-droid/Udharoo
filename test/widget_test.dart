import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:udhaaro/core/providers/app_providers.dart';
import 'package:udhaaro/core/theme/app_theme.dart';
import 'package:udhaaro/data/local/app_database.dart';
import 'package:udhaaro/features/auth/presentation/onboarding_screen.dart';
import 'package:udhaaro/features/dashboard/presentation/dashboard_screen.dart';

void main() {
  testWidgets('Renders OnboardingScreen and validates form fields', (
    WidgetTester tester,
  ) async {
    final db = AppDatabase.memory();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(db)],
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          home: const OnboardingScreen(),
        ),
      ),
    );

    expect(find.text('Setup Your Shop'), findsOneWidget);
    expect(find.text('Welcome to Udhaaro'), findsOneWidget);
    expect(find.text('Create Shop & Open Ledger'), findsOneWidget);

    // Tapping submit with empty shop name triggers validation error
    await tester.tap(find.text('Create Shop & Open Ledger'));
    await tester.pumpAndSettle();

    expect(find.text('Shop name is required'), findsOneWidget);

    await db.close();
  });

  testWidgets(
    'Renders Dashboard with financial card and quick action buttons',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final db = AppDatabase.memory();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [databaseProvider.overrideWithValue(db)],
          child: MaterialApp(
            theme: AppTheme.lightTheme,
            home: const DashboardScreen(),
          ),
        ),
      );

      expect(find.text('TOTAL OUTSTANDING CREDIT'), findsOneWidget);
      expect(find.text('Rs 0'), findsOneWidget);
      expect(find.text('Add Customer'), findsOneWidget);
      expect(find.text('View Customers'), findsOneWidget);
      expect(find.text('Customers'), findsOneWidget);
      expect(find.text('Recent Ledger Activity'), findsOneWidget);

      await db.close();
    },
  );
}
