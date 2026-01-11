import 'package:intl/intl.dart';

class DateTimeFormatter {
  static final _dateFormat = DateFormat('MM/dd/yyyy');
  static final _timeFormat = DateFormat.jm();
  static final _stringTimeFormat = DateFormat('h:mm a');

  static String formatDate(DateTime date) {
    return _dateFormat.format(date);
  }

  static String formatTime(DateTime time) {
    var d = DateTime(2000, 1, 1, time.hour, time.minute);
    return _timeFormat.format(d);
  }

  static DateTime parseTime(String time) {
    time = time.replaceAll('\u202F', ' ');
    final dt = _stringTimeFormat.parse(time.toUpperCase());
    return DateTime(2000, 1, 1, dt.hour, dt.minute);
  }
}
