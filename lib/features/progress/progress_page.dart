import 'package:flutter/material.dart';
import '../../core/models/topic.dart';
import '../../core/services/progress_service.dart';
import '../../core/widgets/common_widgets.dart';
import '../practice/pages/quiz_page.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  final ProgressService _service = ProgressService();

  @override
  void initState() {
    super.initState();
    _service.addListener(_onProgressChanged);
  }

  @override
  void dispose() {
    _service.removeListener(_onProgressChanged);
    super.dispose();
  }

  void _onProgressChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final progress = _service.progress;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Learning Progress'),
        backgroundColor: const Color(0xFF0C8159),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  backgroundColor: const Color(0xFF181A1B),
                  title: const Text('Reset Progress?', style: TextStyle(color: Colors.white)),
                  content: const Text('This will clear all your learning progress and quiz history. This cannot be undone.',
                      style: TextStyle(color: Colors.white70)),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                    TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Reset', style: TextStyle(color: Colors.redAccent))),
                  ],
                ),
              );
              if (confirm == true) {
                await _service.clearProgress();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Progress cleared')));
                }
              }
            },
          ),
        ],
      ),
      body: progress.overallCompletion == 0 && progress.totalQuizzesCompleted == 0
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.emoji_events_outlined, size: 64, color: Colors.white24),
                    const SizedBox(height: 16),
                    const Text('Your learning journey starts here.',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                    const SizedBox(height: 8),
                    const Text('Complete your first lesson or quiz to begin tracking progress.',
                        style: TextStyle(color: Colors.white54, fontSize: 14), textAlign: TextAlign.center),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Navigate to learn tab - pop to first route
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Start Learning'),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3FB950), foregroundColor: Colors.black),
                    ),
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Overall
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF181A1B),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Overall Progress',
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: progress.overallCompletion / 100,
                            backgroundColor: Colors.white10,
                            valueColor: const AlwaysStoppedAnimation(Color(0xFF3FB950)),
                            minHeight: 12,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${progress.overallCompletion.toStringAsFixed(0)}% Complete',
                                style: const TextStyle(color: Colors.white70, fontSize: 13)),
                            Text('${progress.topicsCompleted}/${progress.topics.length} Topics',
                                style: const TextStyle(color: Colors.white38, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Stats grid
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.5,
                    children: [
                      ProgressCard(
                        title: 'Topics Started',
                        value: '${progress.topicsStarted}/${progress.topics.length}',
                        subtitle: '${progress.topicsCompleted} completed',
                        icon: Icons.school,
                      ),
                      ProgressCard(
                        title: 'Streak',
                        value: '🔥 ${progress.streakDays} Day',
                        subtitle: progress.streakDays > 1 ? '${progress.streakDays} days in a row' : 'Keep going!',
                        icon: Icons.local_fire_department,
                        color: Colors.orange,
                      ),
                      ProgressCard(
                        title: 'Questions Answered',
                        value: '${progress.totalQuestionsAnswered}',
                        subtitle: '${progress.totalCorrectAnswers} correct',
                        icon: Icons.quiz,
                      ),
                      ProgressCard(
                        title: 'Quiz Accuracy',
                        value: '${progress.overallAccuracy.toStringAsFixed(0)}%',
                        subtitle: '${progress.totalQuizzesCompleted} quizzes',
                        icon: Icons.analytics,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const SectionHeader(title: 'Topic Progress', subtitle: 'Your learning journey by topic'),
                  const SizedBox(height: 12),
                  ...DataStructureTopic.learningOrder.map((topic) {
                    final tp = progress.topics[topic]!;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF181A1B),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(topic.displayName,
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                              Text('${tp.completionPercentage.toStringAsFixed(0)}%',
                                  style: const TextStyle(color: Colors.white54, fontSize: 12)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: tp.completionPercentage / 100,
                              backgroundColor: Colors.white10,
                              valueColor: AlwaysStoppedAnimation(
                                tp.completionPercentage >= 100
                                    ? const Color(0xFF3FB950)
                                    : tp.completionPercentage >= 50
                                        ? Colors.orange
                                        : Colors.white24,
                              ),
                              minHeight: 6,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 6,
                            runSpacing: 4,
                            children: [
                              _progressChip('Intro', tp.introductionViewed),
                              _progressChip('Ops', tp.operationsViewed),
                              _progressChip('Complexity', tp.complexityViewed),
                              _progressChip('Visualizer', tp.visualizerUsed),
                              _progressChip('Quiz', tp.quizAttempted),
                            ],
                          ),
                          if (tp.totalQuestionsAnswered > 0) ...[
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text('Accuracy: ${tp.accuracy.toStringAsFixed(0)}% (${tp.correctAnswers}/${tp.totalQuestionsAnswered})',
                                    style: const TextStyle(color: Colors.white38, fontSize: 11)),
                                const Spacer(),
                                if (tp.bestQuizScore > 0)
                                  Text('Best: ${tp.bestQuizScore}%',
                                      style: const TextStyle(color: Color(0xFF3FB950), fontSize: 11, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 20),
                  if (progress.weakTopics.isNotEmpty) ...[
                    const SectionHeader(title: 'Needs Practice', subtitle: 'Topics with accuracy below 70%'),
                    const SizedBox(height: 12),
                    ...progress.weakTopics.map((topic) {
                      final tp = progress.topics[topic]!;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.warning_amber, color: Colors.orange, size: 18),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(topic.displayName,
                                      style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                                  Text('Accuracy: ${tp.accuracy.toStringAsFixed(0)}% • ${tp.totalQuestionsAnswered} questions',
                                      style: const TextStyle(color: Colors.white54, fontSize: 11)),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => QuizPage(topic: topic)),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              ),
                              child: const Text('Practice', style: TextStyle(fontSize: 11)),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 20),
                  ],
                  if (progress.bestTopic != null) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3FB950).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF3FB950).withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.emoji_events, color: Color(0xFF3FB950), size: 24),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Best Topic', style: TextStyle(color: Color(0xFF3FB950), fontSize: 12, fontWeight: FontWeight.bold)),
                                Text(progress.bestTopic!.displayName,
                                    style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                                Text(
                                    'Accuracy: ${progress.topics[progress.bestTopic!]!.accuracy.toStringAsFixed(0)}%',
                                    style: const TextStyle(color: Colors.white54, fontSize: 11)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                  if (progress.lastStudiedTopic != null) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF181A1B),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Last Studied',
                              style: TextStyle(color: Colors.white54, fontSize: 12)),
                          const SizedBox(height: 4),
                          Text(progress.lastStudiedTopic!.displayName,
                              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                          if (progress.lastOpenedLesson != null)
                            Text(progress.lastOpenedLesson!,
                                style: const TextStyle(color: Colors.white38, fontSize: 12)),
                          if (progress.lastStudyDate != null)
                            Text('On ${progress.lastStudyDate!.toLocal().toString().split(' ')[0]}',
                                style: const TextStyle(color: Colors.white38, fontSize: 11)),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
    );
  }

  Widget _progressChip(String label, bool done) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: done ? const Color(0xFF3FB950).withValues(alpha: 0.2) : Colors.white10,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: done ? const Color(0xFF3FB950) : Colors.white24, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(done ? Icons.check : Icons.circle_outlined,
              color: done ? const Color(0xFF3FB950) : Colors.white38, size: 10),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(color: done ? const Color(0xFF3FB950) : Colors.white38, fontSize: 10)),
        ],
      ),
    );
  }
}
