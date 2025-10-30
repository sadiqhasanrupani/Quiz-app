class Question {
  final String text;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.text,
    required this.options,
    required this.correctAnswerIndex,
  });

  Map<String, dynamic> toJson() => {
        'text': text,
        'options': options,
        'correctAnswerIndex': correctAnswerIndex,
      };

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        text: json['text'] as String,
        options: List<String>.from(json['options'] as List),
        correctAnswerIndex: json['correctAnswerIndex'] as int,
      );
}