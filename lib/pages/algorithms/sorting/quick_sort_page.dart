import 'package:datastructure/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:datastructure/components/descriptioncontainer.dart';
import 'package:datastructure/components/floatingactionbutton.dart';
import 'package:datastructure/components/visualization/sorting_visualizer.dart';

class QuickSortPage extends StatelessWidget {
  const QuickSortPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyActionButton(),
      appBar: AppBar(
        title: Text(
          'Quick Sort',
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
              // Iterative Quick Sort for visualization
              int l = 0;
              int h = arr.length - 1;
              List<int> stack = List.filled(h - l + 1, 0);
              int top = -1;

              stack[++top] = l;
              stack[++top] = h;

              while (top >= 0) {
                h = stack[top--];
                l = stack[top--];

                // Partition
                int x = arr[h];
                int i = (l - 1);

                for (int j = l; j <= h - 1; j++) {
                  await onStep(arr, j, h);
                  if (arr[j] <= x) {
                    i++;
                    int temp = arr[i];
                    arr[i] = arr[j];
                    arr[j] = temp;
                  }
                }
                int temp = arr[i + 1];
                arr[i + 1] = arr[h];
                arr[h] = temp;
                int p = i + 1;

                if (p - 1 > l) {
                  stack[++top] = l;
                  stack[++top] = p - 1;
                }
                if (p + 1 < h) {
                  stack[++top] = p + 1;
                  stack[++top] = h;
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
                  'Quick Sort is a Divide and Conquer algorithm. It picks an element as pivot and partitions the given array around the picked pivot.',
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
                  '1. Pick a pivot element.\n'
                  '2. Partition the array such that all elements less than pivot are on left, and all elements greater than pivot are on right.\n'
                  '3. Recursively apply the same logic to the sub-arrays.',
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
                        '• Best Case: O(n log n)',
                        style: TextStyle(color: Colors.white70),
                      ),
                      Text(
                        '• Average Case: O(n log n)',
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
                    '• O(log n)',
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
                  'int partition (int arr[], int low, int high) {\n'
                  '    int pivot = arr[high];\n'
                  '    int i = (low - 1);\n'
                  '    for (int j = low; j <= high - 1; j++) {\n'
                  '        if (arr[j] < pivot) {\n'
                  '            i++;\n'
                  '            swap(&arr[i], &arr[j]);\n'
                  '        }\n'
                  '    }\n'
                  '    swap(&arr[i + 1], &arr[high]);\n'
                  '    return (i + 1);\n'
                  '}\n'
                  'void quickSort(int arr[], int low, int high) {\n'
                  '    if (low < high) {\n'
                  '        int pi = partition(arr, low, high);\n'
                  '        quickSort(arr, low, pi - 1);\n'
                  '        quickSort(arr, pi + 1, high);\n'
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
