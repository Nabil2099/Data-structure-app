import '../../hidden/api.dart' as hidden show apiKey;

/// Returns the API key if configured, otherwise placeholder.
/// The hidden/api.dart file is gitignored, so each developer must create it.
class ApiConfig {
  static String get geminiApiKey {
    try {
      return hidden.apiKey;
    } catch (_) {
      return '';
    }
  }

  static bool get isConfigured {
    final key = geminiApiKey;
    return key.isNotEmpty && key != 'YOUR_API_KEY_HERE' && key != 'YOUR_GEMINI_API_KEY_HERE';
  }
}
