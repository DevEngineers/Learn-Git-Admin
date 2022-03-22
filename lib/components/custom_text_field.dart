import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {
  final String label;
  final int? maxLine, minLine;
  final Function onChange;

  const CustomTextFiled({
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
