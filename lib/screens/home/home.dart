import "package:flutter/material.dart";

class HomePage extends StatelessWidget {
  final VoidCallback? onStartQuiz;

  const HomePage({super.key, this.onStartQuiz});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Opacity(
          //   opacity: 0.5,
          //   child: Image.asset('assets/images/quiz-logo.png', width: 300),
          // ),
          Image.asset(
            'assets/images/quiz-logo.png',
            width: 300,
            color: const Color.fromARGB(150, 255, 255, 255),
          ),
          const SizedBox(height: 80),
          // TODO: Make this re-usable component
          const Text(
            "Learn Flutter the fun way!",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 20),
          // TODO: Make this re-usable component
          OutlinedButton.icon(
            onPressed: onStartQuiz,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: BorderSide.none,
            ),
            icon: Icon(Icons.keyboard_double_arrow_right_outlined),
            label: const Text('Let\'s Begin'),
          ),
        ],
      ),
    );
  }
}
