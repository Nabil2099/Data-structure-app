import 'package:flutter/material.dart';
import '../../../core/models/topic.dart';
import '../../../core/widgets/common_widgets.dart';
import '../data/questions_bank.dart';
import 'quiz_page.dart';

class PracticeHomePage extends StatefulWidget {
  const PracticeHomePage({super.key});

  @override
  State<PracticeHomePage> createState() => _PracticeHomePageState();
}

class _PracticeHomePageState extends State<PracticeHomePage> {
  QuizDifficulty? _selectedDifficulty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Practice'),
        backgroundColor: const Color(0xFF0C8159),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              title: 'Practice Mode',
              subtitle: 'Test your knowledge — Learn → Visualize → Practice',
            ),
            const SizedBox(height: 16),
            // Difficulty filter
            const Text('Filter by Difficulty',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                _difficultyChip(null, 'All'),
                _difficultyChip(QuizDifficulty.beginner, 'Beginner'),
                _difficultyChip(QuizDifficulty.intermediate, 'Intermediate'),
                _difficultyChip(QuizDifficulty.advanced, 'Advanced'),
              ],
            ),
            const SizedBox(height: 20),
            // Topics grid
            ...DataStructureTopic.values.map((topic) {
              final questions = _selectedDifficulty == null
                  ? QuestionsBank.getByTopic(topic)
                  : QuestionsBank.getByTopicAndDifficulty(topic, _selectedDifficulty!);
              final beginnerCount = QuestionsBank.getByTopicAndDifficulty(topic, QuizDifficulty.beginner).length;
              final intermediateCount = QuestionsBank.getByTopicAndDifficulty(topic, QuizDifficulty.intermediate).length;
              final advancedCount = QuestionsBank.getByTopicAndDifficulty(topic, QuizDifficulty.advanced).length;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF181A1B),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0C8159).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(_iconForTopic(topic), color: const Color(0xFF3FB950), size: 20),
                        ),
                        title: Text(topic.displayName,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        subtitle: Text('${questions.length} questions • B:$beginnerCount I:$intermediateCount A:$advancedCount',
                            style: const TextStyle(color: Colors.white54, fontSize: 12)),
                        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white38, size: 14),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => QuizPage(topic: topic, difficulty: _selectedDifficulty),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => QuizPage(topic: topic, difficulty: _selectedDifficulty),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.play_arrow, size: 18),
                                label: const Text('Start Quiz'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF3FB950),
                                  foregroundColor: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => QuizPage(topic: topic, difficulty: _selectedDifficulty, questionCount: 5),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.flash_on, size: 18),
                                label: const Text('Quick 5'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  side: const BorderSide(color: Colors.white24),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF181A1B),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Question Types',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  SizedBox(height: 8),
                  Text('• Concept — Test understanding of definitions\n• Predict Result — What will code do?\n• Real-World — When to use which structure?\n• Complexity — Big O analysis',
                      style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _difficultyChip(QuizDifficulty? diff, String label) {
    final selected = _selectedDifficulty == diff;
    return ChoiceChip(
      label: Text(label, style: TextStyle(color: selected ? Colors.black : Colors.white70, fontSize: 12)),
      selected: selected,
      selectedColor: const Color(0xFF3FB950),
      backgroundColor: const Color(0xFF232323),
      onSelected: (v) {
        setState(() => _selectedDifficulty = diff);
      },
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
}
