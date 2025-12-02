import 'package:flutter/material.dart';
import 'package:headache_tracker/providers/headache_model.dart';
import 'package:headache_tracker/widgets/headache_form.dart';
import 'package:provider/provider.dart';

class FormDialog extends StatelessWidget {
  final String mode;

  const FormDialog({super.key, required this.mode});

  @override
  Widget build(BuildContext context) {
    return Consumer<HeadacheModel>(
      builder: (context, headache, _) => AlertDialog(
        title: Text(
          mode == 'add' ? 'Add new' : 'Editing',
          textAlign: TextAlign.center,
        ),
        content: HeadacheForm(),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

Future<void> showAddEditDialog({
  required BuildContext context,
  required String mode,
}) {
  return showGeneralDialog(
    context: context,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return FormDialog(mode: mode); // FormDialog can be an AlertDialog
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
        child: child,
      );
    },
  );
}
