import 'package:flutter/material.dart';
import '../../../core/widgets/common_widgets.dart';
import '../models/quiz_models.dart';

class ReviewPage extends StatelessWidget {
  final QuizSession session;
  const ReviewPage({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Review Answers'),
        backgroundColor: const Color(0xFF0C8159),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: session.questions.length,
        itemBuilder: (ctx, index) {
          final q = session.questions[index];
          final selected = session.answers[q.id];
          final isCorrect = selected == q.correctAnswerIndex;

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF181A1B),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isCorrect ? const Color(0xFF3FB950).withValues(alpha: 0.3) : Colors.redAccent.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isCorrect ? const Color(0xFF3FB950).withValues(alpha: 0.15) : Colors.redAccent.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(isCorrect ? Icons.check : Icons.close,
                              color: isCorrect ? const Color(0xFF3FB950) : Colors.redAccent, size: 14),
                          const SizedBox(width: 4),
                          Text(isCorrect ? 'Correct' : 'Incorrect',
                              style: TextStyle(
                                  color: isCorrect ? const Color(0xFF3FB950) : Colors.redAccent,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text('Q${index + 1}/${session.questions.length}',
                        style: const TextStyle(color: Colors.white38, fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 12),
                Text(q.question, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                if (q.codeSnippet != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: const Color(0xFF232323), borderRadius: BorderRadius.circular(8)),
                    child: Text(q.codeSnippet!,
                        style: const TextStyle(color: Colors.white70, fontFamily: 'monospace', fontSize: 12)),
                  ),
                ],
                const SizedBox(height: 12),
                ...List.generate(q.options.length, (i) {
                  final isSelected = selected == i;
                  final isCorrectOption = i == q.correctAnswerIndex;
                  Color borderColor = Colors.white12;
                  Color bg = const Color(0xFF232323);
                  if (isCorrectOption) {
                    borderColor = const Color(0xFF3FB950);
                    bg = const Color(0xFF3FB950).withValues(alpha: 0.15);
                  } else if (isSelected) {
                    borderColor = Colors.redAccent;
                    bg = Colors.redAccent.withValues(alpha: 0.15);
                  }
                  return Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8), border: Border.all(color: borderColor)),
                    child: Row(
                      children: [
                        Text(String.fromCharCode(65 + i), style: const TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        Expanded(child: Text(q.options[i], style: const TextStyle(color: Colors.white, fontSize: 13))),
                        if (isCorrectOption) const Icon(Icons.check_circle, color: Color(0xFF3FB950), size: 16),
                        if (isSelected && !isCorrectOption) const Icon(Icons.cancel, color: Colors.redAccent, size: 16),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: const Color(0xFF232323), borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Explanation', style: TextStyle(color: Color(0xFF3FB950), fontSize: 12, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(q.explanation, style: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.4)),
                      if (q.complexityExplanation != null) ...[
                        const SizedBox(height: 8),
                        ComplexityBadge(complexity: q.complexityExplanation!),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text('Your answer: ', style: const TextStyle(color: Colors.white38, fontSize: 11)),
                    Text(selected != null ? q.options[selected] : 'Not answered',
                        style: TextStyle(color: isCorrect ? const Color(0xFF3FB950) : Colors.redAccent, fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
