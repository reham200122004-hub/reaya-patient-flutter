import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDateTimeArabic(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy/MM/dd – hh:mm a', 'ar');
    return formatter.format(dateTime);
  }

  static String formatDateOnlyArabic(DateTime dateTime) {
    final DateFormat formatter = DateFormat('EEEE، d MMMM yyyy', 'ar');
    return formatter.format(dateTime);
  }
}
