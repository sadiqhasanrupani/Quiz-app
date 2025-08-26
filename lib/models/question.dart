import "package:flutter/foundation.dart";

@immutable
class Question {
  final String id;
  final String text;
  final List<String> options;
  final int correctIndex;
  final String? explanation;

  const Question({
    required this.id,
    required this.text,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  }) : assert(options.length >= 2, 'A Question must have at least 2 options.'),
       assert(
         correctIndex >= 0 && correctIndex < options.length,
         'correctIndex must be a valid index into optoins.',
       );
}
