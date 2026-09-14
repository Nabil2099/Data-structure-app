import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../core/services/gemini_service.dart';
import '../core/config/api_config.dart';
import '../core/widgets/common_widgets.dart';

class ChatBotPage extends StatefulWidget {
  final String? initialPrompt;
  const ChatBotPage({super.key, this.initialPrompt});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController _controller = TextEditingController();
  static final List<_ChatMessage> _history = [];
  bool _isLoading = false;
  bool _hasSentInitial = false;

  final List<String> _suggestions = [
    "Explain Bubble Sort",
    "What is a Stack?",
    "BFS vs DFS",
    "Time Complexity of Quick Sort",
    "How does Binary Search work?",
    "Explain Hash Collisions",
    "What is a BST?",
  ];

  @override
  void initState() {
    super.initState();
    _initGemini();
    if (_history.isEmpty) {
      _history.add(
        _ChatMessage(
          "Hello! I'm your Data Structures & Algorithms assistant. How can I help you today?",
          false,
          DateTime.now(),
        ),
      );
    }
    // If initialPrompt provided, send it automatically
    if (widget.initialPrompt != null && widget.initialPrompt!.trim().isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_hasSentInitial) {
          _hasSentInitial = true;
          _sendMessage(widget.initialPrompt);
        }
      });
    }
  }

  Future<void> _initGemini() async {
    try {
      if (ApiConfig.isConfigured) {
        GeminiService().initWithKey(ApiConfig.geminiApiKey);
      } else {
        await GeminiService().init();
      }
    } catch (_) {}
  }

  Future<void> _sendMessage([String? message]) async {
    final text = (message ?? _controller.text).trim();
    if (text.isEmpty) return;
    if (_isLoading) return; // prevent duplicate sends

    setState(() {
      _history.add(_ChatMessage(text, true, DateTime.now()));
      _isLoading = true;
      _controller.clear();
    });

    try {
      if (!GeminiService().isInitialized) {
        if (ApiConfig.isConfigured) {
          GeminiService().initWithKey(ApiConfig.geminiApiKey);
        } else {
          await GeminiService().init();
        }
      }

      if (!GeminiService().isInitialized) {
        throw Exception(
            'Gemini API key not configured. Please add your key in lib/hidden/api.dart\nGet key from https://aistudio.google.com/app/apikey');
      }

      final botReply = await GeminiService().generateContent(text);
      if (!mounted) return;
      setState(() {
        _history.add(_ChatMessage(botReply, false, DateTime.now()));
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _history.add(
          _ChatMessage('Error: ${e.toString()}', false, DateTime.now()),
        );
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('AI Tutor'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color(0xFF0C8159),
        elevation: 4.5,
        shadowColor: Colors.white38,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.white70),
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  backgroundColor: const Color(0xFF181A1B),
                  title: const Text('Clear chat?', style: TextStyle(color: Colors.white)),
                  content: const Text('This will clear chat history.', style: TextStyle(color: Colors.white70)),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                    TextButton(
                      onPressed: () {
                        setState(() => _history.clear());
                        Navigator.pop(ctx);
                      },
                      child: const Text('Clear', style: TextStyle(color: Colors.redAccent)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (!ApiConfig.isConfigured)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.orange.withValues(alpha: 0.15),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber, color: Colors.orange, size: 18),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Gemini API key not configured. Chat will show error until you add key in lib/hidden/api.dart',
                      style: TextStyle(color: Colors.orange, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          if (widget.initialPrompt != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              color: const Color(0xFF181A1B),
              child: Row(
                children: [
                  const Icon(Icons.auto_awesome, color: Color(0xFF3FB950), size: 16),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text('Contextual AI request from learning activity',
                        style: TextStyle(color: Colors.white54, fontSize: 11)),
                  ),
                ],
              ),
            ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _history.length + (_history.length <= 1 ? 1 : 0),
              itemBuilder: (context, index) {
                if (_history.length <= 1 && index == _history.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: _suggestions.map((suggestion) {
                        return ActionChip(
                          label: Text(suggestion),
                          backgroundColor: const Color(0xFF232323),
                          labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
                          onPressed: _isLoading ? null : () => _sendMessage(suggestion),
                        );
                      }).toList(),
                    ),
                  );
                }

                final msg = _history[index];
                if (msg.isUser) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(14),
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                      decoration: BoxDecoration(color: const Color(0xFF16855E), borderRadius: BorderRadius.circular(14)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(msg.text, style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.4)),
                          const SizedBox(height: 4),
                          Text(DateFormat('hh:mm a').format(msg.time), style: const TextStyle(color: Colors.white70, fontSize: 10)),
                        ],
                      ),
                    ),
                  );
                } else {
                  final isError = msg.text.startsWith('Error:');
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 14,
                          backgroundColor: Color(0xFF0C8159),
                          child: Icon(Icons.smart_toy, size: 16, color: Colors.white),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.all(14),
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                            decoration: BoxDecoration(
                              color: isError ? Colors.redAccent.withValues(alpha: 0.15) : const Color(0xFF232323),
                              borderRadius: BorderRadius.circular(14),
                              border: isError ? Border.all(color: Colors.redAccent.withValues(alpha: 0.3)) : null,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText(
                                  msg.text,
                                  style: TextStyle(color: isError ? Colors.redAccent : Colors.white, fontSize: 14, height: 1.4),
                                ),
                                const SizedBox(height: 4),
                                Text(DateFormat('hh:mm a').format(msg.time), style: const TextStyle(color: Colors.white38, fontSize: 10)),
                                if (isError) ...[
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton.icon(
                                      onPressed: _isLoading ? null : () => _sendMessage(_history.length >= 2 ? _history[_history.length - 2].text : null),
                                      icon: const Icon(Icons.refresh, size: 14),
                                      label: const Text('Retry', style: TextStyle(fontSize: 12)),
                                      style: OutlinedButton.styleFrom(foregroundColor: Colors.redAccent, side: const BorderSide(color: Colors.redAccent)),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          if (_isLoading)
            Container(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF3FB950))),
                  const SizedBox(width: 12),
                  const Text('AI is thinking...', style: TextStyle(color: Colors.white54, fontSize: 12)),
                ],
              ),
            ),
          Container(
            color: const Color(0xFF181A1B),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: SafeArea(
              bottom: true,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      enabled: !_isLoading,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Ask about data structures...',
                        hintStyle: const TextStyle(color: Colors.white54, fontSize: 13),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: const BorderSide(color: Colors.white24, width: 1.5)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: const BorderSide(color: Colors.white24, width: 1.5)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: const BorderSide(color: Color(0xFF3FB950), width: 2)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(color: const Color(0xFF3FB950), shape: BoxShape.circle),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.black, size: 20),
                      onPressed: _isLoading ? null : () => _sendMessage(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isUser;
  final DateTime time;
  _ChatMessage(this.text, this.isUser, this.time);
}
