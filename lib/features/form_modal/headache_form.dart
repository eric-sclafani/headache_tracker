import 'package:flutter/material.dart';
import 'package:headache_tracker/data/repositories/headache_repository.dart';
import 'package:headache_tracker/features/detail_modal/detail_modal.dart';
import 'package:headache_tracker/features/form_modal/widgets/intensity_input.dart';
import 'package:headache_tracker/features/form_modal/widgets/notes_input.dart';
import 'package:headache_tracker/features/form_modal/widgets/occurence_date_input.dart';
import 'package:headache_tracker/features/form_modal/widgets/timestamp_input.dart';
import 'package:headache_tracker/models/headache.dart';
import 'package:headache_tracker/utils/datetime_formatter.dart';
import 'package:provider/provider.dart';

class HeadacheForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final Headache? editingHeadacheForm;

  HeadacheForm({super.key, this.editingHeadacheForm});

  final Headache newHeadacheForm = Headache(
    intensity: 0,
    occurenceDate: DateTimeFormatter.formatDate(DateTime.now()),
  );

  @override
  Widget build(BuildContext context) {
    var repo = context.read<HeadacheRepository>();
    final Headache headacheForm = editingHeadacheForm ?? newHeadacheForm;

    return Form(
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
                    headacheForm: headacheForm,
                    context: context,
                  ),
                  IntensityInput(headacheForm: headacheForm),
                  NotesInput(headacheForm: headacheForm),
                  TimestampInput(
                    editingHeadache: headacheForm,
                    callback: (timestamps) =>
                        headacheForm.timestamps = timestamps,
                  ),
                ],
              ),
            ),
            _dialogButtons(context, repo, headacheForm),
          ],
        ),
      ),
    );
  }

  Row _dialogButtons(
    BuildContext context,
    HeadacheRepository repo,
    Headache headacheForm,
  ) {
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
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              if (headacheForm.id == null) {
                repo.addHeadache(headacheForm);
                Navigator.pop(context);
              } else {
                repo.updateHeadache(headacheForm);
                Navigator.pop(context);
                showDetailDialog(context: context, headache: headacheForm);
              }
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
