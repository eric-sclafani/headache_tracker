import 'package:flutter/material.dart';
import 'package:headache_tracker/models/headache.dart';
import 'package:headache_tracker/utils/string_extensions.dart';

class DetailDialog extends StatelessWidget {
  final Headache inputHeadache;

  const DetailDialog({super.key, required this.inputHeadache});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Details', textAlign: TextAlign.center),
      content: _dialogContent(),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Close'),
        ),
      ],
    );
  }

  Column _dialogContent() {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Date: ${inputHeadache.formattedDate}'),
        Text('Intensity: ${inputHeadache.intensity}'),
        Text('Notes: ${inputHeadache.notes}'),
        Text('Total advils: ${inputHeadache.totalAdvils}'),
        Text('Total icepacks: ${inputHeadache.totalIcepacks}'),
        _timestampsDisplay(),
      ],
    );
  }

  Widget _timestampsDisplay() {
    var items = inputHeadache.timestamps;
    return SizedBox(
      width: 300,
      height: 500,
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              '${items[index].type.name.toCapitalized()} @ ${items[index].formattedTime}',
            ),
            subtitle: Text('This is a subtitle'),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: items.length,
      ),
    );
  }
}

Future<void> showDetailDialog({
  required BuildContext context,
  required Headache headache,
}) {
  return showGeneralDialog(
    context: context,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return DetailDialog(inputHeadache: headache);
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
        child: child,
      );
    },
  );
}
