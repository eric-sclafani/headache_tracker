import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:headache_tracker/data/dao/timestamp_dao.dart';
import 'package:headache_tracker/models/timestamp.dart';

class TimestampRepository extends ChangeNotifier {
  final TimestampDao _dao;
  List<Timestamp> _timestamps = [];

  TimestampRepository(this._dao);

  UnmodifiableListView<Timestamp> get timestamps {
    _timestamps.sort((a, b) => b.time.compareTo(a.time));
    return UnmodifiableListView(_timestamps);
  }

  Future<void> loadTimestamps(int headacheId) async {
    _timestamps = await _dao.getAllByHeadacheId(headacheId);
    notifyListeners();
  }
}
