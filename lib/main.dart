import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/services/progress_service.dart';
import 'core/services/gemini_service.dart';
import 'core/config/api_config.dart';
import 'features/home/home_dashboard.dart';
import 'features/practice/pages/practice_home.dart';
import 'features/progress/progress_page.dart';
import 'pages/chatbotpage.dart';
import 'components/floatingactionbutton.dart';
import 'pages/arraypage.dart' as array_page;
import 'pages/linkedlistpage.dart' as ll_page;
import 'pages/stackpage.dart' as stack_page;
import 'pages/queuepage.dart' as queue_page;
import 'pages/treepage.dart';
import 'pages/graphpage.dart';
import 'pages/hashtablepage.dart';
import 'pages/algorithms/sorting/insertion_sort_page.dart';
import 'pages/algorithms/sorting/bubble_sort_page.dart';
import 'pages/algorithms/sorting/merge_sort_page.dart';
import 'pages/algorithms/sorting/quick_sort_page.dart';
import 'pages/algorithms/sorting/selection_sort_page.dart';
import 'pages/algorithms/searching/linear_search_page.dart';
import 'pages/algorithms/searching/binary_search_page.dart';
import 'pages/algorithms/graph/bfs_page.dart';
import 'pages/algorithms/graph/dfs_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ProgressService().init();
  if (ApiConfig.isConfigured) {
    GeminiService().initWithKey(ApiConfig.geminiApiKey);
  } else {
    await GeminiService().init();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const AppShell(),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  void _navigateToTab(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeDashboard(onNavigateToTab: _navigateToTab),
      LearnPage(onNavigateToTab: _navigateToTab),
      const PracticeHomePage(),
      const ChatBotPage(),
      const ProgressPage(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _navigateToTab,
        backgroundColor: const Color(0xFF181A1B),
        selectedItemColor: const Color(0xFF3FB950),
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Learn'),
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'Practice'),
          BottomNavigationBarItem(icon: Icon(Icons.smart_toy), label: 'AI Tutor'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Progress'),
        ],
      ),
      floatingActionButton: _currentIndex == 3 ? null : const MyActionButton(),
    );
  }
}

class LearnPage extends StatefulWidget {
  final void Function(int) onNavigateToTab;
  const LearnPage({super.key, required this.onNavigateToTab});

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  bool _showAlgorithms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Learn'),
        backgroundColor: const Color(0xFF0C8159),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => _showAlgorithms = false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !_showAlgorithms ? const Color(0xFF0C8159) : Colors.grey[800],
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Data Structures'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => setState(() => _showAlgorithms = true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _showAlgorithms ? const Color(0xFF0C8159) : Colors.grey[800],
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Algorithms'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _showAlgorithms ? _buildAlgorithmsList() : _buildDataStructuresList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataStructuresList() {
    return ListView(
      children: [
        _topicContainer(
          title: 'Array',
          paragraph: 'Learn about arrays, contiguous memory, O(1) access, and interactive visualizer',
          icon: Icons.data_array,
          topic: 'array',
        ),
        const SizedBox(height: 10),
        _topicContainer(
          title: 'Linked List',
          paragraph: 'Dynamic nodes linked by pointers, O(1) head insertion, visual traversal',
          icon: Icons.link,
          topic: 'linkedlist',
        ),
        const SizedBox(height: 10),
        _topicContainer(
          title: 'Stack',
          paragraph: 'LIFO structure, push/pop O(1), browser back button, undo',
          icon: Icons.layers,
          topic: 'stack',
        ),
        const SizedBox(height: 10),
        _topicContainer(
          title: 'Queue',
          paragraph: 'FIFO structure, enqueue/dequeue, printer jobs, BFS',
          icon: Icons.compare_arrows,
          topic: 'queue',
        ),
        const SizedBox(height: 10),
        _topicContainer(
          title: 'Trees',
          paragraph: 'Hierarchical BST, left < parent < right, inorder gives sorted order',
          icon: Icons.account_tree,
          topic: 'tree',
        ),
        const SizedBox(height: 10),
        _topicContainer(
          title: 'Graphs',
          paragraph: 'Nodes and edges, BFS level order with queue, DFS deep with stack',
          icon: Icons.hub,
          topic: 'graph',
        ),
        const SizedBox(height: 10),
        _topicContainer(
          title: 'Hash Tables',
          paragraph: 'Key-value O(1) avg, collisions with separate chaining demo',
          icon: Icons.table_chart,
          topic: 'hashtable',
        ),
      ],
    );
  }

  Widget _buildAlgorithmsList() {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text('Sorting', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        _algoContainer(
          title: 'Insertion Sort',
          paragraph: 'Simple sorting algorithm that builds the final sorted array one item at a time.',
          icon: Icons.sort,
          page: 'insertion',
        ),
        const SizedBox(height: 10),
        _algoContainer(
          title: 'Bubble Sort',
          paragraph: 'Repeatedly steps through the list, compares adjacent elements and swaps them.',
          icon: Icons.bubble_chart,
          page: 'bubble',
        ),
        const SizedBox(height: 10),
        _algoContainer(
          title: 'Merge Sort',
          paragraph: 'Divide and conquer algorithm that divides the input array into two halves.',
          icon: Icons.call_merge,
          page: 'merge',
        ),
        const SizedBox(height: 10),
        _algoContainer(
          title: 'Quick Sort',
          paragraph: 'Divide and conquer algorithm that picks an element as pivot and partitions the array.',
          icon: Icons.speed,
          page: 'quick',
        ),
        const SizedBox(height: 10),
        _algoContainer(
          title: 'Selection Sort',
          paragraph: 'In-place comparison sort that divides list into sorted and unsorted parts.',
          icon: Icons.select_all,
          page: 'selection',
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text('Searching', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        _algoContainer(
          title: 'Linear Search',
          paragraph: 'Sequentially checks each element of the list until a match is found.',
          icon: Icons.search,
          page: 'linear',
        ),
        const SizedBox(height: 10),
        _algoContainer(
          title: 'Binary Search',
          paragraph: 'Search a sorted array by repeatedly dividing the search interval in half.',
          icon: Icons.find_in_page,
          page: 'binary',
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text('Graph', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        _algoContainer(
          title: 'BFS',
          paragraph: 'Explores all neighbor nodes at the present depth prior to moving on to the nodes at the next depth level.',
          icon: Icons.hub,
          page: 'bfs',
        ),
        const SizedBox(height: 10),
        _algoContainer(
          title: 'DFS',
          paragraph: 'Explores as far as possible along each branch before backtracking.',
          icon: Icons.account_tree,
          page: 'dfs',
        ),
      ],
    );
  }

  Widget _algoContainer({required String title, required String paragraph, required IconData icon, required String page}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF181A1B),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 28),
              const SizedBox(width: 10),
              Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
          const SizedBox(height: 10),
          Text(paragraph, style: const TextStyle(fontSize: 14, color: Colors.white70)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.read_more, color: Color(0xFF3FB950)),
              TextButton(
                onPressed: () => _navigateToAlgo(page),
                child: const Text('Learn More', style: TextStyle(fontSize: 14, color: Color(0xFF3FB950))),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToAlgo(String page) {
    Widget target;
    switch (page) {
      case 'insertion':
        target = const InsertionSortPage();
        break;
      case 'bubble':
        target = const BubbleSortPage();
        break;
      case 'merge':
        target = const MergeSortPage();
        break;
      case 'quick':
        target = const QuickSortPage();
        break;
      case 'selection':
        target = const SelectionSortPage();
        break;
      case 'linear':
        target = const LinearSearchPage();
        break;
      case 'binary':
        target = const BinarySearchPage();
        break;
      case 'bfs':
        target = const BFSPage();
        break;
      case 'dfs':
        target = const DFSPage();
        break;
      default:
        return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (_) => target));
  }

  Widget _topicContainer({
    required String title,
    required String paragraph,
    required IconData icon,
    required String topic,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF181A1B),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 28),
              const SizedBox(width: 10),
              Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
          const SizedBox(height: 10),
          Text(paragraph, style: const TextStyle(fontSize: 14, color: Colors.white70)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.read_more, color: Color(0xFF3FB950)),
              TextButton(
                onPressed: () => _navigateToTopic(topic),
                child: const Text('Learn More', style: TextStyle(fontSize: 14, color: Color(0xFF3FB950))),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToTopic(String topic) {
    Widget page;
    switch (topic) {
      case 'array':
        page = const array_page.Arraypage();
        break;
      case 'linkedlist':
        page = const ll_page.LinkedListPage();
        break;
      case 'stack':
        page = const stack_page.StackPage();
        break;
      case 'queue':
        page = const queue_page.QueuePage();
        break;
      case 'tree':
        page = const TreePage();
        break;
      case 'graph':
        page = const GraphPage();
        break;
      case 'hashtable':
        page = const HashTablePage();
        break;
      default:
        return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }
}
