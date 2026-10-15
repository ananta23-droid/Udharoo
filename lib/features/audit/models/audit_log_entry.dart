class AuditLogEntry {
  final String id;
  final String shopId;
  final String? actorId;
  final String? actorName;
  final String action; // 'credit_created', 'payment_recorded', 'customer_created', 'customer_updated', 'staff_activated', 'staff_deactivated', 'settings_changed'
  final String entityType; // 'transaction', 'customer', 'staff', 'settings'
  final String entityId;
  final String detailsJson;
  final DateTime createdAt;

  const AuditLogEntry({
    required this.id,
    required this.shopId,
    this.actorId,
    this.actorName,
    required this.action,
    required this.entityType,
    required this.entityId,
    required this.detailsJson,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shopId': shopId,
      'actorId': actorId,
      'actorName': actorName,
      'action': action,
      'entityType': entityType,
      'entityId': entityId,
      'detailsJson': detailsJson,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory AuditLogEntry.fromMap(Map<String, dynamic> map) {
    return AuditLogEntry(
      id: map['id'] as String,
      shopId: map['shopId'] as String,
      actorId: map['actorId'] as String?,
      actorName: map['actorName'] as String?,
      action: map['action'] as String,
      entityType: map['entityType'] as String,
      entityId: map['entityId'] as String,
      detailsJson: map['detailsJson'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String get actionDisplayText {
    switch (action) {
      case 'credit_created':
        return 'Credit Recorded';
      case 'payment_recorded':
        return 'Payment Received';
      case 'customer_created':
        return 'Customer Created';
      case 'customer_updated':
        return 'Customer Updated';
      case 'staff_activated':
        return 'Staff Activated';
      case 'staff_deactivated':
        return 'Staff Deactivated';
      case 'staff_created':
        return 'Staff Added';
      case 'staff_updated':
        return 'Staff Updated';
      case 'settings_changed':
        return 'Settings Changed';
      default:
        return action;
    }
  }
}
