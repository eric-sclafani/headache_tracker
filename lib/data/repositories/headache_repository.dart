import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:headache_tracker/data/dao/headache_dao.dart';
import 'package:headache_tracker/models/headache.dart';

class HeadacheRepository extends ChangeNotifier {
  final HeadacheDao _dao;

  List<Headache> _headaches = [];

  HeadacheRepository(this._dao);

  UnmodifiableListView<Headache> get headaches {
    _headaches.sort((a, b) => b.occurenceDate.compareTo(a.occurenceDate));
    return UnmodifiableListView(_headaches);
  }

  Future<void> loadHeadaches() async {
    _headaches = await _dao.getAll();
    notifyListeners();
  }

  Future<void> addHeadache(Headache h) async {
    await _dao.insert(h);
    await loadHeadaches();
  }
}
