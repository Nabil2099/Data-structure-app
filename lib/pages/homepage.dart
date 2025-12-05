import 'package:datastructure/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:datastructure/components/container.dart';
import 'package:datastructure/components/floatingactionbutton.dart';
import 'arraypage.dart';
import 'linkedlistpage.dart';
import 'stackpage.dart';
import 'queuepage.dart';
import 'algorithms/sorting/insertion_sort_page.dart';
import 'algorithms/sorting/bubble_sort_page.dart';
import 'algorithms/sorting/merge_sort_page.dart';
import 'algorithms/sorting/quick_sort_page.dart';
import 'algorithms/sorting/selection_sort_page.dart';
import 'algorithms/searching/linear_search_page.dart';
import 'algorithms/searching/binary_search_page.dart';
import 'algorithms/graph/bfs_page.dart';
import 'algorithms/graph/dfs_page.dart';

class Homepage extends StatefulWidget {
  final bool initialShowAlgorithms;
  const Homepage({super.key, this.initialShowAlgorithms = false});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late bool showAlgorithms;

  @override
  void initState() {
    super.initState();
    showAlgorithms = widget.initialShowAlgorithms;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text(
          'Data Structures & Algorithms',
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
      floatingActionButton: MyActionButton(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showAlgorithms = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        !showAlgorithms
                            ? const Color(0xFF0C8159)
                            : Colors.grey[800],
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Data Structures'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showAlgorithms = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        showAlgorithms
                            ? const Color(0xFF0C8159)
                            : Colors.grey[800],
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Algorithms'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child:
                  showAlgorithms
                      ? _buildAlgorithmsList()
                      : _buildDataStructuresList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataStructuresList() {
    return ListView(
      children: [
        MyContainer(
          paragraph:
              'Learn more about arrays one of the most basic examples on data structures',
          title: 'Array',
          icon: Icons.data_array,
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => const Arraypage()));
          },
        ),
        const SizedBox(height: 10),
        MyContainer(
          paragraph: 'Learn more about linked list and how to use it',
          title: 'Linked List',
          icon: Icons.link,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LinkedListPage()),
            );
          },
        ),
        const SizedBox(height: 10),
        MyContainer(
          paragraph: 'Learn more about stack and how to use it',
          title: 'Stack',
          icon: Icons.layers,
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => const StackPage()));
          },
        ),
        const SizedBox(height: 10),
        MyContainer(
          paragraph: 'Learn more about queue and how to use it',
          title: 'Queue',
          icon: Icons.compare_arrows,
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => const QueuePage()));
          },
        ),
      ],
    );
  }

  Widget _buildAlgorithmsList() {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Sorting',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        MyContainer(
          paragraph:
              'Simple sorting algorithm that builds the final sorted array one item at a time.',
          title: 'Insertion Sort',
          icon: Icons.sort,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const InsertionSortPage(),
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        MyContainer(
          paragraph:
              'Repeatedly steps through the list, compares adjacent elements and swaps them.',
          title: 'Bubble Sort',
          icon: Icons.bubble_chart,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const BubbleSortPage()),
            );
          },
        ),
        const SizedBox(height: 10),
        MyContainer(
          paragraph:
              'Divide and conquer algorithm that divides the input array into two halves.',
          title: 'Merge Sort',
          icon: Icons.call_merge,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const MergeSortPage()),
            );
          },
        ),
        const SizedBox(height: 10),
        MyContainer(
          paragraph:
              'Divide and conquer algorithm that picks an element as pivot and partitions the array.',
          title: 'Quick Sort',
          icon: Icons.speed,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const QuickSortPage()),
            );
          },
        ),
        const SizedBox(height: 10),
        MyContainer(
          paragraph:
              'In-place comparison sort that divides list into sorted and unsorted parts.',
          title: 'Selection Sort',
          icon: Icons.select_all,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SelectionSortPage(),
              ),
            );
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Searching',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        MyContainer(
          paragraph:
              'Sequentially checks each element of the list until a match is found.',
          title: 'Linear Search',
          icon: Icons.search,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LinearSearchPage()),
            );
          },
        ),
        const SizedBox(height: 10),
        MyContainer(
          paragraph:
              'Search a sorted array by repeatedly dividing the search interval in half.',
          title: 'Binary Search',
          icon: Icons.find_in_page,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const BinarySearchPage()),
            );
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Graph',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        MyContainer(
          paragraph:
              'Explores all neighbor nodes at the present depth prior to moving on to the nodes at the next depth level.',
          title: 'BFS',
          icon: Icons.hub,
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => const BFSPage()));
          },
        ),
        const SizedBox(height: 10),
        MyContainer(
          paragraph:
              'Explores as far as possible along each branch before backtracking.',
          title: 'DFS',
          icon: Icons.account_tree,
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => const DFSPage()));
          },
        ),
      ],
    );
  }
}
