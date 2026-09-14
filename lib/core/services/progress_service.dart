import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/topic.dart';
import '../models/progress_models.dart';

class ProgressService {
  static const String _progressKey = 'learning_progress_v2';
  static const String _quizAttemptsKey = 'quiz_attempts_v2';

  static final ProgressService _instance = ProgressService._internal();
  factory ProgressService() => _instance;
  ProgressService._internal();

  LearningProgress _progress = LearningProgress();
  List<QuizAttempt> _quizAttempts = [];

  LearningProgress get progress => _progress;
  List<QuizAttempt> get quizAttempts => List.unmodifiable(_quizAttempts);

  final List<void Function()> _listeners = [];
  void addListener(void Function() listener) => _listeners.add(listener);
  void removeListener(void Function() listener) => _listeners.remove(listener);
  void _notify() {
    for (var l in List<void Function()>.from(_listeners)) {
      try {
        l();
      } catch (_) {}
    }
  }

  Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_progressKey);
      if (jsonString != null) {
        _progress = LearningProgress.fromJsonString(jsonString);
      }
      final attemptsJson = prefs.getString(_quizAttemptsKey);
      if (attemptsJson != null) {
        final List<dynamic> decoded = jsonDecode(attemptsJson) as List<dynamic>;
        _quizAttempts = decoded
            .map((e) => QuizAttempt.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } catch (_) {
      _progress = LearningProgress();
      _quizAttempts = [];
    }
    _notify();
  }

  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_progressKey, _progress.toJsonString());
      final attemptsList = _quizAttempts.map((e) => e.toJson()).toList();
      await prefs.setString(_quizAttemptsKey, jsonEncode(attemptsList));
    } catch (_) {
      // ignore storage issues
    }
    _notify();
  }

  Future<void> markIntroductionViewed(DataStructureTopic topic) async {
    _progress.topics[topic]!.introductionViewed = true;
    _progress.topics[topic]!.lastStudied = DateTime.now();
    _progress.lastStudiedTopic = topic;
    _progress.lastOpenedLesson = '${topic.displayName} - Introduction';
    await _updateStreak();
    await _save();
  }

  Future<void> markOperationsViewed(DataStructureTopic topic) async {
    _progress.topics[topic]!.operationsViewed = true;
    _progress.topics[topic]!.lastStudied = DateTime.now();
    _progress.lastStudiedTopic = topic;
    await _updateStreak();
    await _save();
  }

  Future<void> markComplexityViewed(DataStructureTopic topic) async {
    _progress.topics[topic]!.complexityViewed = true;
    _progress.topics[topic]!.lastStudied = DateTime.now();
    _progress.lastStudiedTopic = topic;
    await _updateStreak();
    await _save();
  }

  Future<void> markVisualizerUsed(DataStructureTopic topic) async {
    _progress.topics[topic]!.visualizerUsed = true;
    _progress.topics[topic]!.lastStudied = DateTime.now();
    _progress.lastStudiedTopic = topic;
    _progress.lastOpenedLesson = '${topic.displayName} - Visualizer';
    await _updateStreak();
    await _save();
  }

  Future<void> recordQuizAttempt(QuizAttempt attempt) async {
    _quizAttempts.add(attempt);
    _progress.totalQuizzesCompleted++;
    _progress.totalQuestionsAnswered += attempt.totalQuestions;
    _progress.totalCorrectAnswers += attempt.correctAnswers;
    _progress.totalIncorrectAnswers +=
        (attempt.totalQuestions - attempt.correctAnswers);

    final tp = _progress.topics[attempt.topic]!;
    tp.quizAttempted = true;
    tp.quizAttempts++;
    tp.totalQuestionsAnswered += attempt.totalQuestions;
    tp.correctAnswers += attempt.correctAnswers;
    if (attempt.score > tp.bestQuizScore) {
      tp.bestQuizScore = attempt.score;
    }
    tp.lastStudied = DateTime.now();
    _progress.lastStudiedTopic = attempt.topic;
    _progress.lastOpenedLesson = '${attempt.topic.displayName} - Quiz';

    await _updateStreak();
    await _save();
  }

  Future<void> recordQuestionAnswered(
      DataStructureTopic topic, bool isCorrect) async {
    _progress.totalQuestionsAnswered++;
    if (isCorrect) {
      _progress.totalCorrectAnswers++;
    } else {
      _progress.totalIncorrectAnswers++;
    }
    final tp = _progress.topics[topic]!;
    tp.totalQuestionsAnswered++;
    if (isCorrect) tp.correctAnswers++;
    await _save();
  }

  Future<void> _updateStreak() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    if (_progress.lastStudyDate == null) {
      _progress.streakDays = 1;
      _progress.lastStudyDate = today;
      return;
    }
    final last = DateTime(_progress.lastStudyDate!.year,
        _progress.lastStudyDate!.month, _progress.lastStudyDate!.day);
    final diff = today.difference(last).inDays;
    if (diff == 0) {
      return;
    } else if (diff == 1) {
      _progress.streakDays++;
      _progress.lastStudyDate = today;
    } else if (diff > 1) {
      _progress.streakDays = 1;
      _progress.lastStudyDate = today;
    }
  }

  Future<void> toggleBookmark(DataStructureTopic topic) async {
    if (_progress.bookmarkedTopics.contains(topic)) {
      _progress.bookmarkedTopics.remove(topic);
    } else {
      _progress.bookmarkedTopics.add(topic);
    }
    await _save();
  }

  Future<void> clearProgress() async {
    _progress = LearningProgress();
    _quizAttempts = [];
    await _save();
  }

  DataStructureTopic getRecommendedTopic() {
    if (_progress.overallCompletion == 0) {
      return DataStructureTopic.arrays;
    }
    if (_progress.weakTopics.isNotEmpty) {
      var weak = _progress.weakTopics;
      weak.sort((a, b) {
        final accA = _progress.topics[a]!.accuracy;
        final accB = _progress.topics[b]!.accuracy;
        return accA.compareTo(accB);
      });
      return weak.first;
    }
    if (_progress.lastStudiedTopic != null) {
      final last = _progress.topics[_progress.lastStudiedTopic!]!;
      if (!last.isCompleted) {
        return _progress.lastStudiedTopic!;
      }
      final nextIndex = last.topic.orderIndex + 1;
      if (nextIndex < DataStructureTopic.learningOrder.length) {
        return DataStructureTopic.learningOrder[nextIndex];
      }
    }
    for (var t in DataStructureTopic.learningOrder) {
      if (!_progress.topics[t]!.isCompleted) {
        return t;
      }
    }
    var all = DataStructureTopic.values.toList();
    all.sort((a, b) => _progress.topics[a]!.accuracy
        .compareTo(_progress.topics[b]!.accuracy));
    return all.first;
  }

  String getRecommendationReason(DataStructureTopic topic) {
    final tp = _progress.topics[topic]!;
    if (tp.totalQuestionsAnswered >= 3 && tp.accuracy < 70) {
      return 'Needs practice — Accuracy ${tp.accuracy.toStringAsFixed(0)}%';
    }
    if (_progress.lastStudiedTopic == topic && !tp.isCompleted) {
      return 'Continue where you left off — ${tp.completionPercentage.toStringAsFixed(0)}% complete';
    }
    if (tp.completionPercentage == 0) {
      return 'Start learning ${topic.displayName}';
    }
    if (tp.completionPercentage < 100) {
      return 'Continue learning — ${tp.completionPercentage.toStringAsFixed(0)}% complete';
    }
    return 'Review ${topic.displayName}';
  }
}
