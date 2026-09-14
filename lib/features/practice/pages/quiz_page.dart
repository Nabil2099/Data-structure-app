import 'package:flutter/material.dart';
import '../../../core/models/topic.dart';
import '../../../core/services/progress_service.dart';
import '../../../core/models/progress_models.dart';
import '../../../core/widgets/common_widgets.dart';
import '../data/questions_bank.dart';
import '../models/quiz_models.dart';
import 'quiz_result_page.dart';
import '../../../core/services/gemini_service.dart';
import '../../../core/config/api_config.dart';
import '../../../pages/chatbotpage.dart';

class QuizPage extends StatefulWidget {
  final DataStructureTopic topic;
  final QuizDifficulty? difficulty;
  final int questionCount;

  const QuizPage({
    super.key,
    required this.topic,
    this.difficulty,
    this.questionCount = 10,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late List<QuizQuestion> _questions;
  late QuizSession _session;
  int _currentIndex = 0;
  int? _selectedAnswer;
  bool _showFeedback = false;
  bool _isCorrect = false;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  void _loadQuestions() {
    List<QuizQuestion> pool;
    if (widget.difficulty != null) {
      pool = QuestionsBank.getByTopicAndDifficulty(widget.topic, widget.difficulty!);
    } else {
      pool = QuestionsBank.getByTopic(widget.topic);
    }
    if (pool.isEmpty) {
      pool = QuestionsBank.getByTopic(widget.topic);
    }
    pool.shuffle();
    _questions = pool.take(widget.questionCount).toList();
    _session = QuizSession(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      topic: widget.topic,
      difficulty: widget.difficulty,
      questions: _questions,
    );
  }

  QuizQuestion get _currentQuestion => _questions[_currentIndex];

  void _selectAnswer(int index) {
    if (_showFeedback) return;
    setState(() => _selectedAnswer = index);
  }

  void _submitAnswer() {
    if (_selectedAnswer == null) return;
    final isCorrect = _selectedAnswer == _currentQuestion.correctAnswerIndex;
    setState(() {
      _showFeedback = true;
      _isCorrect = isCorrect;
      _session.answers[_currentQuestion.id] = _selectedAnswer!;
    });
  }

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedAnswer = null;
        _showFeedback = false;
        _isCorrect = false;
      });
    } else {
      _finishQuiz();
    }
  }

  void _finishQuiz() async {
    final attempt = QuizAttempt(
      id: _session.id,
      topic: widget.topic,
      difficulty: widget.difficulty ?? QuizDifficulty.beginner,
      score: _session.score,
      totalQuestions: _session.totalQuestions,
      correctAnswers: _session.correctCount,
      date: DateTime.now(),
      questionIds: _questions.map((e) => e.id).toList(),
    );
    await ProgressService().recordQuizAttempt(attempt);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => QuizResultPage(session: _session),
      ),
    );
  }

  Future<void> _askAI() async {
    final question = _currentQuestion;
    final studentAns = _selectedAnswer != null ? question.options[_selectedAnswer!] : 'Not answered';
    final correctAns = question.correctAnswer;

    // Build contextual prompt
    final prompt = '''
The student is learning ${widget.topic.displayName}.

Question:
${question.question}
${question.codeSnippet != null ? '\nCode:\n${question.codeSnippet}' : ''}

Student answer: $studentAns
Correct answer: $correctAns
Explanation: ${question.explanation}

Explain why the student's answer is ${studentAns == correctAns ? 'correct' : 'incorrect'} in simple language.
Use a small example.
Do not overcomplicate.
''';

    // Try to init Gemini
    if (ApiConfig.isConfigured) {
      GeminiService().initWithKey(ApiConfig.geminiApiKey);
    }

    if (!mounted) return;
    // Navigate to chatbot with context
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatBotPage(initialPrompt: prompt),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = _currentQuestion;
    final progress = (_currentIndex + 1) / _questions.length;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text('${widget.topic.displayName} Quiz'),
        backgroundColor: const Color(0xFF0C8159),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white10,
            valueColor: const AlwaysStoppedAnimation(Color(0xFF3FB950)),
            minHeight: 4,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Question ${_currentIndex + 1}/${_questions.length}',
                    style: const TextStyle(color: Colors.white70, fontSize: 13)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _colorForDifficulty(question.difficulty).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _colorForDifficulty(question.difficulty)),
                  ),
                  child: Text(question.difficulty.displayName,
                      style: TextStyle(color: _colorForDifficulty(question.difficulty), fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF181A1B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF232323),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(question.type.displayName,
                            style: const TextStyle(color: Colors.white54, fontSize: 10)),
                      ),
                      const SizedBox(width: 8),
                      Text(question.topic.displayName,
                          style: const TextStyle(color: Colors.white38, fontSize: 11)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(question.question,
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500, height: 1.4)),
                  if (question.codeSnippet != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF232323),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        question.codeSnippet!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontFamily: 'monospace',
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(question.options.length, (i) {
              final isSelected = _selectedAnswer == i;
              bool? isCorrect;
              if (_showFeedback) {
                if (i == question.correctAnswerIndex) {
                  isCorrect = true;
                } else if (isSelected) {
                  isCorrect = false;
                }
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: QuizOptionCard(
                  option: question.options[i],
                  index: i,
                  isSelected: isSelected,
                  isCorrect: isCorrect,
                  onTap: () => _selectAnswer(i),
                  enabled: !_showFeedback,
                ),
              );
            }),
            const SizedBox(height: 16),
            if (_showFeedback) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _isCorrect
                      ? const Color(0xFF3FB950).withValues(alpha: 0.15)
                      : Colors.redAccent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _isCorrect ? const Color(0xFF3FB950) : Colors.redAccent,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(_isCorrect ? Icons.check_circle : Icons.cancel,
                            color: _isCorrect ? const Color(0xFF3FB950) : Colors.redAccent, size: 20),
                        const SizedBox(width: 8),
                        Text(_isCorrect ? '✓ Correct' : '✕ Incorrect',
                            style: TextStyle(
                                color: _isCorrect ? const Color(0xFF3FB950) : Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('Correct answer: ${question.correctAnswer}',
                        style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(question.explanation,
                        style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4)),
                    if (question.complexityExplanation != null) ...[
                      const SizedBox(height: 8),
                      ComplexityBadge(complexity: question.complexityExplanation!),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _askAI,
                  icon: const Icon(Icons.smart_toy, size: 18),
                  label: const Text('Ask AI to Explain'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF3FB950),
                    side: const BorderSide(color: Color(0xFF3FB950)),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedAnswer == null
                    ? null
                    : _showFeedback
                        ? _nextQuestion
                        : _submitAnswer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _showFeedback ? const Color(0xFF0C8159) : const Color(0xFF3FB950),
                  foregroundColor: _showFeedback ? Colors.white : Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(_showFeedback
                    ? (_currentIndex < _questions.length - 1 ? 'Next Question →' : 'Finish Quiz 🎉')
                    : 'Submit Answer'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _colorForDifficulty(QuizDifficulty d) {
    switch (d) {
      case QuizDifficulty.beginner:
        return Colors.green;
      case QuizDifficulty.intermediate:
        return Colors.orange;
      case QuizDifficulty.advanced:
        return Colors.redAccent;
    }
  }
}
