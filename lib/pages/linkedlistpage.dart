import 'package:datastructure/components/drawer.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:datastructure/components/descriptioncontainer.dart';
import 'package:datastructure/components/floatingactionbutton.dart';

import 'package:datastructure/components/visualization/linked_list_visualizer.dart';

class LinkedListPage extends StatelessWidget {
  const LinkedListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyActionButton(),
      appBar: AppBar(
        title: Text(
          'Linked List',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 4.5,
        shadowColor: Colors.white38,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const LinkedListVisualizer(),
            const SizedBox(height: 20),
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
                            Text(
                              'A linked list is a linear data structure where each element (node) contains a value and a reference (pointer) to the next node in the sequence. Unlike arrays, linked lists do not require contiguous memory and can grow or shrink dynamically.',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
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
                      title: 'Pros & Cons',
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Pros:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '• Dynamic size (easy to grow/shrink).',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  Text(
                                    '• Efficient insertions/deletions at the beginning or middle (O(1) if node is known).',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  Text(
                                    '• No memory waste due to fixed size.',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Cons:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '• No constant-time random access (O(n) to access by index).',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  Text(
                                    '• Extra memory for pointers.',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  Text(
                                    '• Poor cache locality compared to arrays.',
                                    style: TextStyle(color: Colors.white70),
                                  ),
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
                            '#include <stdlib.h>\n'
                            '\n'
                            'struct Node {\n'
                            '    int data;\n'
                            '    struct Node* next;\n'
                            '};\n'
                            '\n'
                            'int main() {\n'
                            '    struct Node* head = malloc(sizeof(struct Node));\n'
                            '    head->data = 10;\n'
                            '    head->next = malloc(sizeof(struct Node));\n'
                            '    head->next->data = 20;\n'
                            '    head->next->next = NULL;\n'
                            '\n'
                            '    // Traverse\n'
                            '    struct Node* temp = head;\n'
                            '    while (temp != NULL) {\n'
                            '        printf("%d ", temp->data);\n'
                            '        temp = temp->next;\n'
                            '    }\n'
                            '    return 0;\n'
                            '}\n',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              color: Colors.white70,
                              fontSize: 14,
                            ),
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
                            Text(
                              '• Traversal: Visit every node (O(n)).',
                              style: TextStyle(color: Colors.white70),
                            ),
                            Text(
                              '• Insertion/Deletion: O(1) if node is known, O(n) if searching by value/index.',
                              style: TextStyle(color: Colors.white70),
                            ),
                            Text(
                              '• Search: O(n) linear search.',
                              style: TextStyle(color: Colors.white70),
                            ),
                            Text(
                              '• No random access: Must traverse from head.',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
