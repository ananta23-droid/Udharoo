class PendingSyncOp {
  final String id;
  final String shopId;
  final String entityType; // 'customer', 'transaction', 'shop'
  final String entityId;
  final String operationType; // 'create', 'update'
  final String payloadJson;
  final DateTime createdAt;
  final int retryCount;
  final String? lastError;

  const PendingSyncOp({
    required this.id,
    required this.shopId,
    required this.entityType,
    required this.entityId,
    required this.operationType,
    required this.payloadJson,
    required this.createdAt,
    this.retryCount = 0,
    this.lastError,
  });

  PendingSyncOp copyWith({
    String? id,
    String? shopId,
    String? entityType,
    String? entityId,
    String? operationType,
    String? payloadJson,
    DateTime? createdAt,
    int? retryCount,
    String? lastError,
  }) {
    return PendingSyncOp(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      operationType: operationType ?? this.operationType,
      payloadJson: payloadJson ?? this.payloadJson,
      createdAt: createdAt ?? this.createdAt,
      retryCount: retryCount ?? this.retryCount,
      lastError: lastError ?? this.lastError,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shopId': shopId,
      'entityType': entityType,
      'entityId': entityId,
      'operationType': operationType,
      'payloadJson': payloadJson,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'retryCount': retryCount,
      'lastError': lastError,
    };
  }

  factory PendingSyncOp.fromMap(Map<String, dynamic> map) {
    return PendingSyncOp(
      id: map['id'] as String,
      shopId: map['shopId'] as String,
      entityType: map['entityType'] as String,
      entityId: map['entityId'] as String,
      operationType: map['operationType'] as String,
      payloadJson: map['payloadJson'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      retryCount: (map['retryCount'] as int?) ?? 0,
      lastError: map['lastError'] as String?,
    );
  }
}
