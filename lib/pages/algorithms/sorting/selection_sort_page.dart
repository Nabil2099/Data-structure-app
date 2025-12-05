import 'package:datastructure/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:datastructure/components/descriptioncontainer.dart';
import 'package:datastructure/components/floatingactionbutton.dart';
import 'package:datastructure/components/visualization/sorting_visualizer.dart';

class SelectionSortPage extends StatelessWidget {
  const SelectionSortPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyActionButton(),
      appBar: AppBar(
        title: Text(
          'Selection Sort',
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
              for (int i = 0; i < n - 1; i++) {
                int minIdx = i;
                for (int j = i + 1; j < n; j++) {
                  await onStep(arr, minIdx, j);
                  if (arr[j] < arr[minIdx]) {
                    minIdx = j;
                  }
                }
                int temp = arr[minIdx];
                arr[minIdx] = arr[i];
                arr[i] = temp;
                await onStep(arr, i, minIdx);
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
                  'Selection Sort is a simple sorting algorithm. This sorting algorithm is an in-place comparison-based algorithm in which the list is divided into two parts, the sorted part at the left end and the unsorted part at the right end.',
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
                  '1. Find the minimum element in unsorted array.\n'
                  '2. Swap it with element at beginning.\n'
                  '3. Increment the position of sorted array boundary.',
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
                        '• Best Case: O(n²)',
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
                  'void selectionSort(int arr[], int n) {\n'
                  '    int i, j, min_idx;\n'
                  '    for (i = 0; i < n - 1; i++) {\n'
                  '        min_idx = i;\n'
                  '        for (j = i + 1; j < n; j++)\n'
                  '            if (arr[j] < arr[min_idx])\n'
                  '                min_idx = j;\n'
                  '        swap(&arr[min_idx], &arr[i]);\n'
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
