import 'package:datastructure/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:datastructure/components/descriptioncontainer.dart';
import 'package:datastructure/components/floatingactionbutton.dart';
import 'package:datastructure/components/visualization/graph_visualizer.dart';

class DFSPage extends StatelessWidget {
  const DFSPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyActionButton(),
      appBar: AppBar(
        title: Text(
          'Depth First Search',
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
              Set<int> visited = {};

              Future<void> dfs(int node) async {
                visited.add(node);
                await onVisit(node);

                if (graph.containsKey(node)) {
                  for (int neighbor in graph[node]!) {
                    if (!visited.contains(neighbor)) {
                      await dfs(neighbor);
                    }
                  }
                }
              }

              await dfs(startNode);
            },
          ),
          const SizedBox(height: 16),
          DescriptionCard(
            title: 'Overview',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Depth-First Search (DFS) is an algorithm for traversing or searching tree or graph data structures. The algorithm starts at the root node (selecting some arbitrary node as the root in the case of a graph) and explores as far as possible along each branch before backtracking.',
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
                  '1. Start by putting any one of the graph\'s vertices on top of a stack.\n'
                  '2. Take the top item of the stack and add it to the visited list.\n'
                  '3. Create a list of that vertex\'s adjacent nodes. Add the ones which aren\'t in the visited list to the top of the stack.\n'
                  '4. Keep repeating steps 2 and 3 until the stack is empty.',
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
                  'void DFS(int v) {\n'
                  '    visited[v] = true;\n'
                  '    cout << v << " ";\n'
                  '\n'
                  '    list<int>::iterator i;\n'
                  '    for (i = adj[v].begin(); i != adj[v].end(); ++i)\n'
                  '        if (!visited[*i])\n'
                  '            DFS(*i);\n'
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
