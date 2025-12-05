import 'package:datastructure/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:datastructure/components/descriptioncontainer.dart';
import 'package:datastructure/components/floatingactionbutton.dart';
import 'package:datastructure/components/visualization/searching_visualizer.dart';

class BinarySearchPage extends StatelessWidget {
  const BinarySearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyActionButton(),
      appBar: AppBar(
        title: Text(
          'Binary Search',
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SearchingVisualizer(
            requiresSortedArray: true,
            searchFunction: (
              List<int> arr,
              int target,
              Function(int) onStep,
              Function(int) onFound,
            ) async {
              int l = 0;
              int r = arr.length - 1;
              while (l <= r) {
                int m = l + (r - l) ~/ 2;
                await onStep(m);

                if (arr[m] == target) {
                  await onFound(m);
                  return;
                }

                if (arr[m] < target) {
                  l = m + 1;
                } else {
                  r = m - 1;
                }
              }
            },
          ),
          const SizedBox(height: 16),
          DescriptionCard(
            title: 'Overview',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Binary Search is a search algorithm that finds the position of a target value within a sorted array. Binary search compares the target value to the middle element of the array.',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 12),
                const Text(
                  'How it works',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  '1. Compare x with the middle element.\n'
                  '2. If x matches with the middle element, we return the mid index.\n'
                  '3. Else If x is greater than the mid element, then x can only lie in the right half subarray after the mid element. So we recur for the right half.\n'
                  '4. Else (x is smaller) recur for the left half.',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          DescriptionCard(
            title: 'Complexity',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Time Complexity',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '• Best Case: O(1)',
                        style: TextStyle(color: Colors.white70),
                      ),
                      Text(
                        '• Average Case: O(log n)',
                        style: TextStyle(color: Colors.white70),
                      ),
                      Text(
                        '• Worst Case: O(log n)',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Space Complexity',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    '• O(1) (Iterative)',
                    style: TextStyle(color: Colors.white70),
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
                  'int binarySearch(int arr[], int l, int r, int x) {\n'
                  '    while (l <= r) {\n'
                  '        int m = l + (r - l) / 2;\n'
                  '        if (arr[m] == x)\n'
                  '            return m;\n'
                  '        if (arr[m] < x)\n'
                  '            l = m + 1;\n'
                  '        else\n'
                  '            r = m - 1;\n'
                  '    }\n'
                  '    return -1;\n'
                  '}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
