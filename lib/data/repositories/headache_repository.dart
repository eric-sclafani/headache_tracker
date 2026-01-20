import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:headache_tracker/data/dao/headache_dao.dart';
import 'package:headache_tracker/data/dao/timestamp_dao.dart';
import 'package:headache_tracker/models/headache.dart';
import 'package:headache_tracker/utils/datetime_formatter.dart';

class HeadacheRepository extends ChangeNotifier {
  final HeadacheDao _headacheDao;
  final TimestampDao _timestampDao;

  List<Headache> _headacheList = [];
  final Map<String, List<Headache>> _headacheMap = {};

  HeadacheRepository(this._headacheDao, this._timestampDao);

  UnmodifiableListView<Headache> get headacheList =>
      UnmodifiableListView(_headacheList);

  List<MapEntry<String, List<Headache>>> get headacheMap =>
      _headacheMap.entries.toList();

  Future<void> loadHeadaches() async {
    _headacheList = await _headacheDao.getAll();
    for (var h in _headacheList) {
      h.timestamps = await _timestampDao.getAllByHeadacheId(h.id!);
    }
    _populateHeadacheMap();
    notifyListeners();
  }

  void _populateHeadacheMap() {
    for (var h in _headacheList) {
      var monthYearStr = DateTimeFormatter.formatMonthYear(h.occurenceDate);
      if (!_headacheMap.containsKey(monthYearStr)) {
        _headacheMap[monthYearStr] = [];
      }
      _headacheMap[monthYearStr]?.add(h);
    }
  }

  Future<void> updateHeadache(Headache h) async {
    await _headacheDao.update(h);
    await _timestampDao.delete(h.id!);
    for (var timestamp in h.timestamps) {
      timestamp.headacheId = h.id!;
      await _timestampDao.insert(timestamp);
    }

    await loadHeadaches();
  }

  Future<int> addHeadache(Headache h) async {
    var id = await _headacheDao.insert(h);

    for (var timestamp in h.timestamps) {
      timestamp.headacheId = id;
      await _timestampDao.insert(timestamp);
    }

    await loadHeadaches();
    return id;
  }

  Future<void> deleteHeadache(int headacheId) async {
    await _timestampDao.delete(headacheId);
    await _headacheDao.delete(headacheId);
    await loadHeadaches();
  }
}
