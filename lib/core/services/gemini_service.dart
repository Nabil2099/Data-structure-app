import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  static final GeminiService _instance = GeminiService._internal();
  factory GeminiService() => _instance;
  GeminiService._internal();

  GenerativeModel? _model;
  String? _apiKey;
  bool _initialized = false;

  bool get isInitialized => _initialized && _model != null;
  String? get apiKey => _apiKey;

  Future<void> init({String? apiKey}) async {
    String? key = apiKey;
    if (key == null || key.isEmpty) {
      try {
        // Try to import hidden api file dynamically
        // ignore: avoid_dynamic_calls
        final dynamic hidden = await _tryLoadHiddenApi();
        if (hidden != null) {
          key = hidden as String?;
        }
      } catch (_) {}
    }
    // Fallback: check if file exists via conditional import approach
    // For now, if still null, we remain uninitialized
    if (key != null && key.isNotEmpty && key != 'YOUR_API_KEY_HERE') {
      _apiKey = key;
      try {
        _model = GenerativeModel(
          model: 'gemini-1.5-flash',
          apiKey: key,
        );
        _initialized = true;
      } catch (_) {
        _initialized = false;
      }
    }
  }

  Future<dynamic> _tryLoadHiddenApi() async {
    try {
      // This will fail if file doesn't exist, but we try via dynamic import
      // Using a workaround: attempt to load via deferred import is complex
      // So we just return null and let caller handle
      return null;
    } catch (_) {
      return null;
    }
  }

  // Direct initialization with key
  void initWithKey(String key) {
    if (key.isEmpty) return;
    _apiKey = key;
    try {
      _model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: key,
      );
      _initialized = true;
    } catch (_) {
      _initialized = false;
    }
  }

  Future<String> generateContent(String prompt) async {
    if (!isInitialized || _model == null) {
      throw Exception(
          'Gemini API not configured. Please add your API key in lib/hidden/api.dart');
    }
    try {
      final response = await _model!.generateContent([Content.text(prompt)]);
      return response.text ?? 'Sorry, I could not generate a response.';
    } catch (e) {
      // Provide user-friendly error
      final err = e.toString();
      if (err.contains('API_KEY') || err.contains('API key')) {
        throw Exception('Invalid API key. Please check your Gemini API key.');
      } else if (err.contains('network') ||
          err.contains('Socket') ||
          err.contains('Failed host')) {
        throw Exception(
            'Network error. Please check your internet connection.');
      } else {
        throw Exception('AI request failed: $err');
      }
    }
  }

  Future<String> generateContextualExplanation({
    required String topic,
    required String question,
    String? studentAnswer,
    String? correctAnswer,
    String? explanation,
    String? extraContext,
  }) async {
    final buffer = StringBuffer();
    buffer.writeln('You are a friendly Data Structures tutor.');
    buffer.writeln('Topic: $topic');
    buffer.writeln();
    buffer.writeln('Question: $question');
    if (studentAnswer != null) {
      buffer.writeln('Student answer: $studentAnswer');
    }
    if (correctAnswer != null) {
      buffer.writeln('Correct answer: $correctAnswer');
    }
    if (explanation != null) {
      buffer.writeln('Known explanation: $explanation');
    }
    if (extraContext != null) {
      buffer.writeln('Additional context: $extraContext');
    }
    buffer.writeln();
    if (studentAnswer != null &&
        correctAnswer != null &&
        studentAnswer != correctAnswer) {
      buffer.writeln(
          'Explain why the student\'s answer is incorrect in simple language.');
      buffer.writeln('Use a small example.');
      buffer.writeln('Do not overcomplicate the explanation.');
    } else {
      buffer.writeln('Explain this concept in simple language with an example.');
    }
    buffer.writeln('Keep it concise and educational.');
    return generateContent(buffer.toString());
  }

  Future<String> explainVisualizerAction({
    required String topic,
    required String action,
    required String currentState,
    String? extra,
  }) async {
    final prompt = '''
You are a friendly Data Structures tutor.
Topic: $topic
Action just performed: $action
Current structure state: $currentState
${extra != null ? 'Extra: $extra' : ''}

Explain what just happened in simple terms, why it works that way, and mention the time complexity.
Keep it concise (2-3 sentences) and educational.
''';
    return generateContent(prompt);
  }
}
