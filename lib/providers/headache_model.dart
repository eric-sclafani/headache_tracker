import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:headache_tracker/models/headache.dart';

class HeadacheModel extends ChangeNotifier {
  final List<Headache> _headaches = [];

  UnmodifiableListView<Headache> get items => UnmodifiableListView(_headaches);

  int get totalHeadaches => _headaches.length;

  void add(Headache headache) {
    _headaches.add(headache);
    notifyListeners();
  }
}
