import 'package:flutter/material.dart';
import '../../core/models/topic.dart';
import '../../core/services/progress_service.dart';
import '../../core/widgets/common_widgets.dart';
import '../practice/pages/quiz_page.dart';
import '../../pages/arraypage.dart';
import '../../pages/linkedlistpage.dart';
import '../../pages/stackpage.dart';
import '../../pages/queuepage.dart';
import '../../pages/treepage.dart';
import '../../pages/graphpage.dart';
import '../../pages/hashtablepage.dart';

class HomeDashboard extends StatefulWidget {
  final void Function(int) onNavigateToTab;
  const HomeDashboard({super.key, required this.onNavigateToTab});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
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

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 18) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    final progress = _service.progress;
    final recommendedTopic = _service.getRecommendedTopic();
    final recommendationReason = _service.getRecommendationReason(recommendedTopic);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Data Structures'),
        backgroundColor: const Color(0xFF0C8159),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${_greeting()} 👋',
                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('Ready to continue your learning journey?',
                style: const TextStyle(color: Colors.white54, fontSize: 13)),
            const SizedBox(height: 20),

            // Continue Learning Card
            if (progress.lastStudiedTopic != null) ...[
              const SectionHeader(title: 'Continue Learning'),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [const Color(0xFF0C8159), const Color(0xFF0C8159).withValues(alpha: 0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(_iconForTopic(progress.lastStudiedTopic!), color: Colors.white, size: 24),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(progress.lastStudiedTopic!.displayName,
                                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                              if (progress.lastOpenedLesson != null)
                                Text(progress.lastOpenedLesson!,
                                    style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress.topics[progress.lastStudiedTopic!]!.completionPercentage / 100,
                        backgroundColor: Colors.white24,
                        valueColor: const AlwaysStoppedAnimation(Colors.white),
                        minHeight: 6,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            '${progress.topics[progress.lastStudiedTopic!]!.completionPercentage.toStringAsFixed(0)}% Complete',
                            style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12)),
                        InkWell(
                          onTap: () => _navigateToTopic(progress.lastStudiedTopic!),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Continue →', style: TextStyle(color: Color(0xFF0C8159), fontWeight: FontWeight.bold, fontSize: 12)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Progress Summary
            const SectionHeader(title: 'Your Progress'),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.6,
              children: [
                ProgressCard(
                  title: 'Topics Started',
                  value: '${progress.topicsStarted} / ${progress.topics.length}',
                  subtitle: '${progress.topicsCompleted} completed',
                  icon: Icons.school,
                ),
                ProgressCard(
                  title: 'Streak',
                  value: '🔥 ${progress.streakDays} Day',
                  subtitle: progress.streakDays > 0 ? 'Keep it up!' : 'Start today!',
                  icon: Icons.local_fire_department,
                  color: Colors.orange,
                ),
                ProgressCard(
                  title: 'Questions',
                  value: '${progress.totalQuestionsAnswered}',
                  subtitle: '${progress.overallAccuracy.toStringAsFixed(0)}% accuracy',
                  icon: Icons.quiz,
                ),
                ProgressCard(
                  title: 'Quizzes',
                  value: '${progress.totalQuizzesCompleted}',
                  subtitle: 'Completed',
                  icon: Icons.emoji_events,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Recommended Next
            const SectionHeader(title: 'Recommended Next'),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF181A1B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF3FB950).withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3FB950).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(_iconForTopic(recommendedTopic), color: const Color(0xFF3FB950), size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(recommendedTopic.displayName,
                            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 2),
                        Text(recommendationReason,
                            style: const TextStyle(color: Colors.white54, fontSize: 12)),
                        const SizedBox(height: 4),
                        Text(recommendedTopic.description,
                            style: const TextStyle(color: Colors.white38, fontSize: 11)),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => _navigateToTopic(recommendedTopic),
                    icon: const Icon(Icons.arrow_forward, color: Color(0xFF3FB950)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Quick Actions
            const SectionHeader(title: 'Quick Actions'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _quickActionCard(
                    icon: Icons.play_circle_filled,
                    label: 'Practice',
                    color: const Color(0xFF3FB950),
                    onTap: () => widget.onNavigateToTab(2),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _quickActionCard(
                    icon: Icons.analytics,
                    label: 'Progress',
                    color: Colors.orange,
                    onTap: () => widget.onNavigateToTab(4),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _quickActionCard(
                    icon: Icons.smart_toy,
                    label: 'AI Tutor',
                    color: Colors.blue,
                    onTap: () => widget.onNavigateToTab(3),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // All Topics
            const SectionHeader(title: 'All Topics', subtitle: 'Explore data structures'),
            const SizedBox(height: 12),
            ...DataStructureTopic.learningOrder.map((topic) {
              final tp = progress.topics[topic]!;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TopicCard(
                  title: topic.displayName,
                  description: topic.description,
                  icon: _iconForTopic(topic),
                  progress: tp.completionPercentage,
                  isBookmarked: progress.bookmarkedTopics.contains(topic),
                  onTap: () => _navigateToTopic(topic),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _quickActionCard(
      {required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF181A1B),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  IconData _iconForTopic(DataStructureTopic topic) {
    switch (topic) {
      case DataStructureTopic.arrays:
        return Icons.data_array;
      case DataStructureTopic.linkedLists:
        return Icons.link;
      case DataStructureTopic.stacks:
        return Icons.layers;
      case DataStructureTopic.queues:
        return Icons.compare_arrows;
      case DataStructureTopic.trees:
        return Icons.account_tree;
      case DataStructureTopic.graphs:
        return Icons.hub;
      case DataStructureTopic.hashTables:
        return Icons.table_chart;
    }
  }

  void _navigateToTopic(DataStructureTopic topic) {
    Widget page;
    switch (topic) {
      case DataStructureTopic.arrays:
        page = const Arraypage();
        break;
      case DataStructureTopic.linkedLists:
        page = const LinkedListPage();
        break;
      case DataStructureTopic.stacks:
        page = const StackPage();
        break;
      case DataStructureTopic.queues:
        page = const QueuePage();
        break;
      case DataStructureTopic.trees:
        page = const TreePage();
        break;
      case DataStructureTopic.graphs:
        page = const GraphPage();
        break;
      case DataStructureTopic.hashTables:
        page = const HashTablePage();
        break;
    }
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }
}
