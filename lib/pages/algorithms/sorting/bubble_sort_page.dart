import 'package:datastructure/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:datastructure/components/descriptioncontainer.dart';
import 'package:datastructure/components/floatingactionbutton.dart';
import 'package:datastructure/components/visualization/sorting_visualizer.dart';

class BubbleSortPage extends StatelessWidget {
  const BubbleSortPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyActionButton(),
      appBar: AppBar(
        title: Text(
          'Bubble Sort',
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
                for (int j = 0; j < n - i - 1; j++) {
                  if (arr[j] > arr[j + 1]) {
                    int temp = arr[j];
                    arr[j] = arr[j + 1];
                    arr[j + 1] = temp;
                    await onStep(arr, j, j + 1);
                  }
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
                  'Bubble Sort is the simplest sorting algorithm that works by repeatedly swapping the adjacent elements if they are in the wrong order.',
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
                  '1. Traverse from left and compare adjacent elements and the higher one is placed at right side.\n'
                  '2. In this way, the largest element is moved to the rightmost end at first.\n'
                  '3. This process is then continued to find the second largest and place it and so on until the data is sorted.',
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
                  'void bubbleSort(int arr[], int n) {\n'
                  '    int i, j;\n'
                  '    for (i = 0; i < n - 1; i++)\n'
                  '        // Last i elements are already in place\n'
                  '        for (j = 0; j < n - i - 1; j++)\n'
                  '            if (arr[j] > arr[j + 1])\n'
                  '                swap(&arr[j], &arr[j + 1]);\n'
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
