import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/quiz_result.dart';

class StorageService {
  static const String _lastScoreKey = 'last_score';
  static const String _resumeDataKey = 'resume_data';
  static const String _allScoresKey = 'all_scores';

  static StorageService? _instance;
  static SharedPreferences? _prefs;

  StorageService._();

  static Future<StorageService> getInstance() async {
    if (_instance == null) {
      _instance = StorageService._();
      _prefs = await SharedPreferences.getInstance();
    }
    return _instance!;
  }

  // Save last quiz result
  Future<void> saveLastScore(QuizResult result) async {
    await _prefs?.setString(_lastScoreKey, jsonEncode(result.toJson()));
    await _saveToAllScores(result);
  }

  // Get last quiz result
  QuizResult? getLastScore() {
    final scoreData = _prefs?.getString(_lastScoreKey);
    if (scoreData != null) {
      return QuizResult.fromJson(jsonDecode(scoreData));
    }
    return null;
  }

  // Save quiz progress for resume functionality
  Future<void> saveResumeData({
    required int currentQuestion,
    required List<int?> answers,
    required DateTime startTime,
  }) async {
    final resumeData = {
      'currentQuestion': currentQuestion,
      'answers': answers,
      'startTime': startTime.toIso8601String(),
    };
    await _prefs?.setString(_resumeDataKey, jsonEncode(resumeData));
  }

  // Get quiz progress data
  Map<String, dynamic>? getResumeData() {
    final resumeData = _prefs?.getString(_resumeDataKey);
    if (resumeData != null) {
      return jsonDecode(resumeData);
    }
    return null;
  }

  // Clear resume data
  Future<void> clearResumeData() async {
    await _prefs?.remove(_resumeDataKey);
  }

  // Private method to save score to all scores list
  Future<void> _saveToAllScores(QuizResult result) async {
    final allScoresData = _prefs?.getString(_allScoresKey);
    List<QuizResult> allScores = [];
    
    if (allScoresData != null) {
      final List<dynamic> scoresJson = jsonDecode(allScoresData);
      allScores = scoresJson.map((json) => QuizResult.fromJson(json)).toList();
    }
    
    allScores.add(result);
    
    // Keep only last 10 scores
    if (allScores.length > 10) {
      allScores = allScores.sublist(allScores.length - 10);
    }
    
    await _prefs?.setString(_allScoresKey, jsonEncode(allScores.map((s) => s.toJson()).toList()));
  }

  // Get all scores
  List<QuizResult> getAllScores() {
    final allScoresData = _prefs?.getString(_allScoresKey);
    if (allScoresData != null) {
      final List<dynamic> scoresJson = jsonDecode(allScoresData);
      return scoresJson.map((json) => QuizResult.fromJson(json)).toList();
    }
    return [];
  }

  // Clear all data
  Future<void> clearAllData() async {
    await _prefs?.clear();
  }
}