import 'package:flutter/material.dart';
import 'package:quiz_app/model/quiz_result.dart';

class ResultScreen extends StatelessWidget {
  final QuizResult quizResult;

  const ResultScreen({super.key, required this.quizResult});

  @override
  Widget build(BuildContext context) {
    () {
      debugPrint("correctCount: ${quizResult.correctCount}");
      debugPrint("totalCount: ${quizResult.totalCount}");

      quizResult.results.forEach((result) {
        debugPrint("question: ${result.question}");
        debugPrint("CorrectAnswer: ${result.correctAnswer}");
        debugPrint("givenAnswer: ${result.givenAnswer}\n");
      });
    }();

    return const Text("Result Screen");
  }
}
