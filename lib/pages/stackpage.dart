import 'package:datastructure/components/drawer.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:datastructure/components/descriptioncontainer.dart';
import 'package:datastructure/components/floatingactionbutton.dart';
import '../pages/visualization/stack_visualization.dart';

class StackPage extends StatelessWidget {
  const StackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyActionButton(),
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Stack',
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
                            Text('A stack is a linear data structure that follows the Last-In-First-Out (LIFO) principle. Elements are added (pushed) and removed (popped) only from the top of the stack.', style: TextStyle(color: Colors.white70, fontSize: 16)),
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
                            'int stack[MAX], top = -1;\n'
                            '\n'
                            'void push(int x) {\n'
                            '    if (top < MAX - 1)\n'
                            '        stack[++top] = x;\n'
                            '}\n'
                            '\n'
                            'int pop() {\n'
                            '    if (top >= 0)\n'
                            '        return stack[top--];\n'
                            '    return -1;\n'
                            '}\n'
                            '\n'
                            'int main() {\n'
                            '    push(10);\n'
                            '    push(20);\n'
                            '    printf("%d\\n", pop()); // 20\n'
                            '    printf("%d\\n", pop()); // 10\n'
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
                            Text('• Push: Add element to top (O(1)).', style: TextStyle(color: Colors.white70)),
                            Text('• Pop: Remove element from top (O(1)).', style: TextStyle(color: Colors.white70)),
                            Text('• Peek/Top: View top element (O(1)).', style: TextStyle(color: Colors.white70)),
                            Text('• IsEmpty/IsFull: Check stack status.', style: TextStyle(color: Colors.white70)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                ],
              ),
            ),
            const StackVisualization(),
          ],
        ),
      ),
    );
  }
} 