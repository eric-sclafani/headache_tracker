import 'package:flutter/foundation.dart';
import 'package:headache_tracker/data/dao/headache_dao.dart';
import 'package:headache_tracker/data/dao/timestamp_dao.dart';
import 'package:headache_tracker/enums/timestamp_type_enum.dart';
import 'package:headache_tracker/models/headache.dart';
import 'package:headache_tracker/models/timestamp.dart';
import 'package:headache_tracker/utils/datetime_formatter.dart';
import 'dart:convert';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';

class HeadacheRepository extends ChangeNotifier {
  final HeadacheDao _headacheDao;
  final TimestampDao _timestampDao;

  List<Headache> _headacheList = [];
  Map<String, List<Headache>> _headacheMap = {};

  HeadacheRepository(this._headacheDao, this._timestampDao);

  List<MapEntry<String, List<Headache>>> get headacheMapList {
    var entries = _headacheMap.entries.toList();
    entries.sort((a, b) {
      var d1 = DateTimeFormatter.parseMonthYear(a.key);
      var d2 = DateTimeFormatter.parseMonthYear(b.key);
      return d2.compareTo(d1);
    });
    return entries;
  }

  int get numMonthsRecorded => _headacheMap.keys.length;
  int get totalHeadaches => _headacheList.length;
  int get totalAdvils => _getTotalTimestampType(TimestampTypeEnum.advil);

  Future<void> loadHeadaches() async {
    _headacheList = await _headacheDao.getAll();
    for (var h in _headacheList) {
      h.timestamps = await _timestampDao.getAllByHeadacheId(h.id!);
    }
    _populateHeadacheMap();
    notifyListeners();
  }

  void _populateHeadacheMap() {
    Map<String, List<Headache>> headacheMap = {};
    for (var h in _headacheList) {
      var monthYearStr = DateTimeFormatter.formatMonthYear(h.occurenceDate);
      if (!headacheMap.containsKey(monthYearStr)) {
        headacheMap[monthYearStr] = [];
      }
      headacheMap[monthYearStr]?.add(h);
    }
    _headacheMap = headacheMap;
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

  int getAvgHeadachesPerMonth() {
    var calc = (totalHeadaches / numMonthsRecorded);
    return calc > 0 ? calc.round() : 0;
  }

  int getAvgAdvilPerMonth() {
    var calc = (totalAdvils / numMonthsRecorded);
    return calc > 0 ? calc.round() : 0;
  }

  int getAvgAdvilPerHeadache() {
    var calc = (totalAdvils / totalHeadaches);
    return calc > 0 ? calc.round() : 0;
  }

  dynamic downloadJson() async {
    var data = _convertAllDataToJSON();
    var fileName = 'htracker_data_${DateTime.now().toString()}.json';
    var json = jsonEncode(data);

    final Uint8List bytes = Uint8List.fromList(json.codeUnits);

    await FlutterFileDialog.saveFile(
      params: SaveFileDialogParams(
        data: bytes,
        fileName: fileName,
        mimeTypesFilter: ['application/json'],
      ),
    );
  }

  Map<String, List<dynamic>> _convertAllDataToJSON() {
    Map<String, List<dynamic>> data = {'allHeadaches': [], 'allTimestamps': []};
    for (var h in _headacheList) {
      data['allHeadaches']?.add(h.toMap());
      for (var t in h.timestamps) {
        data['allTimestamps']?.add(t.toMap());
      }
    }

    return data;
  }

  int _getTotalTimestampType(TimestampTypeEnum type) {
    List<Timestamp> allTypes = [];
    _headacheList.forEach(
      ((h) => {
        for (var t in h.timestamps)
          {
            if (t.type == type) {allTypes.add(t)},
          },
      }),
    );
    return allTypes.length;
  }
}
