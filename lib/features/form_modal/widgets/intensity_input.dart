import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:headache_tracker/models/headache.dart';

class IntensityInput extends StatelessWidget {
  final Headache headacheForm;

  const IntensityInput({super.key, required this.headacheForm});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: "Intensity (1-5)"),
      keyboardType: TextInputType.number,
      initialValue: headacheForm.id == null
          ? null
          : headacheForm.intensity.toString(),
      onSaved: (value) {
        if (value != null && value.isNotEmpty) {
          var valueInt = int.parse(value);
          headacheForm.intensity = valueInt;
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
}
