import 'package:flutter_test/flutter_test.dart';
import 'package:datastructure/core/models/topic.dart';
import 'package:datastructure/core/models/progress_models.dart';

void main() {
  group('TopicProgress', () {
    test('completion percentage calculation', () {
      final tp = TopicProgress(topic: DataStructureTopic.arrays);
      expect(tp.completionPercentage, 0);

      tp.introductionViewed = true;
      expect(tp.completionPercentage, 20);

      tp.operationsViewed = true;
      tp.complexityViewed = true;
      tp.visualizerUsed = true;
      tp.quizAttempted = true;
      expect(tp.completionPercentage, 100);
      expect(tp.isCompleted, true);
    });

    test('accuracy calculation', () {
      final tp = TopicProgress(topic: DataStructureTopic.stacks, totalQuestionsAnswered: 10, correctAnswers: 7);
      expect(tp.accuracy, 70.0);
    });

    test('accuracy zero when no questions', () {
      final tp = TopicProgress(topic: DataStructureTopic.queues);
      expect(tp.accuracy, 0);
    });

    test('serialization', () {
      final tp = TopicProgress(
        topic: DataStructureTopic.trees,
        introductionViewed: true,
        visualizerUsed: true,
        bestQuizScore: 80,
        totalQuestionsAnswered: 5,
        correctAnswers: 4,
      );
      final json = tp.toJson();
      final restored = TopicProgress.fromJson(json);
      expect(restored.topic, tp.topic);
      expect(restored.introductionViewed, true);
      expect(restored.visualizerUsed, true);
      expect(restored.bestQuizScore, 80);
      expect(restored.totalQuestionsAnswered, 5);
    });
  });

  group('LearningProgress', () {
    test('overall completion', () {
      final progress = LearningProgress();
      expect(progress.overallCompletion, 0);

      progress.topics[DataStructureTopic.arrays]!.introductionViewed = true;
      progress.topics[DataStructureTopic.arrays]!.operationsViewed = true;
      progress.topics[DataStructureTopic.arrays]!.complexityViewed = true;
      progress.topics[DataStructureTopic.arrays]!.visualizerUsed = true;
      progress.topics[DataStructureTopic.arrays]!.quizAttempted = true;

      // 1 topic fully completed out of 7 => ~14.28%
      expect(progress.overallCompletion, closeTo(100 / 7, 0.1));
    });

    test('overall accuracy', () {
      final progress = LearningProgress(totalQuestionsAnswered: 10, totalCorrectAnswers: 8);
      expect(progress.overallAccuracy, 80.0);
    });

    test('weak topics detection', () {
      final progress = LearningProgress();
      progress.topics[DataStructureTopic.trees]!.totalQuestionsAnswered = 5;
      progress.topics[DataStructureTopic.trees]!.correctAnswers = 2; // 40% accuracy

      progress.topics[DataStructureTopic.arrays]!.totalQuestionsAnswered = 5;
      progress.topics[DataStructureTopic.arrays]!.correctAnswers = 5; // 100%

      expect(progress.weakTopics, contains(DataStructureTopic.trees));
      expect(progress.weakTopics, isNot(contains(DataStructureTopic.arrays)));
    });

    test('weak topics requires minimum questions', () {
      final progress = LearningProgress();
      progress.topics[DataStructureTopic.graphs]!.totalQuestionsAnswered = 2;
      progress.topics[DataStructureTopic.graphs]!.correctAnswers = 0; // 0% but only 2 questions

      expect(progress.weakTopics, isNot(contains(DataStructureTopic.graphs)));
    });

    test('best topic detection', () {
      final progress = LearningProgress();
      progress.topics[DataStructureTopic.stacks]!.totalQuestionsAnswered = 10;
      progress.topics[DataStructureTopic.stacks]!.correctAnswers = 9; // 90%

      progress.topics[DataStructureTopic.queues]!.totalQuestionsAnswered = 10;
      progress.topics[DataStructureTopic.queues]!.correctAnswers = 5; // 50%

      expect(progress.bestTopic, DataStructureTopic.stacks);
    });

    test('serialization round trip', () {
      final progress = LearningProgress(
        totalQuizzesCompleted: 3,
        totalQuestionsAnswered: 20,
        totalCorrectAnswers: 15,
        streakDays: 5,
        lastStudiedTopic: DataStructureTopic.trees,
      );
      progress.topics[DataStructureTopic.arrays]!.introductionViewed = true;
      progress.bookmarkedTopics.add(DataStructureTopic.stacks);

      final jsonString = progress.toJsonString();
      final restored = LearningProgress.fromJsonString(jsonString);

      expect(restored.totalQuizzesCompleted, 3);
      expect(restored.totalQuestionsAnswered, 20);
      expect(restored.streakDays, 5);
      expect(restored.lastStudiedTopic, DataStructureTopic.trees);
      expect(restored.topics[DataStructureTopic.arrays]!.introductionViewed, true);
      expect(restored.bookmarkedTopics, contains(DataStructureTopic.stacks));
    });

    test('topics started and completed counts', () {
      final progress = LearningProgress();
      expect(progress.topicsStarted, 0);
      expect(progress.topicsCompleted, 0);

      progress.topics[DataStructureTopic.arrays]!.introductionViewed = true;
      expect(progress.topicsStarted, 1);

      progress.topics[DataStructureTopic.arrays]!.operationsViewed = true;
      progress.topics[DataStructureTopic.arrays]!.complexityViewed = true;
      progress.topics[DataStructureTopic.arrays]!.visualizerUsed = true;
      progress.topics[DataStructureTopic.arrays]!.quizAttempted = true;
      expect(progress.topicsCompleted, 1);
    });
  });

  group('QuizAttempt', () {
    test('accuracy and serialization', () {
      final attempt = QuizAttempt(
        id: 'test1',
        topic: DataStructureTopic.graphs,
        difficulty: QuizDifficulty.intermediate,
        score: 80,
        totalQuestions: 10,
        correctAnswers: 8,
        date: DateTime(2024, 1, 1),
        questionIds: ['q1', 'q2'],
      );
      expect(attempt.accuracy, 80.0);

      final json = attempt.toJson();
      final restored = QuizAttempt.fromJson(json);
      expect(restored.id, 'test1');
      expect(restored.topic, DataStructureTopic.graphs);
      expect(restored.correctAnswers, 8);
    });
  });
}
