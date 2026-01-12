import 'package:flutter/material.dart';
import 'package:headache_tracker/features/form_modal/headache_form.dart';
import 'package:headache_tracker/models/headache.dart';

class HeadacheModal extends StatelessWidget {
  final Headache? editingHeadache;

  const HeadacheModal({super.key, this.editingHeadache});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 55.0),
      title: Text(
        editingHeadache == null ? 'Add new' : 'Editing',
        textAlign: TextAlign.center,
      ),
      content: SafeArea(
        child: HeadacheForm(editingHeadacheForm: editingHeadache),
      ),
    );
  }
}

Future<void> showAddEditDialog({
  required BuildContext context,
  Headache? editingHeadache,
}) {
  return showGeneralDialog(
    context: context,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return HeadacheModal(editingHeadache: editingHeadache);
    },
  );
}
