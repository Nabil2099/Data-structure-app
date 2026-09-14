import 'package:flutter/material.dart';
import '../../../core/widgets/common_widgets.dart';
import 'tree_logic.dart';

class TreeVisualizerScreen extends StatefulWidget {
  const TreeVisualizerScreen({super.key});

  @override
  State<TreeVisualizerScreen> createState() => _TreeVisualizerScreenState();
}

class _TreeVisualizerScreenState extends State<TreeVisualizerScreen> {
  late TreeLogic _logic;
  late TreeVisualizerState _state;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _state = TreeVisualizerState();
    _logic = TreeLogic(
      initialState: _state,
      onStateChanged: (s) {
        if (mounted) setState(() => _state = s);
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showInsertDialog() {
    _controller.clear();
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
            const Text('Insert into BST', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: _dec('Value'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final v = int.tryParse(_controller.text);
                  if (v == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter valid number')));
                    return;
                  }
                  Navigator.pop(ctx);
                  _logic.insert(v);
                },
                child: const Text('Insert'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showSearchDialog() {
    _controller.clear();
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
            const Text('Search in BST', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: _dec('Value to search'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final v = int.tryParse(_controller.text);
                  if (v == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter valid number')));
                    return;
                  }
                  Navigator.pop(ctx);
                  _logic.search(v);
                },
                child: const Text('Search'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog() {
    _controller.clear();
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
            const Text('Delete from BST', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: _dec('Value to delete'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final v = int.tryParse(_controller.text);
                  if (v == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter valid number')));
                    return;
                  }
                  Navigator.pop(ctx);
                  _logic.delete(v);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                child: const Text('Delete'),
              ),
            ),
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
      appBar: AppBar(title: const Text('BST Visualizer'), backgroundColor: const Color(0xFF0C8159)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Binary Search Tree', subtitle: 'Left < Parent < Right — hierarchical'),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 320,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF181A1B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white12),
              ),
              child: _state.root == null
                  ? const EmptyState(message: 'Tree is empty.\nInsert values to build BST.', icon: Icons.account_tree)
                  : InteractiveViewer(
                      minScale: 0.5,
                      maxScale: 2.5,
                      child: CustomPaint(
                        painter: _TreePainter(
                          root: _state.root,
                          highlighted: _state.highlightedValue,
                          visited: _state.visitedOrder.toSet(),
                        ),
                        child: Container(),
                      ),
                    ),
            ),
            if (_state.traversalResult.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF232323),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Visited:', style: TextStyle(color: Colors.white54, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text(
                      _state.traversalResult.join(' → '),
                      style: const TextStyle(color: Color(0xFF3FB950), fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                VisualizerControl(label: 'Insert', icon: Icons.add, onPressed: _showInsertDialog, primary: true),
                VisualizerControl(label: 'Search', icon: Icons.search, onPressed: _showSearchDialog),
                VisualizerControl(label: 'Delete', icon: Icons.delete, onPressed: _showDeleteDialog),
                VisualizerControl(label: 'Inorder', icon: Icons.sort, onPressed: _logic.inorderTraversal),
                VisualizerControl(label: 'Preorder', icon: Icons.arrow_upward, onPressed: _logic.preorderTraversal),
                VisualizerControl(label: 'Postorder', icon: Icons.arrow_downward, onPressed: _logic.postorderTraversal),
                VisualizerControl(label: 'Reset', icon: Icons.refresh, onPressed: _logic.reset),
                VisualizerControl(label: 'Clear', icon: Icons.clear, onPressed: _logic.clear),
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
                  Text('BST Traversals', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  SizedBox(height: 8),
                  Text('• Inorder (L,Root,R): sorted order\n• Preorder (Root,L,R): copy tree\n• Postorder (L,R,Root): delete tree\n• Search: O(log n) avg, O(n) worst',
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

class _TreePainter extends CustomPainter {
  final TreeNode? root;
  final int? highlighted;
  final Set<int> visited;

  _TreePainter({required this.root, this.highlighted, required this.visited});

  @override
  void paint(Canvas canvas, Size size) {
    if (root == null) return;
    final center = Offset(size.width / 2, 40);
    _drawNode(canvas, root!, center, size.width / 4, 60);
  }

  void _drawNode(Canvas canvas, TreeNode node, Offset pos, double xOffset, double yOffset) {
    final isHighlighted = node.value == highlighted;
    final isVisited = visited.contains(node.value);

    // Draw edges to children
    final linePaint = Paint()
      ..color = Colors.white24
      ..strokeWidth = 1.5;

    if (node.left != null) {
      final leftPos = Offset(pos.dx - xOffset, pos.dy + yOffset);
      canvas.drawLine(pos, leftPos, linePaint);
      _drawNode(canvas, node.left!, leftPos, xOffset / 1.8, yOffset);
    }
    if (node.right != null) {
      final rightPos = Offset(pos.dx + xOffset, pos.dy + yOffset);
      canvas.drawLine(pos, rightPos, linePaint);
      _drawNode(canvas, node.right!, rightPos, xOffset / 1.8, yOffset);
    }

    // Draw node circle
    final paint = Paint()
      ..color = isHighlighted
          ? Colors.orange
          : isVisited
              ? const Color(0xFF3FB950)
              : const Color(0xFF232323)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = isHighlighted ? Colors.orangeAccent : const Color(0xFF3FB950)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(pos, 20, paint);
    canvas.drawCircle(pos, 20, borderPaint);

    final textPainter = TextPainter(
      text: TextSpan(
        text: '${node.value}',
        style: TextStyle(
          color: isHighlighted || isVisited ? Colors.black : Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, pos - Offset(textPainter.width / 2, textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant _TreePainter oldDelegate) {
    return oldDelegate.highlighted != highlighted ||
        oldDelegate.visited != visited ||
        oldDelegate.root != root;
  }
}
