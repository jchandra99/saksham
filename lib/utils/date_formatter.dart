import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(String input) {
    try {
      final parsed = DateTime.parse(input);
      return DateFormat('dd MMM yyyy').format(parsed);
    } catch (_) {
      return input;
    }
  }

  static String currentDate() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  static String currentTime() {
    return DateFormat('HH:mm').format(DateTime.now());
  }
}
