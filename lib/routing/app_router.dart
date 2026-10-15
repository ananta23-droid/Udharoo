import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/onboarding_screen.dart';
import '../features/auth/presentation/splash_screen.dart';
import '../features/customers/presentation/add_edit_customer_screen.dart';
import '../features/customers/presentation/customer_detail_screen.dart';
import '../features/customers/presentation/customer_list_screen.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';
import '../features/ledger/presentation/add_credit_screen.dart';
import '../features/ledger/presentation/record_payment_screen.dart';
import '../features/navigation/main_scaffold.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../features/staff/presentation/staff_list_screen.dart';
import '../features/audit/presentation/audit_logs_screen.dart';
import '../features/notifications/presentation/notifications_screen.dart';
import '../features/notifications/presentation/notification_preferences_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    // Splash / Session restoration route
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),

    // Onboarding / Shop Setup route
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),

    // Bottom Navigation Shell
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScaffold(navigationShell: navigationShell);
      },
      branches: [
        // Branch 1: Dashboard
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              builder: (context, state) => const DashboardScreen(),
            ),
          ],
        ),

        // Branch 2: Customers
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/customers',
              builder: (context, state) => const CustomerListScreen(),
            ),
          ],
        ),

        // Branch 3: Settings
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),

    // Customer operations
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/customers/new',
      builder: (context, state) => const AddEditCustomerScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/customers/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return CustomerDetailScreen(customerId: id);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/customers/:id/edit',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return AddEditCustomerScreen(customerId: id);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/customers/:id/add-credit',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return AddCreditScreen(customerId: id);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/customers/:id/record-payment',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return RecordPaymentScreen(customerId: id);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/customer/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return CustomerDetailScreen(customerId: id);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/notifications',
      builder: (context, state) => const NotificationsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/settings/notifications',
      builder: (context, state) => const NotificationPreferencesScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/settings/staff',
      builder: (context, state) => const StaffListScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/settings/audit',
      builder: (context, state) => const AuditLogsScreen(),
    ),
  ],
);
