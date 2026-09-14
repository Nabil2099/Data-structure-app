import 'package:flutter/material.dart';
import '../../../core/models/topic.dart';
import '../../../core/widgets/common_widgets.dart';
import '../models/quiz_models.dart';
import 'quiz_page.dart';
import 'review_page.dart';
import '../../../core/services/gemini_service.dart';
import '../../../core/config/api_config.dart';
import '../../../pages/chatbotpage.dart';

class QuizResultPage extends StatelessWidget {
  final QuizSession session;
  const QuizResultPage({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final correct = session.correctCount;
    final total = session.totalQuestions;
    final accuracy = session.accuracy;
    final score = session.score;

    // Determine strong/weak areas based on question types
    final Map<QuizQuestionType, int> typeCorrect = {};
    final Map<QuizQuestionType, int> typeTotal = {};
    for (var q in session.questions) {
      typeTotal[q.type] = (typeTotal[q.type] ?? 0) + 1;
      if (session.answers[q.id] == q.correctAnswerIndex) {
        typeCorrect[q.type] = (typeCorrect[q.type] ?? 0) + 1;
      }
    }

    final strongAreas = <String>[];
    final needsPractice = <String>[];
    typeTotal.forEach((type, totalCount) {
      final corr = typeCorrect[type] ?? 0;
      final acc = totalCount == 0 ? 0 : (corr / totalCount * 100);
      if (acc >= 70) {
        strongAreas.add('${type.displayName} (${acc.toStringAsFixed(0)}%)');
      } else {
        needsPractice.add('${type.displayName} (${acc.toStringAsFixed(0)}%)');
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Quiz Results'),
        backgroundColor: const Color(0xFF0C8159),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF181A1B),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                children: [
                  Text('Quiz Complete 🎉',
                      style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(session.topic.displayName,
                      style: const TextStyle(color: Colors.white54, fontSize: 14)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text('$correct / $total',
                              style: const TextStyle(color: Color(0xFF3FB950), fontSize: 28, fontWeight: FontWeight.bold)),
                          const Text('Score', style: TextStyle(color: Colors.white54, fontSize: 12)),
                        ],
                      ),
                      Container(width: 1, height: 40, color: Colors.white12),
                      Column(
                        children: [
                          Text('${accuracy.toStringAsFixed(0)}%',
                              style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                          const Text('Accuracy', style: TextStyle(color: Colors.white54, fontSize: 12)),
                        ],
                      ),
                      Container(width: 1, height: 40, color: Colors.white12),
                      Column(
                        children: [
                          Text('$score',
                              style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                          const Text('Points', style: TextStyle(color: Colors.white54, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  LinearProgressIndicator(
                    value: accuracy / 100,
                    backgroundColor: Colors.white10,
                    valueColor: AlwaysStoppedAnimation(
                      accuracy >= 70 ? const Color(0xFF3FB950) : Colors.orange,
                    ),
                    minHeight: 8,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    accuracy >= 80
                        ? 'Excellent work! 🌟'
                        : accuracy >= 60
                            ? 'Good job! Keep practicing 💪'
                            : 'Keep learning — you got this! 📚',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (strongAreas.isNotEmpty) ...[
              const SectionHeader(title: 'Strong Areas', subtitle: 'You nailed these!'),
              const SizedBox(height: 8),
              ...strongAreas.map((s) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle, color: Color(0xFF3FB950), size: 16),
                        const SizedBox(width: 8),
                        Text(s, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                  )),
              const SizedBox(height: 16),
            ],
            if (needsPractice.isNotEmpty) ...[
              const SectionHeader(title: 'Needs Practice', subtitle: 'Focus on these topics'),
              const SizedBox(height: 8),
              ...needsPractice.map((s) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        const Icon(Icons.warning_amber, color: Colors.orange, size: 16),
                        const SizedBox(width: 8),
                        Text(s, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                  )),
              const SizedBox(height: 16),
            ],
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ReviewPage(session: session)),
                      );
                    },
                    icon: const Icon(Icons.rate_review),
                    label: const Text('Review Answers'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF232323),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => QuizPage(topic: session.topic, difficulty: session.difficulty),
                        ),
                      );
                    },
                    icon: const Icon(Icons.replay),
                    label: const Text('Practice Again'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3FB950),
                      foregroundColor: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      final weak = needsPractice.isEmpty ? 'overall' : needsPractice.join(', ');
                      final prompt = '''
Help me understand ${session.topic.displayName}. This is one of my weak topics.
Quiz accuracy: ${accuracy.toStringAsFixed(0)}%
Weak areas: $weak
Score: $correct/$total

Explain the concepts I struggled with in simple terms with examples.
''';
                      if (ApiConfig.isConfigured) {
                        GeminiService().initWithKey(ApiConfig.geminiApiKey);
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ChatBotPage(initialPrompt: prompt)),
                      );
                    },
                    icon: const Icon(Icons.smart_toy),
                    label: const Text('Ask AI for Help'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF3FB950),
                      side: const BorderSide(color: Color(0xFF3FB950)),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    child: const Text('Back to Home', style: TextStyle(color: Colors.white54)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
