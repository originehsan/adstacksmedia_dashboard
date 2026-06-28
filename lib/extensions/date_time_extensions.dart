import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return day == now.day && month == now.month && year == now.year;
  }

  String get monthName {
    return DateFormat('MMMM').format(this);
  }

  String get shortMonthName {
    return DateFormat('MMM').format(this).toUpperCase();
  }

  String get yearString {
    return DateFormat('yyyy').format(this);
  }

  String get formattedDate {
    return DateFormat('dd MMM yyyy').format(this);
  }

  String get formattedDateShort {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  String get dayName {
    return DateFormat('EEEE').format(this);
  }

  String get shortDayName {
    return DateFormat('EEE').format(this);
  }

  bool isSameDay(DateTime other) {
    return day == other.day &&
        month == other.month &&
        year == other.year;
  }
}