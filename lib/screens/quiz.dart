import 'package:flutter/material.dart';
import 'package:quiz_app/screens/home.dart';
import 'package:quiz_app/screens/questions_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  var activeScreen = 'active-screen';

  void switchScreenHandler() {
    setState(() {
      activeScreen = 'question-screen';
    });
  }

  @override
  Widget build(BuildContext ctx) {
    Widget screenWidget = HomeScreen(switchScreenHandler);
    if (activeScreen == "question-screen") {
      screenWidget = const QuestionsScreen();
    } else {
      screenWidget = HomeScreen(switchScreenHandler);
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(142, 36, 170, 1),
                Color.fromRGBO(106, 27, 154, 1),
                Color.fromRGBO(74, 20, 140, 1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
