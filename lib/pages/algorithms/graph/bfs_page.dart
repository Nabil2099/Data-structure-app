import 'dart:collection';
import 'package:datastructure/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:datastructure/components/descriptioncontainer.dart';
import 'package:datastructure/components/floatingactionbutton.dart';
import 'package:datastructure/components/visualization/graph_visualizer.dart';

class BFSPage extends StatelessWidget {
  const BFSPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyActionButton(),
      appBar: AppBar(
        title: Text(
          'Breadth First Search',
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
          GraphVisualizer(
            traversalFunction: (
              Map<int, List<int>> graph,
              int startNode,
              Function(int) onVisit,
            ) async {
              Queue<int> queue = Queue<int>();
              Set<int> visited = {};

              queue.add(startNode);
              visited.add(startNode);

              while (queue.isNotEmpty) {
                int currentNode = queue.removeFirst();
                await onVisit(currentNode);

                if (graph.containsKey(currentNode)) {
                  for (int neighbor in graph[currentNode]!) {
                    if (!visited.contains(neighbor)) {
                      visited.add(neighbor);
                      queue.add(neighbor);
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
                  'Breadth-First Search (BFS) is an algorithm for traversing or searching tree or graph data structures. It starts at the tree root (or some arbitrary node of a graph, sometimes referred to as a \'search key\') and explores all of the neighbor nodes at the present depth prior to moving on to the nodes at the next depth level.',
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
                  '1. Start by putting any one of the graph\'s vertices at the back of a queue.\n'
                  '2. Take the front item of the queue and add it to the visited list.\n'
                  '3. Create a list of that vertex\'s adjacent nodes. Add the ones which aren\'t in the visited list to the back of the queue.\n'
                  '4. Keep repeating steps 2 and 3 until the queue is empty.',
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
                        '• O(V + E)',
                        style: TextStyle(color: Colors.white70),
                      ),
                      Text(
                        '  where V is number of vertices and E is number of edges.',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
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
                    '• O(V)',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
          DescriptionCard(
            title: 'Code Example (C++)',
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                color: const Color(0xFF232323),
                padding: const EdgeInsets.all(12),
                child: const Text(
                  'void BFS(int s) {\n'
                  '    bool *visited = new bool[V];\n'
                  '    for(int i = 0; i < V; i++)\n'
                  '        visited[i] = false;\n'
                  '\n'
                  '    list<int> queue;\n'
                  '    visited[s] = true;\n'
                  '    queue.push_back(s);\n'
                  '\n'
                  '    while(!queue.empty()) {\n'
                  '        s = queue.front();\n'
                  '        cout << s << " ";\n'
                  '        queue.pop_front();\n'
                  '\n'
                  '        for(auto i = adj[s].begin(); i != adj[s].end(); ++i) {\n'
                  '            if(!visited[*i]) {\n'
                  '                visited[*i] = true;\n'
                  '                queue.push_back(*i);\n'
                  '            }\n'
                  '        }\n'
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
