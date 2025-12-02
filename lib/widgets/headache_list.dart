import 'package:flutter/material.dart';
import 'package:headache_tracker/models/headache.dart';

class HeadacheList extends StatelessWidget {
  const HeadacheList({super.key});

  @override
  Widget build(BuildContext context) {
    var items = _initSeedData();
    return Expanded(
      child: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(title: Text(items[index].toString()));
        },
      ),
    );
  }

  List<Headache> _initSeedData() {
    List<Headache> data = [];
    data.add(
      Headache(
        id: 1,
        intensity: 3,
        occurenceDate: DateTime.now(),
        numAdvilTaken: 2,
        notes: 'decent pain. Localized on left side',
      ),
    );
    data.add(
      Headache(
        id: 2,
        intensity: 5,
        occurenceDate: DateTime.now(),
        numAdvilTaken: 4,
        notes:
            'bad pain in center of head. took 3 advil, then 1 more hour later',
      ),
    );
    data.add(
      Headache(
        id: 3,
        intensity: 1,
        occurenceDate: DateTime.now(),
        numAdvilTaken: 1,
        notes: 'minor pain.',
      ),
    );
    data.add(
      Headache(
        id: 4,
        intensity: 4,
        occurenceDate: DateTime.now(),
        numAdvilTaken: 3,
        notes: 'bad pain. Localized on back right side',
      ),
    );
    return data;
  }
}
