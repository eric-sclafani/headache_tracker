import 'package:flutter/material.dart';
import 'package:headache_tracker/data/repositories/headache_repository.dart';
import 'package:headache_tracker/models/headache.dart';
import 'package:headache_tracker/features/detail_modal/detail_modal.dart';
import 'package:provider/provider.dart';

class HeadacheList extends StatefulWidget {
  const HeadacheList({super.key});

  @override
  State<HeadacheList> createState() => _HeadacheListState();
}

class _HeadacheListState extends State<HeadacheList> {
  @override
  void initState() {
    super.initState();
    context.read<HeadacheRepository>().loadHeadaches();
  }

  @override
  Widget build(BuildContext context) {
    var repo = context.watch<HeadacheRepository>();
    return Expanded(
      child: repo.headaches.isEmpty
          ? Center(
              child: const Text(
                'No entries added',
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 25),
              ),
            )
          : ListView.separated(
              itemCount: repo.headaches.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemBuilder: (context, index) {
                var item = repo.headaches[index];
                return _headacheItem(context, item);
              },
            ),
    );
  }

  Widget _headacheItem(BuildContext context, Headache item) {
    var title = item.occurenceDate;
    return ListTile(
      leading: Icon(Icons.event_note_rounded, size: 25),
      title: SizedBox(
        height: 18,
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      subtitle: Row(
        spacing: 10,
        children: [
          _displayColumn(
            Icons.electric_bolt,
            item.intensity.toString(),
            Colors.yellow.shade800,
          ),
          _displayColumn(
            Icons.medication_outlined,
            item.totalAdvils.toString(),
            Colors.lightGreen.shade800,
          ),
          _displayColumn(
            Icons.ac_unit,
            item.totalIcepacks.toString(),
            Colors.lightBlue.shade800,
          ),
        ],
      ),
      onTap: () {
        showDetailDialog(context: context, headache: item);
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
