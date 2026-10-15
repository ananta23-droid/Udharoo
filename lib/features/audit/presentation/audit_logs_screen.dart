import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/widgets/udhaaro_card.dart';
import '../../../core/widgets/udhaaro_empty_state.dart';
import '../models/audit_log_entry.dart';

class AuditLogsScreen extends ConsumerWidget {
  const AuditLogsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auditLogsAsync = ref.watch(shopAuditLogsProvider);
    final logs = auditLogsAsync.value ?? [];

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        title: const Text('Activity & Audit Trail'),
      ),
      body: auditLogsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error loading audit trail: $e')),
        data: (_) {
          if (logs.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.space24),
                child: UdhaaroCard(
                  child: UdhaaroEmptyState(
                    icon: Icons.history_rounded,
                    title: 'No Activity Logged Yet',
                    message:
                        'All shop activities (adding customers, recording credit/payment, changing staff) will be cryptographically tracked here.',
                  ),
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(AppDimens.space16),
            itemCount: logs.length,
            itemBuilder: (context, index) {
              final log = logs[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: AppDimens.space8),
                child: _AuditLogTile(log: log),
              );
            },
          );
        },
      ),
    );
  }
}

class _AuditLogTile extends StatelessWidget {
  final AuditLogEntry log;

  const _AuditLogTile({required this.log});

  IconData _iconForAction(String action) {
    if (action.contains('credit')) return Icons.arrow_outward_rounded;
    if (action.contains('payment')) return Icons.arrow_downward_rounded;
    if (action.contains('customer')) return Icons.person_outline_rounded;
    if (action.contains('staff')) return Icons.badge_outlined;
    return Icons.tune_rounded;
  }

  Color _colorForAction(String action) {
    if (action.contains('credit')) return AppColors.credit;
    if (action.contains('payment')) return AppColors.payment;
    if (action.contains('deactivated')) return AppColors.error;
    return AppColors.primary;
  }

  @override
  Widget build(BuildContext context) {
    final color = _colorForAction(log.action);
    final icon = _iconForAction(log.action);

    return UdhaaroCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.space16,
        vertical: AppDimens.space12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: color.withValues(alpha: 0.12),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: AppDimens.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        log.actionDisplayText,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.mainText,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      DateFormatter.formatTransactionDate(log.createdAt),
                      style: AppTypography.bodySmall.copyWith(fontSize: 11),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(
                      Icons.person_pin,
                      size: 13,
                      color: AppColors.mutedText,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Actor: ${log.actorName ?? "Shop Owner"}',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.secondaryText,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                if (log.detailsJson.isNotEmpty && log.detailsJson != '{}') ...[
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Text(
                      log.detailsJson,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: AppColors.secondaryText,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
