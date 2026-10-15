import 'currency_formatter.dart';

class InputValidators {
  InputValidators._();

  static String? validateCustomerName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Customer name is required';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  static String? validateShopName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Shop name is required';
    }
    if (value.trim().length < 2) {
      return 'Shop name must be at least 2 characters';
    }
    return null;
  }

  /// Flexible phone validation accommodating Nepali formats (e.g. 98XXXXXXXX, 97XXXXXXXX, 01-XXXXXXX)
  /// and international numbers.
  static String? validatePhone(String? value, {bool required = true}) {
    if (value == null || value.trim().isEmpty) {
      if (required) return 'Phone number is required';
      return null;
    }
    final clean = value.replaceAll(RegExp(r'[\s\-\(\)\+]'), '');
    if (clean.length < 7 || clean.length > 15) {
      return 'Enter a valid phone number (7-15 digits)';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(clean)) {
      return 'Phone number should only contain digits';
    }
    return null;
  }

  /// Email validation with RFC standard pattern support
  static String? validateEmail(String? value, {bool required = true}) {
    if (value == null || value.trim().isEmpty) {
      if (required) return 'Email address is required';
      return null;
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    );
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validateCreditAmount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter an amount';
    }
    final paisa = CurrencyFormatter.parseInputToPaisa(value);
    if (paisa == null || paisa <= 0) {
      return 'Enter a valid amount greater than zero';
    }
    if (paisa > 1000000000) {
      // Rs 10,000,000 limit
      return 'Amount exceeds maximum allowed limit';
    }
    return null;
  }

  static String? validatePaymentAmount(
    String? value,
    int currentBalanceInPaisa,
  ) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter payment amount';
    }
    final paisa = CurrencyFormatter.parseInputToPaisa(value);
    if (paisa == null || paisa <= 0) {
      return 'Enter a valid amount greater than zero';
    }
    if (paisa > currentBalanceInPaisa) {
      return 'Payment cannot exceed current outstanding balance';
    }
    return null;
  }
}
