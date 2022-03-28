import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/question_provider.dart';
import 'screens/home.dart';
import 'screens/add_quiz.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<QuestionProvider>(
            create: (context) => QuestionProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'CTSE Flutter Project',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: Home.routeName,
          routes: {
            Home.routeName: ((context) => const Home()),
            AddQuiz.routeName: ((context) => const AddQuiz())
          },
        ));
  }
}
