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
    notifyListeners();
  }

  Future<int> addHeadache(Headache h) async {
    var id = await _headacheDao.insert(h);
    await loadHeadaches();
    return id;
  }

  Future<void> deleteHeadache(int headacheId) async {
    await _timestampDao.deleteAllByHeadacheId(headacheId);
    await _headacheDao.delete(headacheId);
    await loadHeadaches();
  }
}
