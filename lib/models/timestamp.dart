import 'package:headache_tracker/enums/timestamp_type.dart';

class Timestamp {
  int id;
  String time;
  TimestampType type;
  int headacheId;

  Timestamp({
    required this.id,
    required this.time,
    required this.type,
    required this.headacheId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'time': time,
      'type': type.name,
      'headacheId': headacheId,
    };
  }

  factory Timestamp.fromMap(Map<String, dynamic> map) {
    return Timestamp(
      id: map['id'] as int,
      time: map['time'] as String,
      type: map['type'] as TimestampType,
      headacheId: map['headacheId'] as int,
    );
  }
}
