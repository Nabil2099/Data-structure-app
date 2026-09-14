import '../../../core/models/topic.dart';

class QuizQuestion {
  final String id;
  final DataStructureTopic topic;
  final QuizDifficulty difficulty;
  final QuizQuestionType type;
  final String question;
  final String? codeSnippet;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;
  final String? complexityExplanation;
  final String? realWorldContext;

  const QuizQuestion({
    required this.id,
    required this.topic,
    required this.difficulty,
    required this.type,
    required this.question,
    this.codeSnippet,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
    this.complexityExplanation,
    this.realWorldContext,
  });

  String get correctAnswer => options[correctAnswerIndex];

  Map<String, dynamic> toJson() => {
        'id': id,
        'topic': topic.index,
        'difficulty': difficulty.index,
        'type': type.index,
        'question': question,
        'codeSnippet': codeSnippet,
        'options': options,
        'correctAnswerIndex': correctAnswerIndex,
        'explanation': explanation,
        'complexityExplanation': complexityExplanation,
        'realWorldContext': realWorldContext,
      };

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      id: json['id'] as String,
      topic: DataStructureTopic.values[json['topic'] as int],
      difficulty: QuizDifficulty.values[json['difficulty'] as int],
      type: QuizQuestionType.values[json['type'] as int],
      question: json['question'] as String,
      codeSnippet: json['codeSnippet'] as String?,
      options: List<String>.from(json['options'] as List),
      correctAnswerIndex: json['correctAnswerIndex'] as int,
      explanation: json['explanation'] as String,
      complexityExplanation: json['complexityExplanation'] as String?,
      realWorldContext: json['realWorldContext'] as String?,
    );
  }
}

class QuizSession {
  final String id;
  final DataStructureTopic topic;
  final QuizDifficulty? difficulty;
  final List<QuizQuestion> questions;
  final Map<String, int> answers; // questionId -> selectedIndex
  final DateTime startedAt;
  DateTime? completedAt;

  QuizSession({
    required this.id,
    required this.topic,
    this.difficulty,
    required this.questions,
    Map<String, int>? answers,
    DateTime? startedAt,
    this.completedAt,
  })  : answers = answers ?? {},
        startedAt = startedAt ?? DateTime.now();

  int get totalQuestions => questions.length;
  int get answeredCount => answers.length;
  int get correctCount {
    int count = 0;
    for (var q in questions) {
      final selected = answers[q.id];
      if (selected != null && selected == q.correctAnswerIndex) {
        count++;
      }
    }
    return count;
  }

  double get accuracy =>
      totalQuestions == 0 ? 0 : (correctCount / totalQuestions) * 100;

  int get score => totalQuestions == 0
      ? 0
      : ((correctCount / totalQuestions) * 100).round();

  bool get isCompleted => answeredCount == totalQuestions;

  QuizQuestion? getQuestionById(String id) {
    try {
      return questions.firstWhere((q) => q.id == id);
    } catch (_) {
      return null;
    }
  }
}
