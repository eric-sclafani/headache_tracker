import 'package:flutter/material.dart';
import 'package:headache_tracker/providers/headache_model.dart';
import 'package:provider/provider.dart';

class DetailDialog extends StatelessWidget {
  const DetailDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HeadacheModel>(
      builder: (context, headacheModel, _) => AlertDialog(
        title: Text('Details', textAlign: TextAlign.center),
        content: Text('hello'),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}

Future<void> showDetailDialog({required BuildContext context}) {
  return showGeneralDialog(
    context: context,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return DetailDialog();
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
        child: child,
      );
    },
  );
}
