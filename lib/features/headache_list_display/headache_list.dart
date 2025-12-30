import 'package:flutter/material.dart';
import 'package:headache_tracker/models/headache.dart';
import 'package:headache_tracker/providers/headache_model.dart';
import 'package:headache_tracker/utils/datetime_formatter.dart';
import 'package:headache_tracker/features/detail_modal/detail_modal.dart';
import 'package:provider/provider.dart';

class HeadacheList extends StatelessWidget {
  const HeadacheList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HeadacheModel>(
      builder: (context, headacheModel, _) => Expanded(
        child: headacheModel.allHeadaches.isEmpty
            ? Center(
                child: const Text(
                  'No entries added',
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 25),
                ),
              )
            : ListView.separated(
                itemCount: headacheModel.allHeadaches.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemBuilder: (context, index) {
                  var item = headacheModel.allHeadaches[index];
                  return _headacheItem(context, item);
                },
              ),
      ),
    );
  }

  ListTile _headacheItem(BuildContext context, Headache item) {
    var title = DateTimeFormatter.formatDate(item.occurenceDate);
    return ListTile(
      leading: Icon(Icons.menu, size: 25),
      title: Text(title),
      subtitle: Row(
        spacing: 10,
        children: [
          _displayColumn(Icons.electric_bolt, item.intensity.toString()),
          _displayColumn(
            Icons.medication_outlined,
            item.totalAdvils.toString(),
          ),
          _displayColumn(Icons.ac_unit, item.totalIcepacks.toString()),
        ],
      ),
      onTap: () {
        showDetailDialog(context: context, headache: item);
      },
    );
  }
}

Column _displayColumn(IconData icon, String text) {
  return Column(
    children: [
      Row(spacing: 5, children: [Icon(icon, size: 20), Text(text)]),
    ],
  );
}
