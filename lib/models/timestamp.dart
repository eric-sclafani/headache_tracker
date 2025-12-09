import 'package:flutter/material.dart';
import 'package:headache_tracker/enums/timestamp_type.dart';
import 'package:headache_tracker/utils/datetime_formatter.dart';

class Timestamp {
  int id;
  TimeOfDay time;
  TimestampType type;

  Timestamp({required this.id, required this.time, required this.type});

  String get formattedTime => DateTimeFormatter.formatTime(time);
}
