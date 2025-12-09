import 'package:flutter/material.dart';
import 'package:headache_tracker/enums/timestamp_type.dart';
import 'package:headache_tracker/utils/string_extensions.dart';

class TimestampInput extends StatefulWidget {
  const TimestampInput({super.key});

  @override
  State<TimestampInput> createState() => _TimestampInputState();
}

class _TimestampInputState extends State<TimestampInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Enter timestamps:'),
        Row(
          spacing: 10,
          children: [_timestampTypeDropdown(), _timeSelectBtn(context)],
        ),
      ],
    );
  }

  ElevatedButton _timeSelectBtn(BuildContext context) {
    TimeOfDay? _selectedTime;
    return ElevatedButton(
      onPressed: () async => _selectedTime = await _selectTime(context),
      child: Text('Select Time'),
    );
  }

  DropdownButton<TimestampType> _timestampTypeDropdown() {
    var dropdownValue = TimestampType.advil;
    return DropdownButton(
      icon: Icon(Icons.alternate_email),
      value: dropdownValue,
      onChanged: (value) {
        setState(() {
          if (value != null) {
            dropdownValue = value;
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

  static Future<TimeOfDay?> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    return picked;
  }
}
