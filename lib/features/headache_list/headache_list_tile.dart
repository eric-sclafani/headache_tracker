import 'package:flutter/material.dart';
import 'package:headache_tracker/features/detail_modal/detail_modal.dart';
import 'package:headache_tracker/models/headache.dart';

class HeadacheListTile extends StatelessWidget {
  final Headache headache;
  const HeadacheListTile({super.key, required this.headache});

  @override
  Widget build(BuildContext context) {
    var title = headache.occurenceDate;
    return ListTile(
      leading: Icon(Icons.event_note_rounded, size: 25),
      title: SizedBox(
        height: 18,
        child: Text(title, style: TextStyle(fontSize: 16)),
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
