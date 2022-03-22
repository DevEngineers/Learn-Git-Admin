import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final int? maxLine;
  final int? minLine;
  final Function onChange;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.onChange,
    this.maxLine,
    this.minLine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          // helperText: label,
          labelText: label,
        ),
        minLines: minLine,
        maxLines: maxLine,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please Enter " + label;
          }
          return null;
        },
        onSaved: (String? value) {
          onChange(value);
        });
  }
}
