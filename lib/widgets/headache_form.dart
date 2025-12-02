import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:headache_tracker/providers/headache_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HeadacheForm extends StatefulWidget {
  const HeadacheForm({super.key});

  @override
  State<HeadacheForm> createState() => _HeadacheFormState();
}

class _HeadacheFormState extends State<HeadacheForm> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HeadacheModel>(
      builder: (context, headache, _) => Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: Colors.blue, width: 0.8),
              right: BorderSide(color: Colors.blue, width: 0.8),
            ),
            borderRadius: BorderRadius.circular(14.0),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            spacing: 20,
            children: [
              _occurenceDateInput(context),
              _intensityInput(),
              _numAdvilInput(),
              _notesInput(),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _intensityInput() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Intensity (1-5)"),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter a digit 1 to 5';
        }
        return null;
      },
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }

  // TODO: eventually break advil out into own object, add amount and time taken
  TextFormField _numAdvilInput() {
    return TextFormField(
      decoration: InputDecoration(labelText: "# Advil Taken"),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter digit';
        }
        return null;
      },
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }

  TextFormField _notesInput() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Notes"),
      maxLines: 3,
      keyboardType: TextInputType.multiline,
    );
  }

  Row _occurenceDateInput(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        IconButton(
          iconSize: 30,
          icon: const Icon(Icons.calendar_month_outlined),
          onPressed: () async {
            var date = await _selectDate(context);
            if (date != null) {
              var formatter = DateFormat('MM-dd-yyyy');
              _dateController.text = formatter.format(date);
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
