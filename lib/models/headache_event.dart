import 'package:intl/intl.dart';

class HeadacheEvent {
  int id;
  int intensity;
  DateTime occurenceDate;
  int numAdvilTaken;
  String? notes;

  HeadacheEvent({
    required this.id,
    required this.intensity,
    required this.occurenceDate,
    required this.numAdvilTaken,
    this.notes,
  });

  @override
  String toString() {
    var formatter = DateFormat('MM-dd-yyyy');
    return 'Id:$id | Intensity=$intensity | Date=${formatter.format(occurenceDate)} | Advil Taken=$numAdvilTaken | Notes=$notes';
  }
}
