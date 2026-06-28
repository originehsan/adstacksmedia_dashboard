import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static String formatMonthYear(DateTime date) {
    return DateFormat('MMMM yyyy').format(date);
  }

  static String formatShortMonth(DateTime date) {
    return DateFormat('MMM').format(date).toUpperCase();
  }

  static String formatYear(DateTime date) {
    return DateFormat('yyyy').format(date);
  }

  static String formatChartLabel(int year) {
    return year.toString();
  }

  static String formatCalendarHeader(DateTime date) {
    return DateFormat('MMMM yyyy').format(date);
  }

  static String formatFullDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  static String formatShortDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String formatDayMonth(DateTime date) {
    return DateFormat('dd MMM').format(date);
  }

  static List<String> getMonthNames() {
    return List.generate(12, (index) {
      return DateFormat('MMMM').format(DateTime(2000, index + 1));
    });
  }

  static List<String> getShortMonthNames() {
    return List.generate(12, (index) {
      return DateFormat('MMM')
          .format(DateTime(2000, index + 1))
          .toUpperCase();
    });
  }

  static List<int> getYearRange({
    int startYear = 2015,
    int endYear = 2030,
  }) {
    return List.generate(
      endYear - startYear + 1,
      (index) => startYear + index,
    );
  }
}