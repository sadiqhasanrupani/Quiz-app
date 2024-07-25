import 'package:flutter/material.dart';
import 'package:quiz_app/screens/utils/global_colors.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Question Screen",
        style: TextStyle(color: textColor, fontSize: 18),
      ),
    );
  }
}
