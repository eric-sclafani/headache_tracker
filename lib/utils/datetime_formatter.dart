import 'package:intl/intl.dart';

class DateTimeFormatter {
  static final _dateFormat = DateFormat('MM/dd/yyyy');
  static final _timeFormat = DateFormat.jm();

  static String formatDate(DateTime date) {
    return _dateFormat.format(date);
  }

  static String formatTime(DateTime time) {
    var d = DateTime(2000, 1, 1, time.hour, time.minute);
    return _timeFormat.format(d);
  }
}
