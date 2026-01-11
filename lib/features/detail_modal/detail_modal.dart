import 'package:flutter/material.dart';
import 'package:headache_tracker/features/confirm_delete_modal/confirm_modal.dart';
import 'package:headache_tracker/features/detail_modal/widgets/notes_display.dart';
import 'package:headache_tracker/features/detail_modal/widgets/subheader.dart';
import 'package:headache_tracker/features/detail_modal/widgets/timestamp_display.dart';
import 'package:headache_tracker/features/form_modal/headache_modal.dart';
import 'package:headache_tracker/models/headache.dart';

class DetailDialog extends StatefulWidget {
  final Headache inputHeadache;

  const DetailDialog({super.key, required this.inputHeadache});

  @override
  State<DetailDialog> createState() => _DetailDialogState();
}

class _DetailDialogState extends State<DetailDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 55.0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          const Icon(Icons.date_range_rounded),
          Text(widget.inputHeadache.occurenceDate),
        ],
      ),
      content: SafeArea(top: false, child: _modalContent()),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        _deleteBtn(widget.inputHeadache),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Close'),
        ),
        _editBtn(widget.inputHeadache),
      ],
    );
  }

  Widget _modalContent() {
    return Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SubHeader(inputHeadache: widget.inputHeadache),
        NotesDisplay(widget: widget),
        TimestampDisplay(timestamps: widget.inputHeadache.timestamps),
      ],
    );
  }

  Widget _editBtn(Headache item) {
    return ElevatedButton(
      onPressed: () async {
        if (mounted) {
          Navigator.pop(context);
        }
        await showAddEditDialog(
          context: context,
          editingHeadache: widget.inputHeadache,
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange.shade600,
        foregroundColor: Colors.white,
      ),

      child: Text('Edit'),
    );
  }

  Widget _deleteBtn(Headache item) {
    return ElevatedButton(
      onPressed: () async {
        final bool? deleted = await showConfirmDeleteDialog(
          context: context,
          headacheId: item.id!,
        );
        if (deleted == true && mounted) {
          Navigator.pop(context);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red.shade500,
        foregroundColor: Colors.white,
      ),

      child: Text('Delete'),
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
  );
}
