import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/widgets/udhaaro_customer_tile.dart';
import '../../../core/widgets/udhaaro_empty_state.dart';
import '../models/customer.dart';

class CustomerListScreen extends ConsumerStatefulWidget {
  const CustomerListScreen({super.key});

  @override
  ConsumerState<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends ConsumerState<CustomerListScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customersAsync = ref.watch(customersListProvider);
    final allCustomers = customersAsync.value ?? [];

    final filteredCustomers = _searchQuery.isEmpty
        ? allCustomers
        : allCustomers.where((c) {
            final q = _searchQuery.toLowerCase();
            final nameMatch = c.name.toLowerCase().contains(q);
            final phoneMatch = c.phone?.toLowerCase().contains(q) ?? false;
            return nameMatch || phoneMatch;
          }).toList();

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        title: Text('Customers (${allCustomers.length})'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person_add_alt_1_rounded,
              color: AppColors.primary,
            ),
            tooltip: 'Add Customer',
            onPressed: () => context.go('/customers/new'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(AppDimens.space16),
            child: TextField(
              controller: _searchController,
              onChanged: (val) {
                setState(() {
                  _searchQuery = val.trim();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search by name or phone...',
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppColors.secondaryText,
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded, size: 20),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.space16,
                  vertical: AppDimens.space12,
                ),
              ),
            ),
          ),

          // Customer List
          Expanded(
            child: customersAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) =>
                  Center(child: Text('Error loading customers: $err')),
              data: (_) {
                if (allCustomers.isEmpty) {
                  return UdhaaroEmptyState(
                    icon: Icons.group_add_rounded,
                    title: 'No Customers Added Yet',
                    message: 'Add your shop customers to record credit and payments.',
                    actionLabel: 'Add First Customer',
                    onAction: () => context.go('/customers/new'),
                  );
                }

                if (filteredCustomers.isEmpty) {
                  return UdhaaroEmptyState(
                    icon: Icons.search_off_rounded,
                    title: 'No Customers Found',
                    message:
                        'No customer matches "$_searchQuery". Try searching with another name or phone number.',
                    actionLabel: 'Clear Search',
                    onAction: () {
                      _searchController.clear();
                      setState(() {
                        _searchQuery = '';
                      });
                    },
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.space16,
                  ),
                  itemCount: filteredCustomers.length,
                  itemBuilder: (context, index) {
                    final customer = filteredCustomers[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppDimens.space8),
                      child: _CustomerItemTile(customer: customer),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/customers/new'),
        tooltip: 'Add Customer',
        child: const Icon(Icons.add_rounded, size: 28),
      ),
    );
  }
}

class _CustomerItemTile extends ConsumerWidget {
  final Customer customer;

  const _CustomerItemTile({required this.customer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balanceAsync = ref.watch(customerBalanceProvider(customer.id));
    final balance = balanceAsync.value?.outstandingBalanceInPaisa ?? 0;

    return UdhaaroCustomerTile(
      name: customer.name,
      phone: customer.phone,
      balanceInPaisa: balance,
      syncStatus: customer.syncStatus,
      onTap: () => context.go('/customers/${customer.id}'),
    );
  }
}
