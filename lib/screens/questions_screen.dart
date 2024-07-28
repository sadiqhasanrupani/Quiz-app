import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:quiz_app/model/quiz_question.dart';

import 'package:quiz_app/screens/utils/global_colors.dart';
import 'package:quiz_app/widgets/button.dart';
import 'package:quiz_app/data/questions.dart';

class QuestionsScreen extends StatefulWidget {
  final void Function(Answer selectedAns) onSelectedAnswer;
  const QuestionsScreen({super.key, required this.onSelectedAnswer});

  @override
  State<StatefulWidget> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuesIdx = 0;
  void onSelectedAnswer(Answer selectedAns) {
    widget.onSelectedAnswer(selectedAns);

    setState(() {
      currentQuesIdx++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentQues = questions[currentQuesIdx];

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
              style: GoogleFonts.lato(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ...currentQues.getShuffleAnswers().map(
              (answer) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Button(
                      label: BtnText(
                        answer.title,
                      ),
                      onPressed: () {
                        onSelectedAnswer(
                          Answer(
                            title: answer.title,
                            correctAns: answer.correctAns ?? false,
                          ),
                        );
                      },
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
    // Check if center is not null before using it

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.raleway(
          color: textColor,
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
