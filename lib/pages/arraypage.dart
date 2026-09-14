import 'package:flutter/material.dart';
import 'package:datastructure/components/descriptioncontainer.dart';
import 'package:datastructure/components/floatingactionbutton.dart';
import '../core/models/topic.dart';
import '../core/services/progress_service.dart';
import '../features/visualizer/array/array_visualizer.dart';
import '../features/practice/pages/quiz_page.dart';
import '../core/services/gemini_service.dart';
import '../core/config/api_config.dart';
import 'chatbotpage.dart';

class Arraypage extends StatefulWidget {
  const Arraypage({super.key});

  @override
  State<Arraypage> createState() => _ArraypageState();
}

class _ArraypageState extends State<Arraypage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ProgressService().markIntroductionViewed(DataStructureTopic.arrays);
      ProgressService().markOperationsViewed(DataStructureTopic.arrays);
      ProgressService().markComplexityViewed(DataStructureTopic.arrays);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const MyActionButton(),
      appBar: AppBar(
        title: const Text('Array', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        elevation: 4.5,
        shadowColor: Colors.white38,
        backgroundColor: const Color(0xFF0C8159),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Action buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ProgressService().markVisualizerUsed(DataStructureTopic.arrays);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ArrayVisualizerScreen()));
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
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizPage(topic: DataStructureTopic.arrays)));
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
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatBotPage(initialPrompt: 'Explain Arrays using a simple example. Cover O(1) access and O(n) insert.')));
            },
            icon: const Icon(Icons.smart_toy, size: 18),
            label: const Text('Ask AI about Arrays'),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF232323), foregroundColor: Colors.white),
          ),
          const SizedBox(height: 16),
          DescriptionCard(
            title: 'Overview',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'An array is a contiguous block of memory that stores elements of the same type. Every element can be accessed in O(1) time using its index.',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 12),
                const Text('Example Uses', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)),
                const SizedBox(height: 6),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• Lookup tables — rapid random access.', style: TextStyle(color: Colors.white70)),
                      Text('• Matrices / images — 2-D arrays.', style: TextStyle(color: Colors.white70)),
                      Text('• Buffers in low-level I/O.', style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          DescriptionCard(
            title: 'Pros & Cons',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Pros', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• Constant-time random access.', style: TextStyle(color: Colors.white70)),
                      Text('• Memory locality → excellent cache performance.', style: TextStyle(color: Colors.white70)),
                      Text('• Low overhead compared with linked data structures.', style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Cons', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• Fixed size (in most languages).', style: TextStyle(color: Colors.white70)),
                      Text('• Insert/delete in the middle is O(n).', style: TextStyle(color: Colors.white70)),
                      Text('• Costly resizing if capacity exceeded.', style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          DescriptionCard(
            title: 'Code Example (C)',
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                color: const Color(0xFF232323),
                padding: const EdgeInsets.all(12),
                child: const Text(
                  '#include <iostream>\n\nint main() {\n    int nums[5] = {10, 20, 30, 40, 50};\n    // Random access\n    printf("%d\\n", nums[2]); // 30\n    // Update\n    nums[1] = 25;\n    // Traverse\n    int i;\n    for (i = 0; i < 5; i++) {\n        printf("%d ", nums[i]);\n    }\n    return 0;\n}\n',
                  style: TextStyle(fontFamily: 'monospace', color: Colors.white70, fontSize: 14),
                ),
              ),
            ),
          ),
          DescriptionCard(
            title: 'Common Operations',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('• Traversal: visit every element (O(n)).', style: TextStyle(color: Colors.white70)),
                Text('• Search: linear O(n) or binary (O(log n)) if sorted.', style: TextStyle(color: Colors.white70)),
                Text('• Insertion/Deletion: shift elements → O(n).', style: TextStyle(color: Colors.white70)),
                Text('• Resizing: allocate new bigger array, copy data.', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          DescriptionCard(
            title: 'Time Complexity',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('• Access: O(1)', style: TextStyle(color: Colors.white70)),
                Text('• Search: O(n) linear, O(log n) binary if sorted', style: TextStyle(color: Colors.white70)),
                Text('• Insert/Delete at end: O(1) amortized', style: TextStyle(color: Colors.white70)),
                Text('• Insert/Delete middle: O(n)', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
