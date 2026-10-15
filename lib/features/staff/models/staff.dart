enum StaffRole {
  owner,
  manager,
  accountant,
  cashier,
  readOnly;

  String get displayName {
    switch (this) {
      case StaffRole.owner:
        return 'Shop Owner';
      case StaffRole.manager:
        return 'Manager';
      case StaffRole.accountant:
        return 'Accountant';
      case StaffRole.cashier:
        return 'Cashier';
      case StaffRole.readOnly:
        return 'Read-Only Staff';
    }
  }

  bool get canManageStaff => this == StaffRole.owner || this == StaffRole.manager;
  bool get canModifySettings => this == StaffRole.owner;
  bool get canRecordTransactions => this != StaffRole.readOnly;
  bool get canViewAuditLogs => this == StaffRole.owner || this == StaffRole.manager;
}

class Staff {
  final String id;
  final String shopId;
  final String name;
  final String email;
  final String? phone;
  final StaffRole role;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Staff({
    required this.id,
    required this.shopId,
    required this.name,
    required this.email,
    this.phone,
    this.role = StaffRole.cashier,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  String get roleDisplay => role.displayName;

  Staff copyWith({
    String? id,
    String? shopId,
    String? name,
    String? email,
    String? phone,
    StaffRole? role,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Staff(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shopId': shopId,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role.name,
      'isActive': isActive,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Staff.fromMap(Map<String, dynamic> map) {
    return Staff(
      id: map['id'] as String,
      shopId: map['shopId'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String?,
      role: StaffRole.values.byName((map['role'] as String?) ?? 'cashier'),
      isActive: (map['isActive'] as bool?) ?? true,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }
}
