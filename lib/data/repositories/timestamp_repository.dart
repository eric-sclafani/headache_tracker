import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:headache_tracker/data/dao/timestamp_dao.dart';
import 'package:headache_tracker/models/timestamp.dart';
import 'package:intl/intl.dart';

class TimestampRepository extends ChangeNotifier {
  final TimestampDao _dao;
  static final dateFormat = DateFormat('h:mm a');
  List<Timestamp> _timestamps = [];

  TimestampRepository(this._dao);

  UnmodifiableListView<Timestamp> get timestamps {
    _timestamps.sort((a, b) => parseTime(a.time).compareTo(parseTime(b.time)));
    return UnmodifiableListView(_timestamps);
  }

  Future<void> loadTimestamps(int headacheId) async {
    _timestamps = await _dao.getAllByHeadacheId(headacheId);
    notifyListeners();
  }

  static DateTime parseTime(String time) {
    time = time.replaceAll('\u202F', ' ');
    final dt = dateFormat.parse(time.toUpperCase());
    return DateTime(2000, 1, 1, dt.hour, dt.minute);
  }
}
