import 'package:flutter_test/flutter_test.dart';
import 'package:datastructure/core/models/topic.dart';
import 'package:datastructure/features/practice/models/quiz_models.dart';
import 'package:datastructure/features/practice/data/questions_bank.dart';

void main() {
  group('Quiz Models', () {
    test('QuizQuestion correct answer', () {
      const q = QuizQuestion(
        id: 'test',
        topic: DataStructureTopic.arrays,
        difficulty: QuizDifficulty.beginner,
        type: QuizQuestionType.concept,
        question: 'Test?',
        options: ['A', 'B', 'C'],
        correctAnswerIndex: 1,
        explanation: 'Because B',
      );
      expect(q.correctAnswer, 'B');
    });

    test('QuizSession scoring', () {
      const q1 = QuizQuestion(
        id: 'q1',
        topic: DataStructureTopic.stacks,
        difficulty: QuizDifficulty.beginner,
        type: QuizQuestionType.concept,
        question: 'Q1?',
        options: ['A', 'B'],
        correctAnswerIndex: 0,
        explanation: 'A',
      );
      const q2 = QuizQuestion(
        id: 'q2',
        topic: DataStructureTopic.stacks,
        difficulty: QuizDifficulty.beginner,
        type: QuizQuestionType.concept,
        question: 'Q2?',
        options: ['A', 'B'],
        correctAnswerIndex: 1,
        explanation: 'B',
      );
      final session = QuizSession(
        id: 's1',
        topic: DataStructureTopic.stacks,
        questions: [q1, q2],
        answers: {'q1': 0, 'q2': 0}, // first correct, second incorrect
      );
      expect(session.correctCount, 1);
      expect(session.totalQuestions, 2);
      expect(session.accuracy, 50.0);
      expect(session.score, 50);
    });

    test('QuizSession completion', () {
      const q = QuizQuestion(
        id: 'q1',
        topic: DataStructureTopic.queues,
        difficulty: QuizDifficulty.beginner,
        type: QuizQuestionType.concept,
        question: 'Q?',
        options: ['A', 'B'],
        correctAnswerIndex: 0,
        explanation: 'A',
      );
      final incomplete = QuizSession(id: 's', topic: DataStructureTopic.queues, questions: [q], answers: {});
      expect(incomplete.isCompleted, false);
      final complete = QuizSession(id: 's', topic: DataStructureTopic.queues, questions: [q], answers: {'q1': 0});
      expect(complete.isCompleted, true);
    });
  });

  group('Questions Bank', () {
    test('get all questions', () {
      final all = QuestionsBank.getAll();
      expect(all.length, greaterThanOrEqualTo(56)); // 8 per topic *7
    });

    test('get by topic', () {
      final arrays = QuestionsBank.getByTopic(DataStructureTopic.arrays);
      expect(arrays.length, greaterThanOrEqualTo(8));
      expect(arrays.every((q) => q.topic == DataStructureTopic.arrays), true);
    });

    test('get by topic and difficulty', () {
      final beginnerArrays = QuestionsBank.getByTopicAndDifficulty(DataStructureTopic.arrays, QuizDifficulty.beginner);
      expect(beginnerArrays.every((q) => q.difficulty == QuizDifficulty.beginner), true);
    });

    test('recommended returns requested count', () {
      final rec = QuestionsBank.getRecommended(topic: DataStructureTopic.stacks, count: 5);
      expect(rec.length, 5);
    });

    test('questions have valid correct index', () {
      final all = QuestionsBank.getAll();
      for (var q in all) {
        expect(q.correctAnswerIndex, greaterThanOrEqualTo(0));
        expect(q.correctAnswerIndex, lessThan(q.options.length));
      }
    });

    test('each topic has mixed difficulties', () {
      for (var topic in DataStructureTopic.values) {
        final questions = QuestionsBank.getByTopic(topic);
        final difficulties = questions.map((q) => q.difficulty).toSet();
        // At least 2 difficulty levels per topic
        expect(difficulties.length, greaterThanOrEqualTo(2), reason: 'Topic ${topic.displayName} should have mixed difficulties');
      }
    });

    test('each topic has multiple question types', () {
      for (var topic in DataStructureTopic.values) {
        final questions = QuestionsBank.getByTopic(topic);
        final types = questions.map((q) => q.type).toSet();
        expect(types.length, greaterThanOrEqualTo(2), reason: 'Topic ${topic.displayName} should have multiple types');
      }
    });
  });
}
