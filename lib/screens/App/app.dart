import 'package:flutter/material.dart';
import 'package:quiz_app/screens/home/home.dart';
import 'package:quiz_app/screens/questions/questions.dart';
import 'package:quiz_app/wrapper/main_wrapper.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // Store a Widget here
  late Widget activeScreen;

  @override
  void initState() {
    super.initState();
    // Initialize with HomePage
    activeScreen = HomePage(onStartQuiz: switchScreen);
  }

  void switchScreen() {
    setState(() {
      activeScreen = const QuestionScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainWrapper(child: activeScreen);
  }
}
