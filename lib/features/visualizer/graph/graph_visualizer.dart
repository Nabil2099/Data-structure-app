import 'package:flutter/material.dart';
import '../../../core/widgets/common_widgets.dart';
import 'graph_logic.dart' as logic;

class GraphVisualizerScreen extends StatefulWidget {
  const GraphVisualizerScreen({super.key});

  @override
  State<GraphVisualizerScreen> createState() => _GraphVisualizerScreenState();
}

class _GraphVisualizerScreenState extends State<GraphVisualizerScreen> {
  late logic.GraphLogic _graphLogic;
  late logic.GraphVisualizerState _state;
  final TextEditingController _nodeController = TextEditingController();
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _startController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _state = logic.GraphVisualizerState();
    _graphLogic = logic.GraphLogic(
      initialState: _state,
      onStateChanged: (s) {
        if (mounted) setState(() => _state = s);
      },
    );
  }

  @override
  void dispose() {
    _nodeController.dispose();
    _fromController.dispose();
    _toController.dispose();
    _startController.dispose();
    super.dispose();
  }

  void _showAddNodeDialog() {
    _nodeController.clear();
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF181A1B),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom, left: 20, right: 20, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Add Node', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(controller: _nodeController, style: const TextStyle(color: Colors.white), decoration: _dec('Node name (e.g. G)')),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () { final v = _nodeController.text; if (v.trim().isEmpty) return; Navigator.pop(ctx); _graphLogic.addNode(v); }, child: const Text('Add Node'))),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showAddEdgeDialog() {
    _fromController.clear();
    _toController.clear();
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF181A1B),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom, left: 20, right: 20, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Add Edge', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(controller: _fromController, style: const TextStyle(color: Colors.white), decoration: _dec('From node')),
            const SizedBox(height: 12),
            TextField(controller: _toController, style: const TextStyle(color: Colors.white), decoration: _dec('To node')),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () { final f = _fromController.text; final t = _toController.text; if (f.trim().isEmpty || t.trim().isEmpty) return; Navigator.pop(ctx); _graphLogic.addEdge(f, t); }, child: const Text('Add Edge'))),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showBfsDialog() {
    _startController.clear();
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF181A1B),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom, left: 20, right: 20, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('BFS — Choose Start Node', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('BFS explores level by level using Queue', style: TextStyle(color: Colors.white54, fontSize: 12)),
            const SizedBox(height: 16),
            TextField(controller: _startController, style: const TextStyle(color: Colors.white), decoration: _dec('Start node (e.g. A)')),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () { final s = _startController.text; if (s.trim().isEmpty) return; Navigator.pop(ctx); _graphLogic.bfs(s); }, child: const Text('Start BFS'))),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showDfsDialog() {
    _startController.clear();
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF181A1B),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom, left: 20, right: 20, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('DFS — Choose Start Node', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('DFS goes deep first using Stack/Recursion', style: TextStyle(color: Colors.white54, fontSize: 12)),
            const SizedBox(height: 16),
            TextField(controller: _startController, style: const TextStyle(color: Colors.white), decoration: _dec('Start node')),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () { final s = _startController.text; if (s.trim().isEmpty) return; Navigator.pop(ctx); _graphLogic.dfs(s); }, child: const Text('Start DFS'))),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  InputDecoration _dec(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white38),
      filled: true,
      fillColor: const Color(0xFF232323),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.white24)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.white24)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF3FB950), width: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(title: const Text('Graph Visualizer'), backgroundColor: const Color(0xFF0C8159)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Graph', subtitle: 'Nodes connected by edges — BFS/DFS'),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 320,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF181A1B), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white12)),
              child: _state.adjacency.isEmpty
                  ? const EmptyState(message: 'Graph is empty.\nAdd nodes to get started.', icon: Icons.hub)
                  : InteractiveViewer(
                      minScale: 0.5,
                      maxScale: 2.5,
                      child: CustomPaint(
                        painter: _GraphPainter(
                          adjacency: _state.adjacency,
                          positions: _state.positions,
                          visited: _state.visited,
                          current: _state.currentNode,
                          traversalOrder: _state.traversalOrder,
                        ),
                        child: Container(),
                      ),
                    ),
            ),
            if (_state.traversalOrder.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: const Color(0xFF232323), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Traversal: ${_state.startNode ?? ''} started', style: const TextStyle(color: Colors.white54, fontSize: 11)),
                    const SizedBox(height: 4),
                    Text(_state.traversalOrder.join(' → '), style: const TextStyle(color: Color(0xFF3FB950), fontWeight: FontWeight.bold, fontSize: 14)),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                VisualizerControl(label: 'Add Node', icon: Icons.add_circle, onPressed: _showAddNodeDialog, primary: true),
                VisualizerControl(label: 'Add Edge', icon: Icons.compare_arrows, onPressed: _showAddEdgeDialog),
                VisualizerControl(label: 'BFS', icon: Icons.hub, onPressed: _showBfsDialog),
                VisualizerControl(label: 'DFS', icon: Icons.account_tree, onPressed: _showDfsDialog),
                VisualizerControl(label: 'Reset', icon: Icons.refresh, onPressed: _graphLogic.reset),
                VisualizerControl(label: 'Clear', icon: Icons.clear, onPressed: _graphLogic.clear),
              ],
            ),
            const SizedBox(height: 16),
            ExplanationCard(operation: _state.lastOperation, complexity: _state.complexity, error: _state.errorMessage),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF181A1B), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Graph Algorithms', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  SizedBox(height: 8),
                  Text('• BFS: level by level, uses Queue, shortest path in unweighted\n• DFS: deep first, uses Stack/recursion, topological sort\n• Time: O(V+E) where V vertices, E edges',
                      style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GraphPainter extends CustomPainter {
  final Map<String, List<String>> adjacency;
  final Map<String, logic.Offset> positions;
  final Set<String> visited;
  final String? current;
  final List<String> traversalOrder;

  _GraphPainter({required this.adjacency, required this.positions, required this.visited, this.current, required this.traversalOrder});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final linePaint = Paint()..color = Colors.white24..strokeWidth = 1.5;

    // Draw edges
    adjacency.forEach((from, neighbors) {
      final fromPos = positions[from];
      if (fromPos == null) return;
      final p1 = Offset(fromPos.dx + center.dx, fromPos.dy + center.dy);
      for (var to in neighbors) {
        final toPos = positions[to];
        if (toPos == null) continue;
        final p2 = Offset(toPos.dx + center.dx, toPos.dy + center.dy);
        canvas.drawLine(p1, p2, linePaint);
        // arrow
        final angle = (p2 - p1).direction;
        const arrowSize = 8.0;
        final arrowPaint = Paint()..color = Colors.white24..strokeWidth = 1.5..style = PaintingStyle.stroke;
        final path = Path();
        path.moveTo(p2.dx - 20 * (p2.dx - p1.dx) / (p2 - p1).distance, p2.dy - 20 * (p2.dy - p1.dy) / (p2 - p1).distance);
        path.lineTo(p2.dx - arrowSize * 1.5, p2.dy);
        // simple line, skip detailed arrow for brevity
        canvas.drawLine(p1, p2, linePaint);
      }
    });

    // Draw nodes
    positions.forEach((node, offset) {
      final p = Offset(offset.dx + center.dx, offset.dy + center.dy);
      final isCurrent = node == current;
      final isVisited = visited.contains(node);

      final nodePaint = Paint()
        ..color = isCurrent
            ? Colors.orange
            : isVisited
                ? const Color(0xFF3FB950)
                : const Color(0xFF232323)
        ..style = PaintingStyle.fill;

      final borderPaint = Paint()
        ..color = isCurrent ? Colors.orangeAccent : const Color(0xFF3FB950)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      canvas.drawCircle(p, 20, nodePaint);
      canvas.drawCircle(p, 20, borderPaint);

      final textPainter = TextPainter(
        text: TextSpan(
          text: node,
          style: TextStyle(color: isCurrent || isVisited ? Colors.black : Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, p - Offset(textPainter.width / 2, textPainter.height / 2));
    });
  }

  @override
  bool shouldRepaint(covariant _GraphPainter oldDelegate) {
    return oldDelegate.visited != visited || oldDelegate.current != current || oldDelegate.adjacency != adjacency;
  }
}
