import 'package:flutter/material.dart';
import 'package:headache_tracker/enums/timestamp_type_enum.dart';
import 'package:headache_tracker/models/timestamp.dart';
import 'package:headache_tracker/utils/string_extensions.dart';

class TimestampDisplay extends StatefulWidget {
  final List<Timestamp> timestamps;

  const TimestampDisplay({super.key, required this.timestamps});

  @override
  State<TimestampDisplay> createState() => _TimestampDisplayState();
}

class _TimestampDisplayState extends State<TimestampDisplay> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 250,
      child: Scrollbar(
        thumbVisibility: true,
        controller: _scrollController,
        child: ListView.separated(
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            var item = widget.timestamps[index];
            return ListTile(
              title: Row(
                spacing: 5,
                children: [
                  Icon(
                    item.type == TimestampTypeEnum.advil
                        ? Icons.medication_outlined
                        : Icons.ac_unit,
                  ),
                  Text('${item.type.name.toCapitalized()} @ ${item.time}'),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: widget.timestamps.length,
        ),
      ),
    );
  }
}
