import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:headache_tracker/data/dao/headache_dao.dart';
import 'package:headache_tracker/data/dao/timestamp_dao.dart';
import 'package:headache_tracker/models/headache.dart';

class HeadacheRepository extends ChangeNotifier {
  final HeadacheDao _headacheDao;
  final TimestampDao _timestampDao;

  List<Headache> _headaches = [];

  HeadacheRepository(this._headacheDao, this._timestampDao);

  UnmodifiableListView<Headache> get headaches {
    _headaches.sort((a, b) => b.occurenceDate.compareTo(a.occurenceDate));
    return UnmodifiableListView(_headaches);
  }

  Future<void> loadHeadaches() async {
    _headaches = await _headacheDao.getAll();
    for (var h in _headaches) {
      h.timestamps = await _timestampDao.getAllByHeadacheId(h.id!);
    }
    notifyListeners();
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
