import 'package:flutter/material.dart';
import 'package:quiz_app/wrapper/main_wrapper.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    return MainWrapper(child: Text("Quiz Screen"));
  }
}
