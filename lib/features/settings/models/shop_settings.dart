class ShopSettings {
  final String shopId;
  final int defaultRepaymentDays; // e.g. 1, 2, 3, 5, 7, 15, 30; 0 means no auto due date
  final bool emailRemindersEnabled;
  final String? senderEmail;
  final int reminderIntervalDays;
  final bool smsRemindersEnabled;
  final String? smsProviderConfigJson;
  final DateTime updatedAt;

  const ShopSettings({
    required this.shopId,
    this.defaultRepaymentDays = 30,
    this.emailRemindersEnabled = false,
    this.senderEmail,
    this.reminderIntervalDays = 3,
    this.smsRemindersEnabled = false,
    this.smsProviderConfigJson,
    required this.updatedAt,
  });

  static ShopSettings defaultForShop(String shopId) => ShopSettings(
        shopId: shopId,
        defaultRepaymentDays: 30,
        emailRemindersEnabled: false,
        senderEmail: null,
        reminderIntervalDays: 3,
        smsRemindersEnabled: false,
        smsProviderConfigJson: null,
        updatedAt: DateTime.now(),
      );

  static ShopSettings defaultSettings(String shopId) => defaultForShop(shopId);

  ShopSettings copyWith({
    String? shopId,
    int? defaultRepaymentDays,
    bool? emailRemindersEnabled,
    String? senderEmail,
    int? reminderIntervalDays,
    bool? smsRemindersEnabled,
    String? smsProviderConfigJson,
    DateTime? updatedAt,
  }) {
    return ShopSettings(
      shopId: shopId ?? this.shopId,
      defaultRepaymentDays: defaultRepaymentDays ?? this.defaultRepaymentDays,
      emailRemindersEnabled: emailRemindersEnabled ?? this.emailRemindersEnabled,
      senderEmail: senderEmail ?? this.senderEmail,
      reminderIntervalDays: reminderIntervalDays ?? this.reminderIntervalDays,
      smsRemindersEnabled: smsRemindersEnabled ?? this.smsRemindersEnabled,
      smsProviderConfigJson: smsProviderConfigJson ?? this.smsProviderConfigJson,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shopId': shopId,
      'defaultRepaymentDays': defaultRepaymentDays,
      'emailRemindersEnabled': emailRemindersEnabled,
      'senderEmail': senderEmail,
      'reminderIntervalDays': reminderIntervalDays,
      'smsRemindersEnabled': smsRemindersEnabled,
      'smsProviderConfigJson': smsProviderConfigJson,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory ShopSettings.fromMap(Map<String, dynamic> map) {
    return ShopSettings(
      shopId: map['shopId'] as String,
      defaultRepaymentDays: (map['defaultRepaymentDays'] as int?) ?? 30,
      emailRemindersEnabled: (map['emailRemindersEnabled'] as bool?) ?? false,
      senderEmail: map['senderEmail'] as String?,
      reminderIntervalDays: (map['reminderIntervalDays'] as int?) ?? 3,
      smsRemindersEnabled: (map['smsRemindersEnabled'] as bool?) ?? false,
      smsProviderConfigJson: map['smsProviderConfigJson'] as String?,
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }
}
