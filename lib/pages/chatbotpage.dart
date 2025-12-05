import 'package:datastructure/hidden/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController _controller = TextEditingController();
  // Static list for persistence across navigation
  static final List<_ChatMessage> _history = [];
  bool _isLoading = false;

  late final GenerativeModel _model;

  final List<String> _suggestions = [
    "Explain Bubble Sort",
    "What is a Stack?",
    "BFS vs DFS",
    "Time Complexity of Quick Sort",
    "How does Binary Search work?",
  ];

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-2.5-pro', // Make sure this matches the correct model ID
      apiKey: apiKey,
    );

    // Add welcome message if history is empty
    if (_history.isEmpty) {
      _history.add(
        _ChatMessage(
          "Hello! I'm your Data Structures & Algorithms assistant. How can I help you today?",
          false,
          DateTime.now(),
        ),
      );
    }
  }

  Future<void> _sendMessage([String? message]) async {
    final text = message ?? _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _history.add(_ChatMessage(text, true, DateTime.now()));
      _isLoading = true;
      _controller.clear();
    });

    try {
      final response = await _model.generateContent([Content.text(text)]);
      final botReply = response.text ?? "Sorry, I couldn't understand that.";
      setState(() {
        _history.add(_ChatMessage(botReply, false, DateTime.now()));
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _history.add(
          _ChatMessage('Error: ${e.toString()}', false, DateTime.now()),
        );
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatBot'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color(0xFF0C8159),
        elevation: 4.5,
        shadowColor: Colors.white38,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              // Add 1 to item count for the suggestions if we are showing them
              itemCount: _history.length + (_history.length <= 1 ? 1 : 0),
              itemBuilder: (context, index) {
                // Show suggestions at the end if history is just the welcome message
                if (_history.length <= 1 && index == _history.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children:
                          _suggestions.map((suggestion) {
                            return ActionChip(
                              label: Text(suggestion),
                              backgroundColor: const Color(0xFF232323),
                              labelStyle: const TextStyle(color: Colors.white),
                              onPressed: () => _sendMessage(suggestion),
                            );
                          }).toList(),
                    ),
                  );
                }

                final msg = _history[index];
                if (msg.isUser) {
                  // User message (no avatar)
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(14),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF16855E),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            msg.text,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            DateFormat('hh:mm a').format(msg.time),
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  // Bot message (with avatar)
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/4712/4712109.png',
                          ),
                          radius: 15,
                          backgroundColor: Color(0xFF0C8159),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.all(14),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF232323),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                msg.text,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                DateFormat('hh:mm a').format(msg.time),
                                style: const TextStyle(
                                  color: Colors.white38,
                                  fontSize: 11,
                                ),
                              ),
                            ],
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(color: Color(0xFF3FB950)),
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
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        hintStyle: const TextStyle(color: Colors.white54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white24,
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white24,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF3FB950),
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send, color: Color(0xFF3FB950)),
                    onPressed: _isLoading ? null : () => _sendMessage(),
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
