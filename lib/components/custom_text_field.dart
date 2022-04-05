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
          labelText: label,
          fillColor: Colors.white,
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
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
