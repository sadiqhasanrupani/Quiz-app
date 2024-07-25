import 'package:flutter/material.dart';
import 'package:quiz_app/screens/utils/global_colors.dart';

class HomeScreen extends StatelessWidget {
  final void Function() switchScreenHandler;

  const HomeScreen(this.switchScreenHandler, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/images/quiz-logo.png",
            width: 350,
            color: Color(0x95FFFFFF),
          ),
          const SizedBox(
            height: 50,
          ),
          const Text(
            "Learn Flutter the fun way!",
            style: TextStyle(fontSize: 23, color: textColor),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple[400],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: switchScreenHandler,
            label: const Text(
              "Start Quiz",
              style: TextStyle(
                  color: textColor, fontWeight: FontWeight.w600, fontSize: 18),
            ),
            icon: const Icon(
              Icons.arrow_circle_right_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
