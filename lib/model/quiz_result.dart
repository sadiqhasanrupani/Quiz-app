class Result {
  final String question;
  final String givenAnswer;
  final String correctAnswer;

  const Result({
    required this.question,
    required this.givenAnswer,
    required this.correctAnswer,
  });
}

class QuizResult {
  final int correctCount;
  final int totalCount;
  final List<Result> results;

  const QuizResult({
    required this.correctCount,
    required this.totalCount,
    required this.results,
  });
}
