class Answer {
  const Answer({required this.title, this.correctAns = false});

  final String title;
  final bool? correctAns;
}

class QuizQuestion {
  const QuizQuestion({required this.title, required this.answers});

  final String title;
  final List<Answer> answers;

  List<Answer> getShuffleAnswers() {
    final shuffledLists = List.of(answers);
    shuffledLists.shuffle();
    return shuffledLists;
  }
}
