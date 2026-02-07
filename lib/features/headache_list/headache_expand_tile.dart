import 'package:flutter/material.dart';
import 'package:headache_tracker/features/detail_modal/detail_modal.dart';
import 'package:headache_tracker/models/headache.dart';

class HeadacheExpandTile extends StatelessWidget {
  final MapEntry<String, List<Headache>> headacheMap;
  const HeadacheExpandTile({super.key, required this.headacheMap});

  @override
  Widget build(BuildContext context) {
    var title = headacheMap.key;
    return ExpansionTile(
      initiallyExpanded: true,
      tilePadding: EdgeInsets.all(0),
      shape: const Border(),
      leading: Icon(Icons.event_note_rounded, size: 25),
      title: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      children: _generateTileEntries(context),
    );
  }

  List<ListTile> _generateTileEntries(BuildContext context) {
    var headaches = headacheMap.value;
    headaches.sort((a, b) => b.occurenceDate.compareTo(a.occurenceDate));
    List<ListTile> tiles = [];
    for (var h in headaches) {
      var tile = _createHeadacheListTile(h, context);
      tiles.add(tile);
    }
    return tiles;
  }

  ListTile _createHeadacheListTile(Headache headache, BuildContext context) {
    return ListTile(
      title: SizedBox(
        height: 18,
        child: Text(headache.occurenceDate, style: TextStyle(fontSize: 16)),
      ),
      subtitle: Row(
        spacing: 10,
        children: [
          _displayColumn(
            Icons.electric_bolt,
            headache.intensity.toString(),
            Colors.yellow.shade800,
          ),
          _displayColumn(
            Icons.medication_outlined,
            headache.totalAdvils.toString(),
            Colors.lightGreen.shade800,
          ),
          _displayColumn(
            Icons.ac_unit,
            headache.totalIcepacks.toString(),
            Colors.lightBlue.shade800,
          ),
        ],
      ),
      onTap: () {
        showDetailDialog(context: context, headache: headache);
      },
    );
  }

  static Column _displayColumn(IconData icon, String text, Color color) {
    return Column(
      children: [
        Row(
          spacing: 5,
          children: [
            Icon(icon, size: 20, color: color),
            Text(text),
          ],
        ),
      ],
    );
  }
}
