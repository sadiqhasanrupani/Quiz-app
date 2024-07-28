import 'package:flutter/material.dart';

import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/model/quiz_question.dart';
import 'package:quiz_app/model/quiz_result.dart';
import 'package:quiz_app/screens/home.dart';
import 'package:quiz_app/screens/questions_screen.dart';
import 'package:quiz_app/screens/result_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  var activeScreen = 'active-screen';
  List<Answer> selectedAnswer = [];

  void switchScreenHandler() {
    setState(() {
      activeScreen = 'question-screen';
    });
  }

  void populateSelectedAnswers(Answer answer) {
    selectedAnswer.add(
      Answer(
        title: answer.title,
        correctAns: answer.correctAns,
      ),
    );

    if (selectedAnswer.length == questions.length) {
      setState(() {
        activeScreen = 'result-screen';
      });
    }
  }

  @override
  Widget build(BuildContext ctx) {
    Widget screenWidget = HomeScreen(switchScreenHandler);
    if (activeScreen == "question-screen") {
      screenWidget = QuestionsScreen(
        onSelectedAnswer: populateSelectedAnswers,
      );
    } else if (activeScreen == "result-screen") {
      List<Result> correctAnswers = [];
      int count = 0;

      for (var i = 0; i < questions.length; i++) {
        final currentSelectedAns = selectedAnswer[i];
        final correctAns =
            questions[i].answers.firstWhere((ans) => ans.correctAns == true);

        if (currentSelectedAns.title == correctAns.title) {
          if (currentSelectedAns.correctAns == true) {
            count++;
          }
        }

        correctAnswers.add(
          Result(
            question: questions[i].title,
            givenAnswer: selectedAnswer[i].title,
            correctAnswer: correctAns.title,
          ),
        );
      }

      QuizResult quizResult = QuizResult(
        correctCount: count,
        totalCount: questions.length,
        results: correctAnswers,
      );

      screenWidget = ResultScreen(
        quizResult: quizResult,
      );
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
