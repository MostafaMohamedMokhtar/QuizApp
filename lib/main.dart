import 'package:flutter/material.dart';
import 'package:quiz_app/pages/home.dart';
import 'package:quiz_app/pages/quiz.dart';
import 'package:quiz_app/pages/resultScreen.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Home.ROUTE,
      routes: {'/': (context) => Home(), '/quiz': (context) => QuizScreen() ,},
    );
  }
}
