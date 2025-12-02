import 'package:intl/intl.dart';

class Headache {
  final int id;
  final int intensity;
  final DateTime occurenceDate;
  final int numAdvilTaken;
  final String? notes;

  Headache({
    required this.id,
    required this.intensity,
    required this.occurenceDate,
    required this.numAdvilTaken,
    this.notes,
  });

  @override
  String toString() {
    var formatter = DateFormat('MM-dd-yyyy');
    return 'Headache: Intensity=$intensity | Date=${formatter.format(occurenceDate)} | Advil Taken=$numAdvilTaken';
  }
}
