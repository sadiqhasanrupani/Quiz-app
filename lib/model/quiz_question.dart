class Answer {
  const Answer({required this.titles, this.correctAns = false});

  final String titles;
  final bool? correctAns;
}

class QuizQuestion {
  const QuizQuestion({required this.title, required this.answers});

  final String title;
  final List<Answer> answers;
}
