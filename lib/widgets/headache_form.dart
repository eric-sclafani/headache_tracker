import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:headache_tracker/models/headache.dart';
import 'package:headache_tracker/providers/headache_model.dart';
import 'package:headache_tracker/utils/datetime_formatter.dart';
import 'package:provider/provider.dart';

class HeadacheForm extends StatefulWidget {
  const HeadacheForm({super.key});

  @override
  State<HeadacheForm> createState() => _HeadacheFormState();
}

class _HeadacheFormState extends State<HeadacheForm> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();

  final Headache _headacheForm = Headache(
    id: 0,
    intensity: 0,
    occurenceDate: DateTime.now(),
  );

  @override
  void initState() {
    _dateController.text = DateTimeFormatter.formatDate(DateTime.now());
    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HeadacheModel>(
      builder: (context, headacheModel, _) => Form(
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
              _notesInput(),
              _dialogButtons(context, headacheModel),
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
      onSaved: (value) {
        if (value != null && value.isNotEmpty) {
          var valueInt = int.parse(value);
          _headacheForm.intensity = valueInt;
        }
      },
      validator: (value) {
        const msg = 'Enter a digit 1 to 5';
        if (value != null && value.isNotEmpty) {
          var valueInt = int.parse(value);
          if (valueInt < 1 || valueInt > 5) {
            return msg;
          }
        } else if (value == null || value.isEmpty) {
          return msg;
        }

        return null;
      },
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }

  // TextFormField _numAdvilInput() {
  //   return TextFormField(
  //     decoration: InputDecoration(labelText: "# Advil Taken"),
  //     keyboardType: TextInputType.number,
  //     onSaved: (value) {
  //       if (value != null && value.isNotEmpty) {
  //         var valueInt = int.parse(value);
  //         _headacheForm.numAdvilTaken = valueInt;
  //       }
  //     },
  //     validator: (value) {
  //       if (value == null || value.isEmpty) {
  //         return 'Enter digit';
  //       }
  //       return null;
  //     },
  //     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
  //   );
  // }

  TextFormField _notesInput() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Notes"),
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      onSaved: (value) => _headacheForm.notes = value,
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
              _dateController.text = DateTimeFormatter.formatDate(date);
              _headacheForm.occurenceDate = date;
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

  Row _dialogButtons(BuildContext context, HeadacheModel headacheModel) {
    return Row(
      spacing: 30,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Close'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              headacheModel.add(_headacheForm);
              Navigator.pop(context);
            }
          },
          child: Text('Save'),
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
