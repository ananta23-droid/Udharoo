import 'package:flutter/foundation.dart';

enum NotificationEventType {
  creditCreated('CREDIT_CREATED'),
  creditUpdated('CREDIT_UPDATED'),
  paymentReceived('PAYMENT_RECEIVED'),
  invoiceFullyPaid('INVOICE_FULLY_PAID'),
  customerAccountFullySettled('CUSTOMER_ACCOUNT_FULLY_SETTLED'),
  paymentReversed('PAYMENT_REVERSED'),
  creditReversed('CREDIT_REVERSED');

  final String value;
  const NotificationEventType(this.value);

  static NotificationEventType fromString(String val) {
    return NotificationEventType.values.firstWhere(
      (e) => e.value == val,
      orElse: () => NotificationEventType.creditCreated,
    );
  }
}

@immutable
class ShopNotification {
  final String id;
  final String shopId;
  final String recipientStaffId;
  final String? actorStaffId;
  final String? actorStaffName;
  final NotificationEventType eventType;
  final String title;
  final String message;
  final String? customerId;
  final String? customerName;
  final String? transactionId;
  final int? amountInPaisa;
  final int? remainingBalanceInPaisa;
  final bool isRead;
  final DateTime? readAt;
  final DateTime createdAt;

  const ShopNotification({
    required this.id,
    required this.shopId,
    required this.recipientStaffId,
    this.actorStaffId,
    this.actorStaffName,
    required this.eventType,
    required this.title,
    required this.message,
    this.customerId,
    this.customerName,
    this.transactionId,
    this.amountInPaisa,
    this.remainingBalanceInPaisa,
    this.isRead = false,
    this.readAt,
    required this.createdAt,
  });

  ShopNotification copyWith({
    String? id,
    String? shopId,
    String? recipientStaffId,
    String? actorStaffId,
    String? actorStaffName,
    NotificationEventType? eventType,
    String? title,
    String? message,
    String? customerId,
    String? customerName,
    String? transactionId,
    int? amountInPaisa,
    int? remainingBalanceInPaisa,
    bool? isRead,
    DateTime? readAt,
    DateTime? createdAt,
  }) {
    return ShopNotification(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      recipientStaffId: recipientStaffId ?? this.recipientStaffId,
      actorStaffId: actorStaffId ?? this.actorStaffId,
      actorStaffName: actorStaffName ?? this.actorStaffName,
      eventType: eventType ?? this.eventType,
      title: title ?? this.title,
      message: message ?? this.message,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      transactionId: transactionId ?? this.transactionId,
      amountInPaisa: amountInPaisa ?? this.amountInPaisa,
      remainingBalanceInPaisa:
          remainingBalanceInPaisa ?? this.remainingBalanceInPaisa,
      isRead: isRead ?? this.isRead,
      readAt: readAt ?? this.readAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shop_id': shopId,
      'recipient_staff_id': recipientStaffId,
      'actor_staff_id': actorStaffId,
      'actor_staff_name': actorStaffName,
      'event_type': eventType.value,
      'title': title,
      'message': message,
      'customer_id': customerId,
      'customer_name': customerName,
      'transaction_id': transactionId,
      'amount_in_paisa': amountInPaisa,
      'remaining_balance_in_paisa': remainingBalanceInPaisa,
      'is_read': isRead,
      'read_at': readAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory ShopNotification.fromMap(Map<String, dynamic> map) {
    return ShopNotification(
      id: map['id'] as String,
      shopId: map['shop_id'] as String,
      recipientStaffId: (map['recipient_staff_id'] as String?) ?? 'all',
      actorStaffId: map['actor_staff_id'] as String?,
      actorStaffName: map['actor_staff_name'] as String?,
      eventType: NotificationEventType.fromString(
        map['event_type'] as String? ?? '',
      ),
      title: map['title'] as String,
      message: map['message'] as String,
      customerId: map['customer_id'] as String?,
      customerName: map['customer_name'] as String?,
      transactionId: map['transaction_id'] as String?,
      amountInPaisa: map['amount_in_paisa'] as int?,
      remainingBalanceInPaisa: map['remaining_balance_in_paisa'] as int?,
      isRead: (map['is_read'] as bool?) ?? false,
      readAt: map['read_at'] != null
          ? DateTime.tryParse(map['read_at'] as String)
          : null,
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}
