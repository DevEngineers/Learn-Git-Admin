import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {
  final String label;
  final Function onChange;

  const CustomTextFiled({
    Key? key,
    required this.label,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          helperText: label,
          labelText: label,
        ),
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
