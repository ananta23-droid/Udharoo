import 'package:intl/intl.dart';

class CurrencyFormatter {
  CurrencyFormatter._();

  static final NumberFormat _nepaliCurrencyFormat = NumberFormat(
    '#,##,##0',
    'en_IN',
  );
  static final NumberFormat _decimalFormat = NumberFormat(
    '#,##,##0.00',
    'en_IN',
  );

  /// Converts a paisa amount (integer) to formatted NPR string, e.g. "Rs 1,500" or "Rs 1,500.50".
  static String formatPaisa(
    int paisa, {
    bool includeSymbol = true,
    bool alwaysDecimals = false,
  }) {
    final double rupees = paisa / 100.0;
    final bool hasDecimals = (paisa % 100) != 0;

    final String formatted;
    if (alwaysDecimals || hasDecimals) {
      formatted = _decimalFormat.format(rupees);
    } else {
      formatted = _nepaliCurrencyFormat.format(rupees);
    }

    if (includeSymbol) {
      return 'Rs $formatted';
    }
    return formatted;
  }

  /// Parses user text input (e.g. "1500", "1500.50", " 1,500 ") to integer paisa.
  /// Returns null if invalid, zero, or negative.
  static int? parseInputToPaisa(String? input) {
    if (input == null) return null;
    final clean = input
        .replaceAll(',', '')
        .replaceAll('Rs', '')
        .replaceAll('rs', '')
        .trim();
    if (clean.isEmpty) return null;

    final double? val = double.tryParse(clean);
    if (val == null || val.isNaN || val.isInfinite) return null;
    if (val <= 0) return null;

    // Convert to integer paisa with round to avoid IEEE 754 precision issues
    final int paisa = (val * 100).round();
    if (paisa <= 0) return null;
    return paisa;
  }

  /// Converts paisa to clean rupees string for text fields, e.g. 150000 -> "1500", 150050 -> "1500.50".
  static String paisaToEditableString(int paisa) {
    if (paisa % 100 == 0) {
      return (paisa ~/ 100).toString();
    }
    return (paisa / 100.0).toStringAsFixed(2);
  }
}
