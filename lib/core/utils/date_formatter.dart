import 'package:intl/intl.dart';

class DateFormatter {
  /// Converts an ISO 8601 date string like "2027-06-07T10:30:00.000000Z" to "7/6/2027"
  static String formatDate(String? isoDate) {
    if (isoDate == null || isoDate.isEmpty) return '';
    try {
      final DateTime date = DateTime.parse(isoDate).toLocal();
      return DateFormat('d/M/yyyy').format(date);
    } catch (e) {
      return '';
    }
  }

  /// Extracts the time from an ISO 8601 date string and formats it like "10:30"
  static String formatTime(String? isoDate) {
    if (isoDate == null || isoDate.isEmpty) return '';
    try {
      final DateTime date = DateTime.parse(isoDate).toLocal();
      return DateFormat('HH:mm').format(date);
    } catch (e) {
      return '';
    }
  }
}
