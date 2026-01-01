import 'package:flutter/material.dart';
import 'package:headache_tracker/enums/timestamp_type.dart';
import 'package:headache_tracker/utils/datetime_formatter.dart';

class Timestamp {
  int id;
  TimeOfDay time;
  TimestampType type;
  int headacheId;

  Timestamp({
    required this.id,
    required this.time,
    required this.type,
    required this.headacheId,
  });

  String get formattedTime => DateTimeFormatter.formatTime(time);

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
      time: map['time'] as TimeOfDay,
      type: map['type'] as TimestampType,
      headacheId: map['headacheId'] as int,
    );
  }
}
