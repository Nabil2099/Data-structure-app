import 'package:flutter/material.dart';
import 'package:datastructure/components/descriptioncontainer.dart';
import 'package:datastructure/components/floatingactionbutton.dart';
import '../core/models/topic.dart';
import '../core/services/progress_service.dart';
import '../features/visualizer/tree/tree_visualizer.dart';
import '../features/practice/pages/quiz_page.dart';
import '../core/services/gemini_service.dart';
import '../core/config/api_config.dart';
import 'chatbotpage.dart';

class TreePage extends StatefulWidget {
  const TreePage({super.key});

  @override
  State<TreePage> createState() => _TreePageState();
}

class _TreePageState extends State<TreePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ProgressService().markIntroductionViewed(DataStructureTopic.trees);
      ProgressService().markOperationsViewed(DataStructureTopic.trees);
      ProgressService().markComplexityViewed(DataStructureTopic.trees);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const MyActionButton(),
      appBar: AppBar(
        title: const Text('Trees', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
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
                    ProgressService().markVisualizerUsed(DataStructureTopic.trees);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const TreeVisualizerScreen()));
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
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizPage(topic: DataStructureTopic.trees)));
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
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatBotPage(initialPrompt: 'Explain Binary Search Trees. Why left < parent < right? Explain inorder gives sorted order.')));
            },
            icon: const Icon(Icons.smart_toy, size: 18),
            label: const Text('Ask AI about Trees'),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF232323), foregroundColor: Colors.white),
          ),
          const SizedBox(height: 16),
          DescriptionCard(
            title: 'Overview',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'A tree is a hierarchical data structure with a root node and child nodes. A Binary Search Tree (BST) is a binary tree where left child < parent < right child, enabling efficient search.',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                SizedBox(height: 12),
                Text('Example Structure:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14)),
                SizedBox(height: 6),
                Text('        50\n       /  \\\n     30    70\n    / \\    / \\\n   20 40  60 80', style: TextStyle(color: Colors.white54, fontFamily: 'monospace', fontSize: 13)),
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
                      Text('• Efficient search O(log n) average when balanced.', style: TextStyle(color: Colors.white70)),
                      Text('• Hierarchical representation (file system, DOM).', style: TextStyle(color: Colors.white70)),
                      Text('• Inorder gives sorted order for BST.', style: TextStyle(color: Colors.white70)),
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
                      Text('• Worst O(n) if skewed (like linked list).', style: TextStyle(color: Colors.white70)),
                      Text('• More complex implementation than arrays.', style: TextStyle(color: Colors.white70)),
                      Text('• No random access by index.', style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          DescriptionCard(
            title: 'Traversals',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('• Inorder: Left → Root → Right — sorted order for BST', style: TextStyle(color: Colors.white70)),
                Text('• Preorder: Root → Left → Right — copy tree', style: TextStyle(color: Colors.white70)),
                Text('• Postorder: Left → Right → Root — delete tree', style: TextStyle(color: Colors.white70)),
                Text('• Level order: BFS level by level using queue', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          DescriptionCard(
            title: 'Time Complexity',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('• Search: O(log n) avg, O(n) worst', style: TextStyle(color: Colors.white70)),
                Text('• Insert: O(log n) avg, O(n) worst', style: TextStyle(color: Colors.white70)),
                Text('• Delete: O(log n) avg, O(n) worst', style: TextStyle(color: Colors.white70)),
                Text('• Traversal: O(n) visits each node', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
