import 'package:flutter/material.dart';
import 'package:datastructure/components/descriptioncontainer.dart';
import 'package:datastructure/components/floatingactionbutton.dart';
import '../core/models/topic.dart';
import '../core/services/progress_service.dart';
import '../features/visualizer/graph/graph_visualizer.dart';
import '../features/practice/pages/quiz_page.dart';
import '../core/services/gemini_service.dart';
import '../core/config/api_config.dart';
import 'chatbotpage.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({super.key});

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ProgressService().markIntroductionViewed(DataStructureTopic.graphs);
      ProgressService().markOperationsViewed(DataStructureTopic.graphs);
      ProgressService().markComplexityViewed(DataStructureTopic.graphs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const MyActionButton(),
      appBar: AppBar(
        title: const Text('Graphs', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
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
                    ProgressService().markVisualizerUsed(DataStructureTopic.graphs);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const GraphVisualizerScreen()));
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
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizPage(topic: DataStructureTopic.graphs)));
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
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatBotPage(initialPrompt: 'Explain Graphs, BFS vs DFS. Why BFS uses Queue and DFS uses Stack? Give social network example.')));
            },
            icon: const Icon(Icons.smart_toy, size: 18),
            label: const Text('Ask AI about Graphs'),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF232323), foregroundColor: Colors.white),
          ),
          const SizedBox(height: 16),
          DescriptionCard(
            title: 'Overview',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'A graph consists of nodes (vertices) connected by edges. Graphs model relationships: social networks, maps, internet routing.',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                SizedBox(height: 12),
                Text('Types:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14)),
                SizedBox(height: 6),
                Text('• Undirected: edges bidirectional (friendship)\n• Directed: one-way edges (follow on Twitter)\n• Weighted: edges have cost (distance)\n• Cyclic/Acyclic', style: TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
          DescriptionCard(
            title: 'BFS vs DFS',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('BFS — Breadth First Search:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14)),
                Text('• Level by level using Queue (FIFO)\n• Finds shortest path in unweighted graph\n• Uses: shortest path, level order', style: TextStyle(color: Colors.white70, fontSize: 13)),
                SizedBox(height: 10),
                Text('DFS — Depth First Search:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14)),
                Text('• Goes deep first using Stack/Recursion\n• Backtracks when dead end\n• Uses: topological sort, cycle detection, maze solving', style: TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
          DescriptionCard(
            title: 'Time Complexity',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('• BFS: O(V+E) — visits each vertex and edge once', style: TextStyle(color: Colors.white70)),
                Text('• DFS: O(V+E) — same', style: TextStyle(color: Colors.white70)),
                Text('• Space: O(V) for visited set + queue/stack', style: TextStyle(color: Colors.white70)),
                Text('• Adjacency list is efficient for sparse graphs', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
