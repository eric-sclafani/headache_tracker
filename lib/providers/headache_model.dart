import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:headache_tracker/models/headache_event.dart';

class HeadacheModel extends ChangeNotifier {
  final List<HeadacheEvent> _headaches = _initSeedData();

  UnmodifiableListView<HeadacheEvent> get allHeadaches =>
      UnmodifiableListView(_headaches);

  int get totalHeadaches => _headaches.length;

  void add(HeadacheEvent headache) {
    headache.id = _getLatestId();
    _headaches.add(headache);
    notifyListeners();
  }

  int _getLatestId() {
    var h = maxBy(_headaches, (h) => h.id);
    return h != null ? h.id + 1 : 0;
  }
}

// IDEA: have a "timestamp" data type. Different types of timestamps: advil, Icepack, etc..
List<HeadacheEvent> _initSeedData() {
  List<HeadacheEvent> data = [];
  data.add(
    HeadacheEvent(
      id: 1,
      intensity: 3,
      occurenceDate: DateTime.now(),
      numAdvilTaken: 2,
      notes: 'decent pain. Localized on left side',
    ),
  );
  data.add(
    HeadacheEvent(
      id: 2,
      intensity: 5,
      occurenceDate: DateTime.now(),
      numAdvilTaken: 4,
      notes: 'bad pain in center of head. took 3 advil, then 1 more hour later',
    ),
  );
  data.add(
    HeadacheEvent(
      id: 3,
      intensity: 1,
      occurenceDate: DateTime.now(),
      numAdvilTaken: 1,
      notes: 'minor pain.',
    ),
  );
  data.add(
    HeadacheEvent(
      id: 4,
      intensity: 4,
      occurenceDate: DateTime.now(),
      numAdvilTaken: 3,
      notes: 'bad pain. Localized on back right side',
    ),
  );
  return data;
}
