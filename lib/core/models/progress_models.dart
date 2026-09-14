import 'dart:convert';
import 'topic.dart';

class TopicProgress {
  final DataStructureTopic topic;
  bool introductionViewed;
  bool operationsViewed;
  bool complexityViewed;
  bool visualizerUsed;
  bool quizAttempted;
  int bestQuizScore; // out of 100
  int quizAttempts;
  int totalQuestionsAnswered;
  int correctAnswers;
  DateTime? lastStudied;

  TopicProgress({
    required this.topic,
    this.introductionViewed = false,
    this.operationsViewed = false,
    this.complexityViewed = false,
    this.visualizerUsed = false,
    this.quizAttempted = false,
    this.bestQuizScore = 0,
    this.quizAttempts = 0,
    this.totalQuestionsAnswered = 0,
    this.correctAnswers = 0,
    this.lastStudied,
  });

  double get completionPercentage {
    int completed = 0;
    if (introductionViewed) completed++;
    if (operationsViewed) completed++;
    if (complexityViewed) completed++;
    if (visualizerUsed) completed++;
    if (quizAttempted) completed++;
    return (completed / 5) * 100;
  }

  double get accuracy {
    if (totalQuestionsAnswered == 0) return 0;
    return (correctAnswers / totalQuestionsAnswered) * 100;
  }

  bool get isCompleted => completionPercentage >= 100;

  Map<String, dynamic> toJson() => {
        'topic': topic.index,
        'introductionViewed': introductionViewed,
        'operationsViewed': operationsViewed,
        'complexityViewed': complexityViewed,
        'visualizerUsed': visualizerUsed,
        'quizAttempted': quizAttempted,
        'bestQuizScore': bestQuizScore,
        'quizAttempts': quizAttempts,
        'totalQuestionsAnswered': totalQuestionsAnswered,
        'correctAnswers': correctAnswers,
        'lastStudied': lastStudied?.toIso8601String(),
      };

  factory TopicProgress.fromJson(Map<String, dynamic> json) {
    return TopicProgress(
      topic: DataStructureTopic.values[json['topic'] as int],
      introductionViewed: json['introductionViewed'] as bool? ?? false,
      operationsViewed: json['operationsViewed'] as bool? ?? false,
      complexityViewed: json['complexityViewed'] as bool? ?? false,
      visualizerUsed: json['visualizerUsed'] as bool? ?? false,
      quizAttempted: json['quizAttempted'] as bool? ?? false,
      bestQuizScore: json['bestQuizScore'] as int? ?? 0,
      quizAttempts: json['quizAttempts'] as int? ?? 0,
      totalQuestionsAnswered: json['totalQuestionsAnswered'] as int? ?? 0,
      correctAnswers: json['correctAnswers'] as int? ?? 0,
      lastStudied: json['lastStudied'] != null
          ? DateTime.tryParse(json['lastStudied'] as String)
          : null,
    );
  }
}

class QuizAttempt {
  final String id;
  final DataStructureTopic topic;
  final QuizDifficulty difficulty;
  final int score;
  final int totalQuestions;
  final int correctAnswers;
  final DateTime date;
  final List<String> questionIds;

  QuizAttempt({
    required this.id,
    required this.topic,
    required this.difficulty,
    required this.score,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.date,
    required this.questionIds,
  });

  double get accuracy =>
      totalQuestions == 0 ? 0 : (correctAnswers / totalQuestions) * 100;

  Map<String, dynamic> toJson() => {
        'id': id,
        'topic': topic.index,
        'difficulty': difficulty.index,
        'score': score,
        'totalQuestions': totalQuestions,
        'correctAnswers': correctAnswers,
        'date': date.toIso8601String(),
        'questionIds': questionIds,
      };

  factory QuizAttempt.fromJson(Map<String, dynamic> json) {
    return QuizAttempt(
      id: json['id'] as String,
      topic: DataStructureTopic.values[json['topic'] as int],
      difficulty: QuizDifficulty.values[json['difficulty'] as int],
      score: json['score'] as int,
      totalQuestions: json['totalQuestions'] as int,
      correctAnswers: json['correctAnswers'] as int,
      date: DateTime.parse(json['date'] as String),
      questionIds: List<String>.from(json['questionIds'] as List),
    );
  }
}

class LearningProgress {
  final Map<DataStructureTopic, TopicProgress> topics;
  int totalQuizzesCompleted;
  int totalQuestionsAnswered;
  int totalCorrectAnswers;
  int totalIncorrectAnswers;
  int streakDays;
  DateTime? lastStudyDate;
  DataStructureTopic? lastStudiedTopic;
  String? lastOpenedLesson;
  Set<DataStructureTopic> bookmarkedTopics;

  LearningProgress({
    Map<DataStructureTopic, TopicProgress>? topics,
    this.totalQuizzesCompleted = 0,
    this.totalQuestionsAnswered = 0,
    this.totalCorrectAnswers = 0,
    this.totalIncorrectAnswers = 0,
    this.streakDays = 0,
    this.lastStudyDate,
    this.lastStudiedTopic,
    this.lastOpenedLesson,
    Set<DataStructureTopic>? bookmarkedTopics,
  })  : topics = topics ??
            {
              for (var t in DataStructureTopic.values)
                t: TopicProgress(topic: t),
            },
        bookmarkedTopics = bookmarkedTopics ?? {};

  double get overallAccuracy {
    if (totalQuestionsAnswered == 0) return 0;
    return (totalCorrectAnswers / totalQuestionsAnswered) * 100;
  }

  double get overallCompletion {
    if (topics.isEmpty) return 0;
    double sum = topics.values
        .map((e) => e.completionPercentage)
        .fold(0.0, (a, b) => a + b);
    return sum / topics.length;
  }

  int get topicsStarted =>
      topics.values.where((t) => t.completionPercentage > 0).length;

  int get topicsCompleted =>
      topics.values.where((t) => t.isCompleted).length;

  List<DataStructureTopic> get weakTopics {
    // accuracy below 70% and at least 3 questions answered
    return topics.values
        .where((t) =>
            t.totalQuestionsAnswered >= 3 && t.accuracy < 70)
        .map((t) => t.topic)
        .toList();
  }

  DataStructureTopic? get bestTopic {
    if (topics.isEmpty) return null;
    var filtered = topics.values
        .where((t) => t.totalQuestionsAnswered > 0)
        .toList();
    if (filtered.isEmpty) return null;
    filtered.sort((a, b) => b.accuracy.compareTo(a.accuracy));
    return filtered.first.topic;
  }

  Map<String, dynamic> toJson() => {
        'topics': topics.map((k, v) => MapEntry(k.index.toString(), v.toJson())),
        'totalQuizzesCompleted': totalQuizzesCompleted,
        'totalQuestionsAnswered': totalQuestionsAnswered,
        'totalCorrectAnswers': totalCorrectAnswers,
        'totalIncorrectAnswers': totalIncorrectAnswers,
        'streakDays': streakDays,
        'lastStudyDate': lastStudyDate?.toIso8601String(),
        'lastStudiedTopic': lastStudiedTopic?.index,
        'lastOpenedLesson': lastOpenedLesson,
        'bookmarkedTopics':
            bookmarkedTopics.map((e) => e.index).toList(),
      };

  factory LearningProgress.fromJson(Map<String, dynamic> json) {
    final topicsMap = <DataStructureTopic, TopicProgress>{};
    if (json['topics'] != null) {
      final raw = json['topics'] as Map<String, dynamic>;
      for (var entry in raw.entries) {
        final topicIndex = int.parse(entry.key);
        final topic = DataStructureTopic.values[topicIndex];
        topicsMap[topic] =
            TopicProgress.fromJson(entry.value as Map<String, dynamic>);
      }
    }
    // Ensure all topics exist
    for (var t in DataStructureTopic.values) {
      topicsMap.putIfAbsent(t, () => TopicProgress(topic: t));
    }

    return LearningProgress(
      topics: topicsMap,
      totalQuizzesCompleted: json['totalQuizzesCompleted'] as int? ?? 0,
      totalQuestionsAnswered: json['totalQuestionsAnswered'] as int? ?? 0,
      totalCorrectAnswers: json['totalCorrectAnswers'] as int? ?? 0,
      totalIncorrectAnswers: json['totalIncorrectAnswers'] as int? ?? 0,
      streakDays: json['streakDays'] as int? ?? 0,
      lastStudyDate: json['lastStudyDate'] != null
          ? DateTime.tryParse(json['lastStudyDate'] as String)
          : null,
      lastStudiedTopic: json['lastStudiedTopic'] != null
          ? DataStructureTopic.values[json['lastStudiedTopic'] as int]
          : null,
      lastOpenedLesson: json['lastOpenedLesson'] as String?,
      bookmarkedTopics: json['bookmarkedTopics'] != null
          ? (json['bookmarkedTopics'] as List)
              .map((e) => DataStructureTopic.values[e as int])
              .toSet()
          : {},
    );
  }

  String toJsonString() => jsonEncode(toJson());

  static LearningProgress fromJsonString(String s) {
    try {
      final map = jsonDecode(s) as Map<String, dynamic>;
      return LearningProgress.fromJson(map);
    } catch (_) {
      return LearningProgress();
    }
  }
}
