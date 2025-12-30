import 'package:flutter/material.dart';
import 'package:headache_tracker/providers/headache_model.dart';
import 'package:headache_tracker/features/form_modal/headache_form.dart';
import 'package:provider/provider.dart';

class HeadacheModal extends StatelessWidget {
  final String mode;

  const HeadacheModal({super.key, required this.mode});

  @override
  Widget build(BuildContext context) {
    return Consumer<HeadacheModel>(
      builder: (context, headacheModel, _) => AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 55.0),
        title: Text(
          mode == 'add' ? 'Add new' : 'Editing',
          textAlign: TextAlign.center,
        ),
        content: SafeArea(child: HeadacheForm()),
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
      return HeadacheModal(mode: mode);
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
        child: child,
      );
    },
  );
}
