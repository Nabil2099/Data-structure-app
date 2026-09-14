import 'package:flutter/material.dart';
import 'package:datastructure/components/descriptioncontainer.dart';
import 'package:datastructure/components/floatingactionbutton.dart';
import '../core/models/topic.dart';
import '../core/services/progress_service.dart';
import '../features/visualizer/queue/queue_visualizer.dart';
import '../features/practice/pages/quiz_page.dart';
import '../core/services/gemini_service.dart';
import '../core/config/api_config.dart';
import 'chatbotpage.dart';

class QueuePage extends StatefulWidget {
  const QueuePage({super.key});

  @override
  State<QueuePage> createState() => _QueuePageState();
}

class _QueuePageState extends State<QueuePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ProgressService().markIntroductionViewed(DataStructureTopic.queues);
      ProgressService().markOperationsViewed(DataStructureTopic.queues);
      ProgressService().markComplexityViewed(DataStructureTopic.queues);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const MyActionButton(),
      appBar: AppBar(
        title: const Text('Queue', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
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
                    ProgressService().markVisualizerUsed(DataStructureTopic.queues);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const QueueVisualizerScreen()));
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
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizPage(topic: DataStructureTopic.queues)));
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
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatBotPage(initialPrompt: 'Explain Queues with FIFO example. Why is Queue used for printer jobs and BFS?')));
            },
            icon: const Icon(Icons.smart_toy, size: 18),
            label: const Text('Ask AI about Queues'),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF232323), foregroundColor: Colors.white),
          ),
          const SizedBox(height: 16),
          DescriptionCard(
            title: 'Overview',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'A queue is a linear data structure that follows the First-In-First-Out (FIFO) principle. Elements are added (enqueued) at the rear and removed (dequeued) from the front.',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text('Real-world: Printer scheduling, task queues, BFS', style: TextStyle(color: Colors.white54, fontSize: 13)),
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
                      Text('• Fair ordering — FIFO ensures first come first served.', style: TextStyle(color: Colors.white70)),
                      Text('• Fast O(1) enqueue/dequeue with proper implementation.', style: TextStyle(color: Colors.white70)),
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
                      Text('• Limited access (only front/rear).', style: TextStyle(color: Colors.white70)),
                      Text('• Array implementation has O(n) dequeue if not circular.', style: TextStyle(color: Colors.white70)),
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
                '#include <stdio.h>\n#define MAX 100\n\nint queue[MAX], front = -1, rear = -1;\n\nvoid enqueue(int x) {\n    if (rear < MAX-1) {\n        if (front==-1) front=0;\n        queue[++rear]=x;\n    }\n}\nint dequeue() {\n    if (front==-1 || front>rear) return -1;\n    return queue[front++];\n}\n',
                style: TextStyle(fontFamily: 'monospace', color: Colors.white70, fontSize: 14),
              ),
            ),
          ),
          DescriptionCard(
            title: 'Common Operations',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('• Enqueue: Add at rear (O(1)).', style: TextStyle(color: Colors.white70)),
                Text('• Dequeue: Remove from front (O(1)).', style: TextStyle(color: Colors.white70)),
                Text('• Front/Peek: View front element.', style: TextStyle(color: Colors.white70)),
                Text('• IsEmpty/IsFull checks.', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          DescriptionCard(
            title: 'Time Complexity',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('• Enqueue: O(1)', style: TextStyle(color: Colors.white70)),
                Text('• Dequeue: O(1) with linked list/circular', style: TextStyle(color: Colors.white70)),
                Text('• Peek: O(1)', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
