import 'package:datastructure/components/drawer.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:datastructure/components/descriptioncontainer.dart';
import 'package:datastructure/components/floatingactionbutton.dart';
import '../pages/visualization/queue_visualization.dart';

class QueuePage extends StatelessWidget {
  const QueuePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyActionButton(),
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Queue',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF0C8159),
        elevation: 4.5,
        shadowColor: Colors.white38,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: DescriptionCard(
                      title: 'Overview',
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('A queue is a linear data structure that follows the First-In-First-Out (FIFO) principle. Elements are added at the rear and removed from the front.', style: TextStyle(color: Colors.white70, fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: DescriptionCard(
                      title: 'Pros & Cons',
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Pros:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)),
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('• Simple and fast operations (enqueue/dequeue are O(1)).', style: TextStyle(color: Colors.white70)),
                                  Text('• Useful for scheduling, buffering, breadth-first search.', style: TextStyle(color: Colors.white70)),
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
                                  Text('• Fixed size if implemented with arrays (unless using dynamic structures).', style: TextStyle(color: Colors.white70)),
                                  Text('• No random access to elements.', style: TextStyle(color: Colors.white70)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: DescriptionCard(
                      title: 'Code Example (C)',
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          color: Color(0xFF232323),
                          padding: EdgeInsets.all(12),
                          child: const Text(
                            '#include <stdio.h>\n'
                            '#define MAX 100\n'
                            '\n'
                            'int queue[MAX], front = 0, rear = -1;\n'
                            '\n'
                            'void enqueue(int x) {\n'
                            '    if (rear < MAX - 1)\n'
                            '        queue[++rear] = x;\n'
                            '}\n'
                            '\n'
                            'int dequeue() {\n'
                            '    if (front <= rear)\n'
                            '        return queue[front++];\n'
                            '    return -1;\n'
                            '}\n'
                            '\n'
                            'int main() {\n'
                            '    enqueue(10);\n'
                            '    enqueue(20);\n'
                            '    printf("%d\\n", dequeue()); // 10\n'
                            '    printf("%d\\n", dequeue()); // 20\n'
                            '    return 0;\n'
                            '}\n',
                            style: TextStyle(fontFamily: 'monospace', color: Colors.white70, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: DescriptionCard(
                      title: 'Common Operations',
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('• Enqueue: Add element to rear (O(1)).', style: TextStyle(color: Colors.white70)),
                            Text('• Dequeue: Remove element from front (O(1)).', style: TextStyle(color: Colors.white70)),
                            Text('• Peek/Front: View front element (O(1)).', style: TextStyle(color: Colors.white70)),
                            Text('• IsEmpty/IsFull: Check queue status.', style: TextStyle(color: Colors.white70)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                ],
              ),
            ),
            const QueueVisualization(),
          ],
        ),
      ),
    );
  }
} 