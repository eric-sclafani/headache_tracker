import 'package:flutter/material.dart';
import 'package:headache_tracker/features/detail_modal/detail_modal.dart';

class NotesDisplay extends StatefulWidget {
  const NotesDisplay({super.key, required this.widget});

  final DetailDialog widget;

  @override
  State<NotesDisplay> createState() => _NotesDisplayState();
}

class _NotesDisplayState extends State<NotesDisplay> {
  final ScrollController _notesScrollController = ScrollController();

  @override
  void dispose() {
    _notesScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                widget.widget.inputHeadache.notes != null &&
                    widget.widget.inputHeadache.notes!.isNotEmpty
                ? Text(widget.widget.inputHeadache.notes!)
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
