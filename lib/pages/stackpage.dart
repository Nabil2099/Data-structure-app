import 'package:flutter/material.dart';
import 'package:datastructure/components/descriptioncontainer.dart';
import 'package:datastructure/components/floatingactionbutton.dart';
import '../core/models/topic.dart';
import '../core/services/progress_service.dart';
import '../features/visualizer/stack/stack_visualizer.dart';
import '../features/practice/pages/quiz_page.dart';
import '../core/services/gemini_service.dart';
import '../core/config/api_config.dart';
import 'chatbotpage.dart';

class StackPage extends StatefulWidget {
  const StackPage({super.key});

  @override
  State<StackPage> createState() => _StackPageState();
}

class _StackPageState extends State<StackPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ProgressService().markIntroductionViewed(DataStructureTopic.stacks);
      ProgressService().markOperationsViewed(DataStructureTopic.stacks);
      ProgressService().markComplexityViewed(DataStructureTopic.stacks);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const MyActionButton(),
      appBar: AppBar(
        title: const Text('Stack', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        elevation: 4.5,
        shadowColor: Colors.white38,
        backgroundColor: const Color(0xFF0C8159),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ProgressService().markVisualizerUsed(DataStructureTopic.stacks);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const StackVisualizerScreen()));
                  },
                  icon: const Icon(Icons.play_circle_filled, size: 18),
                  label: const Text('Open Visualizer'),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3FB950), foregroundColor: Colors.black),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizPage(topic: DataStructureTopic.stacks)));
                  },
                  icon: const Icon(Icons.quiz, size: 18),
                  label: const Text('Practice'),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0C8159), foregroundColor: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {
              if (ApiConfig.isConfigured) GeminiService().initWithKey(ApiConfig.geminiApiKey);
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatBotPage(initialPrompt: 'Explain Stacks with LIFO example. Why is Stack suitable for browser Back navigation?')));
            },
            icon: const Icon(Icons.smart_toy, size: 18),
            label: const Text('Ask AI about Stacks'),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF232323), foregroundColor: Colors.white),
          ),
          const SizedBox(height: 16),
          DescriptionCard(
            title: 'Overview',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'A stack is a linear data structure that follows the Last-In-First-Out (LIFO) principle. Elements are added (pushed) and removed (popped) only from the top of the stack.',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text('Real-world: Browser back button, undo, function call stack', style: TextStyle(color: Colors.white54, fontSize: 13)),
              ],
            ),
          ),
          DescriptionCard(
            title: 'Pros & Cons',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Pros:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• Simple and fast operations (push/pop are O(1)).', style: TextStyle(color: Colors.white70)),
                      Text('• Useful for function calls, undo operations, expression evaluation.', style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text('Cons:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• Limited access (only top element accessible).', style: TextStyle(color: Colors.white70)),
                      Text('• Fixed size if implemented with arrays (unless using dynamic structures).', style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          DescriptionCard(
            title: 'Code Example (C)',
            child: Container(
              color: const Color(0xFF232323),
              padding: const EdgeInsets.all(12),
              child: const Text(
                '#include <stdio.h>\n#define MAX 100\n\nint stack[MAX], top = -1;\n\nvoid push(int x) {\n    if (top < MAX - 1)\n        stack[++top] = x;\n}\n\nint pop() {\n    if (top >= 0)\n        return stack[top--];\n    return -1;\n}\n\nint main() {\n    push(10);\n    push(20);\n    printf("%d\\n", pop()); // 20\n    printf("%d\\n", pop()); // 10\n    return 0;\n}\n',
                style: TextStyle(fontFamily: 'monospace', color: Colors.white70, fontSize: 14),
              ),
            ),
          ),
          DescriptionCard(
            title: 'Common Operations',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('• Push: Add element to top (O(1)).', style: TextStyle(color: Colors.white70)),
                Text('• Pop: Remove element from top (O(1)).', style: TextStyle(color: Colors.white70)),
                Text('• Peek/Top: View top element (O(1)).', style: TextStyle(color: Colors.white70)),
                Text('• IsEmpty/IsFull: Check stack status.', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          DescriptionCard(
            title: 'Time Complexity',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('• Push: O(1)', style: TextStyle(color: Colors.white70)),
                Text('• Pop: O(1)', style: TextStyle(color: Colors.white70)),
                Text('• Peek: O(1)', style: TextStyle(color: Colors.white70)),
                Text('• Search: O(n)', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
