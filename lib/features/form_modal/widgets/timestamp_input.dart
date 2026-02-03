import 'package:flutter/material.dart';
import 'package:headache_tracker/enums/timestamp_type_enum.dart';
import 'package:headache_tracker/models/headache.dart';
import 'package:headache_tracker/models/timestamp.dart';
import 'package:headache_tracker/utils/datetime_formatter.dart';
import 'package:headache_tracker/utils/string_extensions.dart';

typedef TimestampsCallback = void Function(List<Timestamp> timestamps);

class TimestampInput extends StatefulWidget {
  final TimestampsCallback callback;
  final Headache? editingHeadache;

  const TimestampInput({
    super.key,
    this.editingHeadache,
    required this.callback,
  });

  @override
  State<TimestampInput> createState() => _TimestampInputState();
}

class _TimestampInputState extends State<TimestampInput> {
  List<Timestamp> _timestamps = [];

  @override
  Widget build(BuildContext context) {
    if (widget.editingHeadache != null) {
      _timestamps = widget.editingHeadache!.timestamps;
    }

    return Column(
      children: [
        _newTimestampBtn(),
        SizedBox(
          width: 250,
          height: 150,
          child: ListView.builder(
            padding: const EdgeInsets.all(5),
            itemCount: _timestamps.length,
            itemBuilder: (BuildContext context, int index) {
              Timestamp? timestamp = _timestamps[index];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _timestampTypeDropdown(timestamp),
                  _timeSelectBtn(context, timestamp),
                  _deleteTimestampBtn(timestamp),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  IconButton _deleteTimestampBtn(Timestamp timestamp) {
    return IconButton(
      onPressed: () {
        setState(() {
          _timestamps.remove(timestamp);
          widget.callback(_timestamps);
        });
      },
      icon: Icon(Icons.delete_forever_rounded),
      style: IconButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.red.shade600,
        iconSize: 30,
      ),
    );
  }

  ElevatedButton _newTimestampBtn() {
    return ElevatedButton.icon(
      onPressed: () {
        var newTimestamp = Timestamp(
          time: DateTimeFormatter.formatTime(DateTime.now()),
          type: TimestampTypeEnum.advil,
          headacheId: 0,
        );
        setState(() {
          _timestamps.add(newTimestamp);
          widget.callback(_timestamps);
        });
      },
      label: Text('New Timestamp'),
      icon: Icon(Icons.add),
    );
  }

  DropdownButton<TimestampTypeEnum> _timestampTypeDropdown(
    Timestamp timestamp,
  ) {
    return DropdownButton(
      value: timestamp.type,
      onChanged: (value) {
        setState(() {
          if (value != null) {
            timestamp.type = value;
            widget.callback(_timestamps);
          }
        });
      },
      items: TimestampTypeEnum.values.where((t) => t.name != '_').map((
        TimestampTypeEnum t,
      ) {
        return DropdownMenuItem<TimestampTypeEnum>(
          value: t,
          child: Text(t.name.toCapitalized()),
        );
      }).toList(),
    );
  }

  ElevatedButton _timeSelectBtn(BuildContext context, Timestamp timestamp) {
    return ElevatedButton(
      onPressed: () async {
        var t = await _selectTime(context);
        if (t != null) {
          var newTime = DateTime(2000, 1, 1, t.hour, t.minute);
          setState(() {
            timestamp.time = DateTimeFormatter.formatTime(newTime);
            widget.callback(_timestamps);
          });
        }
      },
      child: Text(timestamp.time),
    );
  }

  static Future<TimeOfDay?> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    return picked;
  }
}
