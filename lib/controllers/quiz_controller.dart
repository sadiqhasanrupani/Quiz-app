import 'package:flutter/foundation.dart';
import '../models/question.dart';
import '../models/quiz_result.dart';
import '../services/storage_service.dart';

class QuizController extends ChangeNotifier {
  final StorageService _storageService;
  
  // Quiz state
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  List<int?> _userAnswers = [];
  DateTime? _quizStartTime;
  bool _isQuizActive = false;
  bool _isLoading = false;

  // Resume state
  bool _hasResumeData = false;
  
  QuizController(this._storageService) {
    _loadResumeState();
  }

  // Getters
  List<Question> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  Question? get currentQuestion => _questions.isNotEmpty && _currentQuestionIndex < _questions.length 
      ? _questions[_currentQuestionIndex] 
      : null;
  List<int?> get userAnswers => _userAnswers;
  bool get isQuizActive => _isQuizActive;
  bool get hasResumeData => _hasResumeData;
  bool get isLoading => _isLoading;
  int get totalQuestions => _questions.length;
  bool get isLastQuestion => _currentQuestionIndex >= _questions.length - 1;

  // Get last quiz result
  QuizResult? getLastScore() {
    return _storageService.getLastScore();
  }

  // Initialize new quiz
  Future<void> startNewQuiz() async {
    _isLoading = true;
    notifyListeners();

    await _storageService.clearResumeData();
    _initializeQuiz();
    
    _isLoading = false;
    notifyListeners();
  }

  // Resume quiz from saved state
  Future<void> resumeQuiz() async {
    _isLoading = true;
    notifyListeners();

    final resumeData = _storageService.getResumeData();
    if (resumeData != null) {
      _initializeQuiz();
      _currentQuestionIndex = resumeData['currentQuestion'] ?? 0;
      _userAnswers = List<int?>.from(resumeData['answers'] ?? []);
      _quizStartTime = DateTime.parse(resumeData['startTime']);
      _isQuizActive = true;
    } else {
      _initializeQuiz();
    }
    
    _isLoading = false;
    notifyListeners();
  }

  // Answer current question
  void answerQuestion(int answerIndex) {
    if (!_isQuizActive || _currentQuestionIndex >= _questions.length) return;

    // Ensure answers list is long enough
    while (_userAnswers.length <= _currentQuestionIndex) {
      _userAnswers.add(null);
    }

    _userAnswers[_currentQuestionIndex] = answerIndex;
    _saveProgress();
    notifyListeners();
  }

  // Move to next question
  void nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  // Move to previous question
  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  // Finish quiz and calculate results
  Future<QuizResult> finishQuiz() async {
    if (!_isQuizActive) throw Exception('No active quiz to finish');

    final endTime = DateTime.now();
    final timeTaken = endTime.difference(_quizStartTime!);
    
    int correctAnswers = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (i < _userAnswers.length && 
          _userAnswers[i] == _questions[i].correctAnswerIndex) {
        correctAnswers++;
      }
    }

    final result = QuizResult(
      score: correctAnswers,
      totalQuestions: _questions.length,
      timestamp: endTime,
      timeTaken: timeTaken,
    );

    await _storageService.saveLastScore(result);
    await _storageService.clearResumeData();
    
    _resetQuiz();
    
    return result;
  }

  // Private methods
  void _initializeQuiz() {
    _questions = _getSampleQuestions();
    _currentQuestionIndex = 0;
    _userAnswers = List.filled(_questions.length, null);
    _quizStartTime = DateTime.now();
    _isQuizActive = true;
    _hasResumeData = false;
  }

  void _resetQuiz() {
    _questions = [];
    _currentQuestionIndex = 0;
    _userAnswers = [];
    _quizStartTime = null;
    _isQuizActive = false;
    _hasResumeData = false;
    notifyListeners();
  }

  Future<void> _saveProgress() async {
    if (_isQuizActive && _quizStartTime != null) {
      await _storageService.saveResumeData(
        currentQuestion: _currentQuestionIndex,
        answers: _userAnswers,
        startTime: _quizStartTime!,
      );
    }
  }

  void _loadResumeState() {
    final resumeData = _storageService.getResumeData();
    _hasResumeData = resumeData != null;
    notifyListeners();
  }

  // Sample questions for the quiz
  List<Question> _getSampleQuestions() {
    return [
      Question(
        text: "What is the capital of France?",
        options: ["London", "Berlin", "Paris", "Madrid"],
        correctAnswerIndex: 2,
      ),
      Question(
        text: "Which planet is known as the Red Planet?",
        options: ["Venus", "Mars", "Jupiter", "Saturn"],
        correctAnswerIndex: 1,
      ),
      Question(
        text: "What is 2 + 2?",
        options: ["3", "4", "5", "6"],
        correctAnswerIndex: 1,
      ),
      Question(
        text: "Who painted the Mona Lisa?",
        options: ["Vincent van Gogh", "Pablo Picasso", "Leonardo da Vinci", "Michelangelo"],
        correctAnswerIndex: 2,
      ),
      Question(
        text: "What is the largest ocean on Earth?",
        options: ["Atlantic Ocean", "Indian Ocean", "Arctic Ocean", "Pacific Ocean"],
        correctAnswerIndex: 3,
      ),
    ];
  }
}