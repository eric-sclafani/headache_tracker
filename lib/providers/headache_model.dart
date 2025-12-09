import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:headache_tracker/enums/timestamp_type.dart';
import 'package:headache_tracker/models/headache.dart';
import 'package:headache_tracker/models/timestamp.dart';

class HeadacheModel extends ChangeNotifier {
  final List<Headache> _headaches = _initSeedData();

  UnmodifiableListView<Headache> get allHeadaches {
    _headaches.sort((a, b) => b.occurenceDate.compareTo(a.occurenceDate));
    return UnmodifiableListView(_headaches);
  }

  int get totalHeadaches => _headaches.length;

  void add(Headache headache) {
    headache.id = _getLatestId();
    _headaches.add(headache);
    notifyListeners();
  }

  int _getLatestId() {
    var h = maxBy(_headaches, (h) => h.id);
    return h != null ? h.id + 1 : 1;
  }
}

List<Headache> _initSeedData() {
  List<Headache> data = [];

  var h1 = Headache(
    id: 1,
    intensity: 3,
    occurenceDate: DateTime.now(),
    notes: 'decent pain. Localized on left side',
  );
  h1.timestamps.add(
    Timestamp(
      id: 1,
      time: TimeOfDay(hour: 15, minute: 32),
      type: TimestampType.advil,
    ),
  );
  h1.timestamps.add(
    Timestamp(
      id: 2,
      time: TimeOfDay(hour: 9, minute: 01),
      type: TimestampType.advil,
    ),
  );
  h1.timestamps.add(
    Timestamp(
      id: 3,
      time: TimeOfDay(hour: 16, minute: 42),
      type: TimestampType.icePack,
    ),
  );

  var h2 = Headache(
    id: 2,
    intensity: 5,
    occurenceDate: DateTime.now(),
    notes: 'bad pain in center of head. took 3 advil, then 1 more hour later',
  );
  h2.timestamps.add(
    Timestamp(
      id: 1,
      time: TimeOfDay(hour: 3, minute: 59),
      type: TimestampType.icePack,
    ),
  );
  h2.timestamps.add(
    Timestamp(
      id: 2,
      time: TimeOfDay(hour: 22, minute: 26),
      type: TimestampType.advil,
    ),
  );
  data.add(h1);
  data.add(h2);
  return data;
}
