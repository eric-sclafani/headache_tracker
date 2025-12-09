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
        child: ListView.separated(
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
    var subTitle =
        'Intensity: ${item.intensity} | Timestamps: ${item.timestamps.length}';
    return ListTile(
      leading: Icon(Icons.menu),
      title: Text(title),
      subtitle: Text(subTitle),
      onTap: () {
        showDetailDialog(context: context, headache: item);
      },
    );
  }
}
