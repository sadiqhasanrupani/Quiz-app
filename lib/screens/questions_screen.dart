import 'package:flutter/material.dart';

import 'package:quiz_app/screens/utils/global_colors.dart';
import 'package:quiz_app/widgets/button.dart';
import 'package:quiz_app/data/questions.dart';

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
    final currentQues = questions[0];

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQues.title,
              style: const TextStyle(
                color: textColor,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ...currentQues.answers.map(
              (answer) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Button(
                      label: BtnText(answer.titles),
                      onPressed: () {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BtnText extends StatelessWidget {
  final String text;

  const BtnText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: textColor,
        fontSize: 18,
      ),
    );
  }
}
