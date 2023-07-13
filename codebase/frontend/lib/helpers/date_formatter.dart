import 'package:intl/intl.dart';

class DateFormatter {
  static String dayFromTime([DateTime? day]) {
    return DateFormat().add_EEEE().format(day ?? DateTime.now()).toLowerCase();
  }

  static int hhmm([DateTime? day]) {
    return int.parse((day ?? DateTime.now()).hour.toString().padLeft(2, '0') +
        (day ?? DateTime.now()).minute.toString().padLeft(2, '0'));
  }

  static String shortDay([DateTime? day]) {
    return DateFormat().add_E().format(day ?? DateTime.now());
  }

  static String date([DateTime? day]) {
    return DateFormat().add_d().format(day ?? DateTime.now());
  }
}
