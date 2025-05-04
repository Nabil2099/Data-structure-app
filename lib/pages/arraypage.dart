import 'package:datastructure/components/drawer.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:datastructure/components/descriptioncontainer.dart';
import 'package:datastructure/components/floatingactionbutton.dart';
import 'package:lucide_icons/lucide_icons.dart';
class Arraypage extends StatelessWidget {
  const Arraypage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyActionButton(),
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Array',
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
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
                  '#include <iostream>\n'
                  '\n'
                  'int main() {\n'
                  '    int nums[5] = {10, 20, 30, 40, 50};\n'
                  '    // Random access\n'
                  '    printf("%d\\n", nums[2]); // 30\n'
                  '    // Update\n'
                  '    nums[1] = 25;\n'
                  '    // Traverse\n'
                  '    int i;\n'
                  '    for (i = 0; i < 5; i++) {\n'
                  '        printf("%d ", nums[i]);\n'
                  '    }\n'
                  '    return 0;\n'
                  '}\n',
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
        ],
      ),
    );
  }
}
