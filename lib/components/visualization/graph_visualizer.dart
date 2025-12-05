import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class GraphVisualizer extends StatefulWidget {
  final Future<void> Function(
    Map<int, List<int>> graph,
    int startNode,
    Function(int) onVisit,
  )
  traversalFunction;

  const GraphVisualizer({super.key, required this.traversalFunction});

  @override
  State<GraphVisualizer> createState() => _GraphVisualizerState();
}

class _GraphVisualizerState extends State<GraphVisualizer> {
  Map<int, List<int>> _graph = {
    0: [1, 2],
    1: [0, 3, 4],
    2: [0, 5, 6],
    3: [1],
    4: [1],
    5: [2],
    6: [2],
  };

  // Fixed positions for a tree-like structure for better visualization
  final Map<int, Offset> _positions = {
    0: const Offset(0, -100),
    1: const Offset(-80, 0),
    2: const Offset(80, 0),
    3: const Offset(-120, 100),
    4: const Offset(-40, 100),
    5: const Offset(40, 100),
    6: const Offset(120, 100),
  };

  Set<int> _visited = {};
  int? _currentNode;
  bool _isTraversing = false;

  void _reset() {
    setState(() {
      _visited = {};
      _currentNode = null;
      _isTraversing = false;
      _generateRandomGraph();
    });
  }

  void _generateRandomGraph() {
    final random = Random();
    final newGraph = <int, List<int>>{};

    // Initialize empty lists for all nodes
    for (int i = 0; i < 7; i++) {
      newGraph[i] = [];
    }

    // Ensure some connectivity (tree-like backbone)
    // Connect 0 to 1 or 2
    if (random.nextBool()) newGraph[0]!.add(1);
    if (random.nextBool()) newGraph[0]!.add(2);

    // Random connections for other nodes
    for (int i = 0; i < 7; i++) {
      // Try to add 1-3 random edges for each node
      int numEdges = random.nextInt(3) + 1;
      for (int j = 0; j < numEdges; j++) {
        int target = random.nextInt(7);
        if (target != i && !newGraph[i]!.contains(target)) {
          newGraph[i]!.add(target);
          // Undirected graph for simplicity in visualization, though BFS/DFS can be directed.
          // The original was directed (parent -> child) mostly.
          // Let's make it directed but random.
        }
      }
    }
    _graph = newGraph;
  }

  Future<void> _startTraversal() async {
    if (_isTraversing) return;

    setState(() {
      _isTraversing = true;
      _visited = {};
      _currentNode = null;
    });

    await widget.traversalFunction(_graph, 0, (node) async {
      if (!mounted) return;
      setState(() {
        _currentNode = node;
        _visited.add(node);
      });
      await Future.delayed(const Duration(milliseconds: 800));
    });

    if (mounted) {
      setState(() {
        _currentNode = null;
        _isTraversing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomPaint(
            painter: _GraphPainter(
              graph: _graph,
              positions: _positions,
              visited: _visited,
              currentNode: _currentNode,
            ),
            child: Container(),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _isTraversing ? null : _startTraversal,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0C8159),
                foregroundColor: Colors.white,
              ),
              child: const Text('Start Traversal'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: _isTraversing ? null : _reset,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
              ),
              child: const Text('Reset'),
            ),
          ],
        ),
      ],
    );
  }
}

class _GraphPainter extends CustomPainter {
  final Map<int, List<int>> graph;
  final Map<int, Offset> positions;
  final Set<int> visited;
  final int? currentNode;

  _GraphPainter({
    required this.graph,
    required this.positions,
    required this.visited,
    this.currentNode,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint =
        Paint()
          ..color = Colors.white54
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;

    // Draw edges
    graph.forEach((node, neighbors) {
      final p1 = positions[node]! + center;
      for (final neighbor in neighbors) {
        final p2 = positions[neighbor]! + center;
        canvas.drawLine(p1, p2, paint);
      }
    });

    // Draw nodes
    positions.forEach((node, offset) {
      final p = offset + center;
      final isVisited = visited.contains(node);
      final isCurrent = node == currentNode;

      final nodePaint =
          Paint()
            ..color =
                isCurrent
                    ? Colors.orange
                    : (isVisited ? Colors.green : Colors.blue)
            ..style = PaintingStyle.fill;

      canvas.drawCircle(p, 20, nodePaint);

      final textSpan = TextSpan(
        text: node.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        p - Offset(textPainter.width / 2, textPainter.height / 2),
      );
    });
  }

  @override
  bool shouldRepaint(covariant _GraphPainter oldDelegate) {
    return oldDelegate.visited != visited ||
        oldDelegate.currentNode != currentNode;
  }
}
