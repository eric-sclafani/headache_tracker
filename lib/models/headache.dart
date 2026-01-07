import 'package:headache_tracker/enums/timestamp_type.dart';
import 'package:headache_tracker/models/timestamp.dart';

class Headache {
  int id;
  int intensity;
  String occurenceDate;
  String? notes;
  List<Timestamp> timestamps = [];

  Headache({
    required this.id,
    required this.intensity,
    required this.occurenceDate,
    this.notes,
  });

  int get totalAdvils =>
      timestamps.where((t) => t.type == TimestampType.advil).length;

  int get totalIcepacks =>
      timestamps.where((t) => t.type == TimestampType.icePack).length;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'intensity': intensity,
      'occurenceDate': occurenceDate,
      'notes': notes,
    };
  }

  factory Headache.fromMap(Map<String, dynamic> map) {
    return Headache(
      id: map['id'] as int,
      intensity: map['intensity'] as int,
      occurenceDate: map['occurenceDate'] as String,
      notes: map['notes'] as String,
    );
  }
}
