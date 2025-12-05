import 'package:intl/intl.dart';

class DateFormatter {
  static final _dateFormat = DateFormat('MM/dd/yyyy');

  static String format(DateTime date) {
    return _dateFormat.format(date);
  }
}
