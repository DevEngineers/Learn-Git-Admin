import 'dart:html';

import 'package:flutter/material.dart';
import 'package:learn_git_admin/components/button.dart';

import '../components/custom_text_field.dart';

class addQuiz extends StatefulWidget {
  static const String routeName = '/addQuiz';

  @override
  State<addQuiz> createState() => _addQuizState();
}

class _addQuizState extends State<addQuiz> {
  final _formKey = GlobalKey<FormState>();
  String? _question;
  String? _answer;
  String? dropdownValue;

  void onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }

  void setStateQ() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Quiz')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: CustomTextFiled(
                        label: "Question",
                        maxLine: 2,
                        minLine: 1,
                        onChange: (String? value) {},
                      )),
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: CustomTextFiled(
                          label: "Answers 01",
                          maxLine: 1,
                          minLine: 1,
                          onChange: (String? value) {})),
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: CustomTextFiled(
                          label: "Answers 02",
                          minLine: 1,
                          maxLine: 1,
                          onChange: (String? value) {})),
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: CustomTextFiled(
                          label: "Answers 03",
                          minLine: 1,
                          maxLine: 1,
                          onChange: (String? value) {})),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: DropdownButton<dynamic>(
                      value: dropdownValue,
                      items: const <DropdownMenuItem>[
                        DropdownMenuItem(
                          value: 'Option 1',
                          child: Text('Answers 01'),
                        ),
                        DropdownMenuItem(
                          value: 'Option 2',
                          child: Text('Answers 02'),
                        ),
                        DropdownMenuItem(
                          value: 'Option 3',
                          child: Text('Answers 03'),
                        ),
                        DropdownMenuItem(
                          value: 'Option 4',
                          child: Text('Answers 04'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          dropdownValue = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Button(
                        title: 'Submit',
                        onPress: onSubmit,
                        width: 250,
                      )),
                ],
              ))
        ],
      ),
    );
  }
}
