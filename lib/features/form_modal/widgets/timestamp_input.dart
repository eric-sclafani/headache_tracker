import 'package:flutter/material.dart';
import 'package:headache_tracker/enums/timestamp_type.dart';
import 'package:headache_tracker/models/timestamp.dart';
import 'package:headache_tracker/utils/string_extensions.dart';

typedef TimestampsCallback = void Function(List<Timestamp> timestamps);

class TimestampInput extends StatefulWidget {
  final TimestampsCallback callback;

  const TimestampInput({super.key, required this.callback});

  @override
  State<TimestampInput> createState() => _TimestampInputState();
}

class _TimestampInputState extends State<TimestampInput> {
  final List<Timestamp> _timestamps = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _newTimestampBtn(),
        SizedBox(
          width: 250,
          height: 250,
          child: ListView.builder(
            padding: const EdgeInsets.all(5),
            itemCount: _timestamps.length,
            itemBuilder: (BuildContext context, int index) {
              Timestamp? timestamp = _timestamps[index];
              return Row(
                spacing: 5,
                children: [
                  _timestampTypeDropdown(timestamp),
                  Icon(Icons.alternate_email),
                  _timeSelectBtn(context, timestamp),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  ElevatedButton _newTimestampBtn() {
    return ElevatedButton.icon(
      onPressed: () {
        var newTimestamp = Timestamp(
          id: 0,
          time: TimeOfDay.now(),
          type: TimestampType.advil,
        );
        setState(() {
          _timestamps.add(newTimestamp);
        });
      },
      label: Text('New Timestamp'),
      icon: Icon(Icons.add),
    );
  }

  DropdownButton<TimestampType> _timestampTypeDropdown(Timestamp timestamp) {
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
      items: TimestampType.values.where((t) => t.name != '_').map((
        TimestampType t,
      ) {
        return DropdownMenuItem<TimestampType>(
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
          setState(() {
            timestamp.time = t;
            widget.callback(_timestamps);
          });
        }
      },
      child: Text(timestamp.formattedTime),
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
