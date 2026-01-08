import 'package:flutter/material.dart';
import 'package:headache_tracker/data/repositories/timestamp_repository.dart';
import 'package:headache_tracker/features/detail_modal/widgets/subheader.dart';
import 'package:headache_tracker/features/detail_modal/widgets/timestamp_display.dart';
import 'package:headache_tracker/models/headache.dart';
import 'package:provider/provider.dart';

class DetailDialog extends StatefulWidget {
  final Headache inputHeadache;

  const DetailDialog({super.key, required this.inputHeadache});

  @override
  State<DetailDialog> createState() => _DetailDialogState();
}

class _DetailDialogState extends State<DetailDialog> {
  final ScrollController _notesScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<TimestampRepository>().loadTimestamps(widget.inputHeadache.id);
  }

  @override
  void dispose() {
    _notesScrollController.dispose();
    super.dispose();
  }

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
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Close'),
        ),
      ],
    );
  }

  Widget _modalContent() {
    final repo = context.watch<TimestampRepository>();
    return Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SubHeader(inputHeadache: widget.inputHeadache),
        _notesDisplay(),
        TimestampDisplay(timestamps: repo.timestamps),
      ],
    );
  }

  Widget _notesDisplay() {
    return Flexible(
      child: Scrollbar(
        thumbVisibility: true,
        controller: _notesScrollController,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.black.withAlpha(50)),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            controller: _notesScrollController,
            scrollDirection: Axis.vertical,
            child:
                widget.inputHeadache.notes != null &&
                    widget.inputHeadache.notes!.isNotEmpty
                ? Text(widget.inputHeadache.notes!)
                : Text(
                    'No notes added',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
          ),
        ),
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
