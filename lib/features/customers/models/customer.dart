class Customer {
  final String id;
  final String shopId;
  final String name;
  final String? phone;
  final String? email;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus; // 'synced', 'pending', 'failed'

  const Customer({
    required this.id,
    required this.shopId,
    required this.name,
    this.phone,
    this.email,
    required this.createdAt,
    required this.updatedAt,
    this.syncStatus = 'pending',
  });

  bool get hasIncompleteContact =>
      (phone == null || phone!.trim().isEmpty) ||
      (email == null || email!.trim().isEmpty);

  Customer copyWith({
    String? id,
    String? shopId,
    String? name,
    String? phone,
    String? email,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
  }) {
    return Customer(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shopId': shopId,
      'name': name,
      'phone': phone,
      'email': email,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'syncStatus': syncStatus,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'] as String,
      shopId: map['shopId'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String?,
      email: map['email'] as String?,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
      syncStatus: (map['syncStatus'] as String?) ?? 'pending',
    );
  }
}
