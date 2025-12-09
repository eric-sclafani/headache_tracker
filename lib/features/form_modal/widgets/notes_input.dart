import 'package:flutter/material.dart';
import 'package:headache_tracker/models/headache.dart';

class NotesInput extends StatelessWidget {
  final Headache headacheForm;
  const NotesInput({super.key, required this.headacheForm});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: "Notes"),
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      onSaved: (value) => headacheForm.notes = value,
    );
  }
}
