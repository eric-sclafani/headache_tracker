import 'package:flutter/material.dart';
import 'package:headache_tracker/data/repositories/headache_repository.dart';
import 'package:provider/provider.dart';

class ConfirmDeleteModal extends StatelessWidget {
  final int headacheId;

  const ConfirmDeleteModal({super.key, required this.headacheId});

  @override
  Widget build(BuildContext context) {
    var repo = context.read<HeadacheRepository>();
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 55.0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Icon(Icons.delete_forever_outlined, color: Colors.red.shade800),
          Text('Are ya sure??'),
          Icon(Icons.delete_forever_outlined, color: Colors.red.shade800),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Nah nevermind'),
        ),
        ElevatedButton(
          onPressed: () {
            repo.deleteHeadache(headacheId);
            Navigator.pop(context, true);
          },
          child: Text('DO IT'),
        ),
      ],
    );
  }
}

Future<bool?> showConfirmDeleteDialog({
  required BuildContext context,
  required int headacheId,
}) {
  return showGeneralDialog<bool?>(
    context: context,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return ConfirmDeleteModal(headacheId: headacheId);
    },
  );
}
