import 'package:flutter/foundation.dart';

@immutable
class NotificationPreferences {
  final String staffId;
  final String shopId;
  final bool notifyOnCredit;
  final bool notifyOnPayment;
  final bool notifyOnFullClearance;
  final bool notifyOwnTransactions;
  final bool pushEnabled;
  final DateTime updatedAt;

  const NotificationPreferences({
    required this.staffId,
    required this.shopId,
    this.notifyOnCredit = true,
    this.notifyOnPayment = true,
    this.notifyOnFullClearance = true,
    this.notifyOwnTransactions = false,
    this.pushEnabled = true,
    required this.updatedAt,
  });

  NotificationPreferences copyWith({
    String? staffId,
    String? shopId,
    bool? notifyOnCredit,
    bool? notifyOnPayment,
    bool? notifyOnFullClearance,
    bool? notifyOwnTransactions,
    bool? pushEnabled,
    DateTime? updatedAt,
  }) {
    return NotificationPreferences(
      staffId: staffId ?? this.staffId,
      shopId: shopId ?? this.shopId,
      notifyOnCredit: notifyOnCredit ?? this.notifyOnCredit,
      notifyOnPayment: notifyOnPayment ?? this.notifyOnPayment,
      notifyOnFullClearance:
          notifyOnFullClearance ?? this.notifyOnFullClearance,
      notifyOwnTransactions:
          notifyOwnTransactions ?? this.notifyOwnTransactions,
      pushEnabled: pushEnabled ?? this.pushEnabled,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'staff_id': staffId,
      'shop_id': shopId,
      'notify_on_credit': notifyOnCredit,
      'notify_on_payment': notifyOnPayment,
      'notify_on_full_clearance': notifyOnFullClearance,
      'notify_own_transactions': notifyOwnTransactions,
      'push_enabled': pushEnabled,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory NotificationPreferences.fromMap(Map<String, dynamic> map) {
    return NotificationPreferences(
      staffId: map['staff_id'] as String,
      shopId: map['shop_id'] as String,
      notifyOnCredit: (map['notify_on_credit'] as bool?) ?? true,
      notifyOnPayment: (map['notify_on_payment'] as bool?) ?? true,
      notifyOnFullClearance: (map['notify_on_full_clearance'] as bool?) ?? true,
      notifyOwnTransactions: (map['notify_own_transactions'] as bool?) ?? false,
      pushEnabled: (map['push_enabled'] as bool?) ?? true,
      updatedAt: map['updated_at'] != null
          ? DateTime.tryParse(map['updated_at'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  factory NotificationPreferences.defaultPreferences({
    required String staffId,
    required String shopId,
  }) {
    return NotificationPreferences(
      staffId: staffId,
      shopId: shopId,
      notifyOnCredit: true,
      notifyOnPayment: true,
      notifyOnFullClearance: true,
      notifyOwnTransactions: false,
      pushEnabled: true,
      updatedAt: DateTime.now(),
    );
  }
}
