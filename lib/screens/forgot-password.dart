import 'package:flutter/material.dart';
import 'package:learn_git_admin/screens/login.dart';
import '../components/button.dart';
import '../components/custom_text.dart';
import '../components/custom_text_field.dart';

class ForgotPassword extends StatelessWidget {
  static const String routeName = '/ForgotPassword';
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text(
              'Forgot Password',
              // style: kBodyText,
            ),
          ),
          body: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: CustomText(
                        text:
                            'Enter your email we will send instruction to reset your password',
                        type: 'bodyText',
                        color: 'White',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomTextField(
                        label: 'Email',
                        onChange: () {},
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Button(
                        title: 'Send',
                        color: const Color(0xffE78230),
                        onPress: () => Navigator.of(context)
                            .pushNamed(LoginScreen.routeName),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
