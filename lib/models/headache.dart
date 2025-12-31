import 'package:collection/collection.dart';
import 'package:headache_tracker/enums/timestamp_type.dart';
import 'package:headache_tracker/models/timestamp.dart';
import 'package:headache_tracker/utils/datetime_formatter.dart';

class Headache {
  int id;
  int intensity;
  DateTime occurenceDate;
  String? notes;
  List<Timestamp> timestamps = [];

  Headache({
    required this.id,
    required this.intensity,
    required this.occurenceDate,
    this.notes,
  });

  String get formattedDate => DateTimeFormatter.formatDate(occurenceDate);

  int get totalAdvils =>
      timestamps.where((t) => t.type == TimestampType.advil).length;

  int get totalIcepacks =>
      timestamps.where((t) => t.type == TimestampType.icePack).length;

  int get latestTimestampId {
    var t = maxBy(timestamps, (t) => t.id);
    return t != null ? t.id + 1 : 1;
  }

  List<Timestamp> get sortedTimestamps {
    var ts = timestamps;
    ts.sort((a, b) => a.time.compareTo(b.time));
    return ts;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'intensity': intensity,
      'occurenceDate': occurenceDate,
      'notes': notes,
    };
  }
}
