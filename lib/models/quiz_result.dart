class QuizResult {
  final int score;
  final int totalQuestions;
  final DateTime timestamp;
  final Duration timeTaken;

  QuizResult({
    required this.score,
    required this.totalQuestions,
    required this.timestamp,
    required this.timeTaken,
  });

  double get percentage => (score / totalQuestions) * 100;

  Map<String, dynamic> toJson() => {
        'score': score,
        'totalQuestions': totalQuestions,
        'timestamp': timestamp.toIso8601String(),
        'timeTaken': timeTaken.inSeconds,
      };

  factory QuizResult.fromJson(Map<String, dynamic> json) => QuizResult(
        score: json['score'] as int,
        totalQuestions: json['totalQuestions'] as int,
        timestamp: DateTime.parse(json['timestamp'] as String),
        timeTaken: Duration(seconds: json['timeTaken'] as int),
      );
}