import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:datastructure/components/drawer.dart';
import 'package:datastructure/components/descriptioncontainer.dart';


class Arraypage extends StatelessWidget {
  const Arraypage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Structure Cards'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Array Card Example - Similar to your reference image
            InfoCard(
              title: 'What Are',
              subtitle: 'Array',
              children: [
                InfoCardSection(
                  title: 'Overview',
                  bulletPoints: [
                    'An array is a contiguous block of memory that stores elements of the same type. Every element can be accessed in O(1) time using its index.'
                  ],
                ),
                const SizedBox(height: 16),
                InfoCardSection(
                  title: 'Example Uses',
                  bulletPoints: [
                    'Lookup tables – rapid random access.',
                    'Matrices / images – 2-D arrays.',
                    'Buffers in low-level I/O.',
                  ],
                ),
                const SizedBox(height: 16),
                ProConSection(
                  pros: [
                    'Constant-time random access.',
                    'Memory locality → excellent cache performance.',
                    'Low overhead compared with linked data structures.',
                  ],
                  cons: [
                    'Fixed size (in most languages).',
                    'Insertions/deletions in the middle is O(n).',
                    'Costly resizing if capacity exceeded.',
                  ],
                ),
                const SizedBox(height: 16),
                InfoCardSection(
                  title: 'Common Operations',
                  bulletPoints: [
                    'Traversal: visit every element (O(n)).',
                    'Search: linear O(n) or binary (O(log n)) if sorted.',
                    'Insertion/Deletion: shift elements → O(n).',
                    'Resizing: allocate new bigger array, copy data.',
                  ],
                ),
                const SizedBox(height: 16),
                CodeSection(
                  language: 'C',
                  code: '''#include <iostream>

int main() {
  int nums[5] = {10, 20, 30, 40, 50};
  
  // Random access
  printf("%d\\n", nums[2]); // 30
  
  // Update
  nums[2] = 25;
  
  // Traverse
  int i;
  for (i = 0; i < 5; i++) {
    printf("%d ", nums[i]);
  }
  
  return 0;
}''',
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}