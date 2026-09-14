import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('About', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color(0xFF0C8159),
        elevation: 4.5,
        shadowColor: Colors.white38,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: const Color(0xFF181A1B),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 8, offset: const Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.data_object, color: Color(0xFF3FB950), size: 60),
                  SizedBox(height: 18),
                  Text(
                    'Data Structures Learning App V2',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text('Learn → Visualize → Practice → Ask AI → Track Progress',
                      style: TextStyle(fontSize: 12, color: Color(0xFF3FB950), fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  SizedBox(height: 16),
                  Text(
                    'An interactive learning platform for fundamental data structures and algorithms with visualizers, practice mode, and AI tutor.',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                  Text('Author: Mohamed Nabil\nIdea: Ibrahim Adel\nDesign: Ibrahim Tharwat\nV2 Upgrade: Interactive Learning Platform',
                      style: TextStyle(fontSize: 13, color: Color(0xFF3FB950)), textAlign: TextAlign.center),
                  SizedBox(height: 8),
                  Text('Version 2.0', style: TextStyle(fontSize: 12, color: Colors.white38)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: const Color(0xFF181A1B), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white10)),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('V2 Features', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 12),
                  Text('✓ Interactive Visualizers for 7 topics\n✓ Array: Insert, Update, Remove, Search with animations\n✓ Linked List: Head insertion, traversal highlighting\n✓ Stack: Push/Pop/Peek with TOP indicator, LIFO\n✓ Queue: Enqueue/Dequeue with FRONT/REAR, FIFO\n✓ Tree: BST with Insert/Search/Delete and 3 traversals\n✓ Graph: Add nodes/edges, BFS/DFS with animation\n✓ Hash Table: Collision demo with separate chaining\n✓ Practice Mode: 70+ questions, 4 types, 3 difficulties\n✓ Quiz feedback with explanations and Ask AI\n✓ Progress tracking with persistence\n✓ Home Dashboard with Continue Learning\n✓ Study streak and weak topic detection',
                      style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
