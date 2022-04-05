import 'dart:async';
import 'package:flutter/material.dart';
import 'package:learn_git_admin/screens/home.dart';
import 'package:provider/provider.dart';
import '../providers/content_provider.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushNamed(
              Home.routeName,
            ));
  }

  void initializeProviders() {
    // Add providers here to initialize them.
    Provider.of<ContentProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    initializeProviders();
    return Scaffold(
        body: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              './lib/assets/images/git.png',
              width: 180,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text('Learn Git',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold)),
            )
          ]),
    ));
  }
}
