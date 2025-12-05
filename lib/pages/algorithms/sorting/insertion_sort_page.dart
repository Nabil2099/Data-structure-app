import 'package:datastructure/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:datastructure/components/descriptioncontainer.dart';
import 'package:datastructure/components/floatingactionbutton.dart';
import 'package:datastructure/components/visualization/sorting_visualizer.dart';

class InsertionSortPage extends StatelessWidget {
  const InsertionSortPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyActionButton(),
      appBar: AppBar(
        title: Text(
          'Insertion Sort',
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
          SortingVisualizer(
            sortFunction: (
              List<int> arr,
              Function(List<int>, int, int) onStep,
            ) async {
              int n = arr.length;
              for (int i = 1; i < n; i++) {
                int key = arr[i];
                int j = i - 1;
                while (j >= 0 && arr[j] > key) {
                  arr[j + 1] = arr[j];
                  await onStep(arr, j, j + 1);
                  j = j - 1;
                }
                arr[j + 1] = key;
                await onStep(arr, j + 1, i);
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
                  'Insertion Sort is a simple sorting algorithm that builds the final sorted array one item at a time. It is much less efficient on large lists than more advanced algorithms such as quicksort, heapsort, or merge sort.',
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
                  '1. Iterate from arr[1] to arr[n] over the array.\n'
                  '2. Compare the current element (key) to its predecessor.\n'
                  '3. If the key element is smaller than its predecessor, compare it to the elements before. Move the greater elements one position up to make space for the swapped element.',
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
                        '• Best Case: O(n)',
                        style: TextStyle(color: Colors.white70),
                      ),
                      Text(
                        '• Average Case: O(n²)',
                        style: TextStyle(color: Colors.white70),
                      ),
                      Text(
                        '• Worst Case: O(n²)',
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
                    '• O(1)',
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
                  'void insertionSort(int arr[], int n) {\n'
                  '    int i, key, j;\n'
                  '    for (i = 1; i < n; i++) {\n'
                  '        key = arr[i];\n'
                  '        j = i - 1;\n'
                  '\n'
                  '        /* Move elements of arr[0..i-1], that are\n'
                  '           greater than key, to one position ahead\n'
                  '           of their current position */\n'
                  '        while (j >= 0 && arr[j] > key) {\n'
                  '            arr[j + 1] = arr[j];\n'
                  '            j = j - 1;\n'
                  '        }\n'
                  '        arr[j + 1] = key;\n'
                  '    }\n'
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
