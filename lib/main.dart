import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:learn_git_admin/providers/content_provider.dart';
import 'package:learn_git_admin/screens/content.dart';
import 'package:learn_git_admin/screens/content_add_edit.dart';
import 'package:learn_git_admin/screens/content_list.dart';
import 'package:learn_git_admin/screens/content_view.dart';
import 'package:learn_git_admin/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'screens/home.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          // Add providers here.
          ChangeNotifierProvider<ContentProvider>(
            create: (context) => ContentProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'CTSE Flutter Project',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              appBarTheme: const AppBarTheme(color: Color(0xff2D4159)),
              scaffoldBackgroundColor: const Color(0xff0F152D)),
          initialRoute: SplashScreen.routeName,
          routes: {
            SplashScreen.routeName: ((context) => const SplashScreen()),
            Home.routeName: ((context) => const Home()),
            ContentList.routeName: (context) => const ContentList(),
            ContentView.routeName: (context) => const ContentView(),
            ProductAddEdit.routeNameAdd: (context) => const ProductAddEdit(),
            ProductAddEdit.routeName: (context) => const ProductAddEdit(),
            Content.routeName: (context) => const Content(),
          },
        ));
  }
}
