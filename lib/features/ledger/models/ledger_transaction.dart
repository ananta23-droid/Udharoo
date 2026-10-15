enum TransactionType {
  credit, // Udhaaro given out (increases customer's outstanding balance)
  payment, // Rakam paid back (decreases customer's outstanding balance)
}

class LedgerTransaction {
  final String id;
  final String shopId;
  final String customerId;
  final TransactionType type;
  final int
  amountInPaisa; // Strictly integer minor units (1 NPR = 100 Paisa), > 0
  final String? note;
  final String? staffId;
  final String? staffName;
  final DateTime? dueDate;
  final String? paymentMethod; // 'cash', 'fonepay', 'esewa', 'bank_transfer', 'cheque', etc.
  final DateTime createdAt;
  final String syncStatus; // 'synced', 'pending', 'failed'

  const LedgerTransaction({
    required this.id,
    required this.shopId,
    required this.customerId,
    required this.type,
    required this.amountInPaisa,
    this.note,
    this.staffId,
    this.staffName,
    this.dueDate,
    this.paymentMethod,
    required this.createdAt,
    this.syncStatus = 'pending',
  }) : assert(
         amountInPaisa > 0,
         'Amount in paisa must be strictly greater than 0',
       );

  bool get isOverdue {
    if (type != TransactionType.credit || dueDate == null) return false;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final due = DateTime(dueDate!.year, dueDate!.month, dueDate!.day);
    return due.isBefore(today);
  }

  LedgerTransaction copyWith({
    String? id,
    String? shopId,
    String? customerId,
    TransactionType? type,
    int? amountInPaisa,
    String? note,
    String? staffId,
    String? staffName,
    DateTime? dueDate,
    String? paymentMethod,
    DateTime? createdAt,
    String? syncStatus,
  }) {
    return LedgerTransaction(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      customerId: customerId ?? this.customerId,
      type: type ?? this.type,
      amountInPaisa: amountInPaisa ?? this.amountInPaisa,
      note: note ?? this.note,
      staffId: staffId ?? this.staffId,
      staffName: staffName ?? this.staffName,
      dueDate: dueDate ?? this.dueDate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      createdAt: createdAt ?? this.createdAt,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shopId': shopId,
      'customerId': customerId,
      'type': type.name,
      'amountInPaisa': amountInPaisa,
      'note': note,
      'staffId': staffId,
      'staffName': staffName,
      'dueDate': dueDate?.millisecondsSinceEpoch,
      'paymentMethod': paymentMethod,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'syncStatus': syncStatus,
    };
  }

  factory LedgerTransaction.fromMap(Map<String, dynamic> map) {
    return LedgerTransaction(
      id: map['id'] as String,
      shopId: map['shopId'] as String,
      customerId: map['customerId'] as String,
      type: TransactionType.values.byName(map['type'] as String),
      amountInPaisa: map['amountInPaisa'] as int,
      note: map['note'] as String?,
      staffId: map['staffId'] as String?,
      staffName: map['staffName'] as String?,
      dueDate: map['dueDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dueDate'] as int)
          : null,
      paymentMethod: map['paymentMethod'] as String?,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      syncStatus: (map['syncStatus'] as String?) ?? 'pending',
    );
  }
}
