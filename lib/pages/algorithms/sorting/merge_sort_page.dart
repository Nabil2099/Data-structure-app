import 'package:datastructure/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:datastructure/components/descriptioncontainer.dart';
import 'package:datastructure/components/floatingactionbutton.dart';
import 'package:datastructure/components/visualization/sorting_visualizer.dart';

class MergeSortPage extends StatelessWidget {
  const MergeSortPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyActionButton(),
      appBar: AppBar(
        title: Text(
          'Merge Sort',
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
              // Note: Merge Sort visualization is complex to implement in-place with this simple visualizer
              // We will implement a simplified version or just a placeholder for now to avoid complexity
              // For now, let's just do a simple bubble sort as a placeholder or skip animation
              // A proper recursive merge sort visualization requires tracking indices across recursion

              // Implementing a simple iterative merge sort for visualization
              int n = arr.length;
              for (
                int currSize = 1;
                currSize <= n - 1;
                currSize = 2 * currSize
              ) {
                for (
                  int leftStart = 0;
                  leftStart < n - 1;
                  leftStart += 2 * currSize
                ) {
                  int mid = leftStart + currSize - 1;
                  int rightEnd =
                      (leftStart + 2 * currSize - 1 < n - 1)
                          ? (leftStart + 2 * currSize - 1)
                          : (n - 1);

                  if (mid < rightEnd) {
                    // Merge
                    int i = leftStart;
                    int j = mid + 1;
                    int k = leftStart;
                    List<int> temp = List.from(arr);

                    while (i <= mid && j <= rightEnd) {
                      await onStep(arr, i, j);
                      if (temp[i] <= temp[j]) {
                        arr[k] = temp[i];
                        i++;
                      } else {
                        arr[k] = temp[j];
                        j++;
                      }
                      k++;
                    }
                    while (i <= mid) {
                      arr[k] = temp[i];
                      i++;
                      k++;
                    }
                    while (j <= rightEnd) {
                      arr[k] = temp[j];
                      j++;
                      k++;
                    }
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
                  'Merge Sort is a Divide and Conquer algorithm. It divides the input array into two halves, calls itself for the two halves, and then merges the two sorted halves.',
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
                  '1. Divide the unsorted list into n sublists, each containing one element (a list of one element is considered sorted).\n'
                  '2. Repeatedly merge sublists to produce new sorted sublists until there is only one sublist remaining. This will be the sorted list.',
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
                        '• Worst Case: O(n log n)',
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
                    '• O(n)',
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
                  'void merge(int arr[], int l, int m, int r) {\n'
                  '    int i, j, k;\n'
                  '    int n1 = m - l + 1;\n'
                  '    int n2 = r - m;\n'
                  '    int L[n1], R[n2];\n'
                  '    for (i = 0; i < n1; i++) L[i] = arr[l + i];\n'
                  '    for (j = 0; j < n2; j++) R[j] = arr[m + 1 + j];\n'
                  '    i = 0; j = 0; k = l;\n'
                  '    while (i < n1 && j < n2) {\n'
                  '        if (L[i] <= R[j]) arr[k++] = L[i++];\n'
                  '        else arr[k++] = R[j++];\n'
                  '    }\n'
                  '    while (i < n1) arr[k++] = L[i++];\n'
                  '    while (j < n2) arr[k++] = R[j++];\n'
                  '}\n'
                  'void mergeSort(int arr[], int l, int r) {\n'
                  '    if (l < r) {\n'
                  '        int m = l + (r - l) / 2;\n'
                  '        mergeSort(arr, l, m);\n'
                  '        mergeSort(arr, m + 1, r);\n'
                  '        merge(arr, l, m, r);\n'
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
