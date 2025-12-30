import 'package:flutter/material.dart';
import 'package:headache_tracker/features/form_modal/widgets/intensity_input.dart';
import 'package:headache_tracker/features/form_modal/widgets/notes_input.dart';
import 'package:headache_tracker/features/form_modal/widgets/occurence_date_input.dart';
import 'package:headache_tracker/features/form_modal/widgets/timestamp_input.dart';
import 'package:headache_tracker/models/headache.dart';
import 'package:headache_tracker/providers/headache_model.dart';
import 'package:provider/provider.dart';

class HeadacheForm extends StatefulWidget {
  const HeadacheForm({super.key});

  @override
  State<HeadacheForm> createState() => _HeadacheFormState();
}

class _HeadacheFormState extends State<HeadacheForm> {
  final _formKey = GlobalKey<FormState>();

  final Headache _headacheForm = Headache(
    id: 0,
    intensity: 0,
    occurenceDate: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<HeadacheModel>(
      builder: (context, headacheModel, _) => Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            spacing: 7,
            children: [
              Container(
                padding: EdgeInsets.only(left: 14, right: 14),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Colors.blue, width: 0.8),
                    right: BorderSide(color: Colors.blue, width: 0.8),
                  ),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Column(
                  spacing: 10,
                  children: [
                    OccurenceDateInput(
                      headacheForm: _headacheForm,
                      context: context,
                    ),
                    IntensityInput(headacheForm: _headacheForm),
                    NotesInput(headacheForm: _headacheForm),
                    TimestampInput(
                      callback: (timestamps) =>
                          _headacheForm.timestamps = timestamps,
                    ),
                  ],
                ),
              ),
              _dialogButtons(context, headacheModel),
            ],
          ),
        ),
      ),
    );
  }

  Row _dialogButtons(BuildContext context, HeadacheModel headacheModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
