import 'package:flutter/material.dart';
import 'package:datastructure/components/descriptioncontainer.dart';
import 'package:datastructure/components/floatingactionbutton.dart';
import '../core/models/topic.dart';
import '../core/services/progress_service.dart';
import '../features/visualizer/hash_table/hash_table_visualizer.dart';
import '../features/practice/pages/quiz_page.dart';
import '../core/services/gemini_service.dart';
import '../core/config/api_config.dart';
import 'chatbotpage.dart';

class HashTablePage extends StatefulWidget {
  const HashTablePage({super.key});

  @override
  State<HashTablePage> createState() => _HashTablePageState();
}

class _HashTablePageState extends State<HashTablePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ProgressService().markIntroductionViewed(DataStructureTopic.hashTables);
      ProgressService().markOperationsViewed(DataStructureTopic.hashTables);
      ProgressService().markComplexityViewed(DataStructureTopic.hashTables);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const MyActionButton(),
      appBar: AppBar(
        title: const Text('Hash Tables', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
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
                    ProgressService().markVisualizerUsed(DataStructureTopic.hashTables);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const HashTableVisualizerScreen()));
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
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizPage(topic: DataStructureTopic.hashTables)));
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
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatBotPage(initialPrompt: 'Explain Hash Tables with collision example. What is separate chaining? Why average O(1) but worst O(n)?')));
            },
            icon: const Icon(Icons.smart_toy, size: 18),
            label: const Text('Ask AI about Hash Tables'),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF232323), foregroundColor: Colors.white),
          ),
          const SizedBox(height: 16),
          DescriptionCard(
            title: 'Overview',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Hash Table stores key-value pairs using a hash function that maps keys to bucket indexes. Provides O(1) average lookup.',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                SizedBox(height: 12),
                Text('Example:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14)),
                SizedBox(height: 6),
                Text('0 │\n1 │ Alex\n2 │\n3 │ Sara → Mohamed (collision)\n4 │\n5 │', style: TextStyle(color: Colors.white54, fontFamily: 'monospace', fontSize: 13)),
              ],
            ),
          ),
          DescriptionCard(
            title: 'Hash Collisions',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Collision when two keys hash to same bucket.', style: TextStyle(color: Colors.white70, fontSize: 14)),
                SizedBox(height: 8),
                Text('Resolution:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14)),
                Text('• Separate Chaining: store colliding entries as linked list at bucket (simple, educational)\n• Open Addressing: find next empty slot via probing\n• Load factor = n/m, high → more collisions → need resizing', style: TextStyle(color: Colors.white70, fontSize: 13)),
                SizedBox(height: 8),
                Text('Collision detected.\nBoth keys mapped to bucket 3.\nSeparate chaining is being used to store both entries.', style: TextStyle(color: Colors.orange, fontSize: 12, fontStyle: FontStyle.italic)),
              ],
            ),
          ),
          DescriptionCard(
            title: 'Time Complexity',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('• Insert avg: O(1), worst O(n) with many collisions', style: TextStyle(color: Colors.white70)),
                Text('• Search avg: O(1), worst O(n)', style: TextStyle(color: Colors.white70)),
                Text('• Delete avg: O(1), worst O(n)', style: TextStyle(color: Colors.white70)),
                Text('• Good hash function + resizing keeps O(1)', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          DescriptionCard(
            title: 'Real-World Uses',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('• Dictionary, cache, database indexing\n• Symbol table in compilers\n• Sets — check existence O(1)\n• Counting frequencies', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
