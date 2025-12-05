import 'package:flutter/material.dart';
import 'package:headache_tracker/models/headache_event.dart';
import 'package:headache_tracker/providers/headache_model.dart';
import 'package:headache_tracker/utils/date_formatter.dart';
import 'package:headache_tracker/widgets/detail_dialog.dart';
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

  ListTile _headacheItem(BuildContext context, HeadacheEvent item) {
    var title = DateFormatter.format(item.occurenceDate);
    var subTitle =
        'Intensity: ${item.intensity} | Advil: ${item.numAdvilTaken}';
    return ListTile(
      leading: Icon(Icons.menu),
      title: Text(title),
      subtitle: Text(subTitle),
      onTap: () {
        showDetailDialog(context: context);
      },
    );
  }
}
