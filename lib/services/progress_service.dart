import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persists learning progress (completed lessons + quiz scores) locally
/// so progress survives an app restart, per the Week 1 "Saved learning
/// state" requirement.
class ProgressService extends ChangeNotifier {
  static const _completedLessonsKey = 'completed_lesson_ids';
  static const _quizScoresKey = 'quiz_scores'; // lessonId -> score json
  static const _onboardingDoneKey = 'onboarding_done';

  final Set<String> _completedLessonIds = {};
  final Map<String, int> _quizScores = {};
  bool _onboardingDone = false;
  bool _loaded = false;

  bool get isLoaded => _loaded;
  bool get onboardingDone => _onboardingDone;
  Set<String> get completedLessonIds => _completedLessonIds;
  Map<String, int> get quizScores => _quizScores;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _completedLessonIds
      ..clear()
      ..addAll(prefs.getStringList(_completedLessonsKey) ?? []);
    final rawScores = prefs.getString(_quizScoresKey);
    if (rawScores != null) {
      final decoded = jsonDecode(rawScores) as Map<String, dynamic>;
      _quizScores
        ..clear()
        ..addAll(decoded.map((k, v) => MapEntry(k, v as int)));
    }
    _onboardingDone = prefs.getBool(_onboardingDoneKey) ?? false;
    _loaded = true;
    notifyListeners();
  }

  Future<void> markOnboardingDone() async {
    _onboardingDone = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingDoneKey, true);
    notifyListeners();
  }

  Future<void> markLessonComplete(String lessonId) async {
    _completedLessonIds.add(lessonId);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        _completedLessonsKey, _completedLessonIds.toList());
    notifyListeners();
  }

  Future<void> saveQuizScore(String lessonId, int score) async {
    _quizScores[lessonId] = score;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_quizScoresKey, jsonEncode(_quizScores));
    notifyListeners();
  }

  bool isLessonComplete(String lessonId) =>
      _completedLessonIds.contains(lessonId);

  double progressForLessonIds(List<String> lessonIds) {
    if (lessonIds.isEmpty) return 0;
    final done =
        lessonIds.where((id) => _completedLessonIds.contains(id)).length;
    return done / lessonIds.length;
  }
}
