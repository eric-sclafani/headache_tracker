import 'package:flutter/material.dart';
import 'package:headache_tracker/models/headache.dart';
import 'package:headache_tracker/utils/datetime_formatter.dart';

class OccurenceDateInput extends StatefulWidget {
  final Headache headacheForm;
  final BuildContext context;

  const OccurenceDateInput({
    super.key,
    required this.headacheForm,
    required this.context,
  });

  @override
  State<OccurenceDateInput> createState() => _OccurenceDateInputState();
}

class _OccurenceDateInputState extends State<OccurenceDateInput> {
  final _dateController = TextEditingController();

  @override
  void initState() {
    if (widget.headacheForm.id != null) {
      _dateController.text = widget.headacheForm.occurenceDate;
    } else {
      _dateController.text = DateTimeFormatter.formatDate(DateTime.now());
    }
    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        IconButton(
          iconSize: 30,
          icon: const Icon(Icons.calendar_month_outlined),
          onPressed: () async {
            var date = await _selectDate(context);
            if (date != null) {
              var formattedDate = DateTimeFormatter.formatDate(date);
              _dateController.text = formattedDate;
              widget.headacheForm.occurenceDate = formattedDate;
            }
          },
        ),
        Expanded(
          child: TextFormField(
            enabled: false,
            controller: _dateController,
            decoration: InputDecoration(labelText: 'Date'),
          ),
        ),
      ],
    );
  }
}

Future<DateTime?> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime.now(),
  );

  return picked;
}
