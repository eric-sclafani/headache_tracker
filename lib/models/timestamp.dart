import 'package:headache_tracker/enums/timestamp_type_enum.dart';

class Timestamp {
  int? id;
  String time;
  TimestampTypeEnum type;
  int headacheId;

  Timestamp({
    this.id,
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
    var type = TimestampTypeEnum.values.byName(map['type']);
    return Timestamp(
      id: map['id'] as int,
      time: map['time'] as String,
      type: type,
      headacheId: map['headacheId'] as int,
    );
  }
}
