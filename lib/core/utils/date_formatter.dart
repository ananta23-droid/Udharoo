import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static final DateFormat _timeFormat = DateFormat('h:mm a');
  static final DateFormat _dateFormat = DateFormat('d MMM y');
  static final DateFormat _fullFormat = DateFormat('d MMM y, h:mm a');

  static String formatTransactionDate(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateOnly = DateTime(dateTime.year, dateTime.month, dateTime.day);

    final timeStr = _timeFormat.format(dateTime);

    if (dateOnly == today) {
      return 'Today, $timeStr';
    } else if (dateOnly == yesterday) {
      return 'Yesterday, $timeStr';
    } else if (now.year == dateTime.year) {
      return '${DateFormat('d MMM').format(dateTime)}, $timeStr';
    } else {
      return _fullFormat.format(dateTime);
    }
  }

  static String formatDate(DateTime dateTime) {
    return _dateFormat.format(dateTime);
  }

  static String formatDisplayDate(DateTime dateTime) {
    return _dateFormat.format(dateTime);
  }

  static String formatTime(DateTime dateTime) {
    return _timeFormat.format(dateTime);
  }
}
