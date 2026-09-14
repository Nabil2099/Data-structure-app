import 'package:flutter/material.dart';
import '../../../core/widgets/common_widgets.dart';
import 'linked_list_logic.dart';

class LinkedListVisualizerScreen extends StatefulWidget {
  const LinkedListVisualizerScreen({super.key});

  @override
  State<LinkedListVisualizerScreen> createState() => _LinkedListVisualizerScreenState();
}

class _LinkedListVisualizerScreenState extends State<LinkedListVisualizerScreen> {
  late LinkedListLogic _logic;
  late LinkedListVisualizerState _state;
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _indexController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _state = LinkedListVisualizerState();
    _logic = LinkedListLogic(
      initialState: _state,
      onStateChanged: (s) {
        if (mounted) setState(() => _state = s);
      },
    );
  }

  @override
  void dispose() {
    _valueController.dispose();
    _indexController.dispose();
    super.dispose();
  }

  void _showInsertBeginningDialog() {
    _valueController.clear();
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF181A1B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Insert at Beginning',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDec('Value'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final v = int.tryParse(_valueController.text);
                  if (v == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter valid number')));
                    return;
                  }
                  Navigator.pop(ctx);
                  _logic.insertAtBeginning(v);
                },
                child: const Text('Insert at Head'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showInsertEndDialog() {
    _valueController.clear();
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF181A1B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Insert at End',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDec('Value'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final v = int.tryParse(_valueController.text);
                  if (v == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter valid number')));
                    return;
                  }
                  Navigator.pop(ctx);
                  _logic.insertAtEnd(v);
                },
                child: const Text('Insert at Tail'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog() {
    _valueController.clear();
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF181A1B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Delete Value',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDec('Value to delete'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final v = int.tryParse(_valueController.text);
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

  void _showSearchDialog() {
    _valueController.clear();
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF181A1B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Search Value',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDec('Value to search'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final v = int.tryParse(_valueController.text);
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

  InputDecoration _inputDec(String hint) {
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
      appBar: AppBar(title: const Text('Linked List Visualizer'), backgroundColor: const Color(0xFF0C8159)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Linked List', subtitle: 'Nodes linked by pointers — HEAD → ... → null'),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF181A1B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white12),
              ),
              child: _state.nodes.isEmpty
                  ? const EmptyState(message: 'List is empty — HEAD = null\nInsert a value to start.', icon: Icons.link)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('HEAD', style: TextStyle(color: Color(0xFF3FB950), fontWeight: FontWeight.bold, fontSize: 12)),
                        const Icon(Icons.arrow_downward, color: Color(0xFF3FB950), size: 16),
                        const SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(_state.nodes.length, (i) {
                              final isHighlighted = _state.highlightedIndex == i;
                              final isFound = _state.foundIndex == i;
                              final isVisited = _state.visitedIndices.contains(i);
                              Color bg = const Color(0xFF232323);
                              Color border = Colors.white24;
                              if (isFound) {
                                bg = const Color(0xFF3FB950);
                                border = const Color(0xFF3FB950);
                              } else if (isHighlighted) {
                                bg = Colors.orange.withValues(alpha: 0.3);
                                border = Colors.orange;
                              } else if (isVisited) {
                                bg = Colors.white10;
                              }

                              return Row(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: bg,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: border, width: 2),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${_state.nodes[i]}',
                                        style: TextStyle(
                                          color: isFound ? Colors.black : Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (i < _state.nodes.length - 1)
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 4),
                                      child: Icon(Icons.arrow_right_alt, color: Colors.white54, size: 28),
                                    ),
                                  if (i == _state.nodes.length - 1)
                                    const Padding(
                                      padding: EdgeInsets.only(left: 4),
                                      child: Text('→ null', style: TextStyle(color: Colors.white38, fontSize: 12)),
                                    ),
                                ],
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                VisualizerControl(label: 'Insert Head', icon: Icons.vertical_align_top, onPressed: _showInsertBeginningDialog, primary: true),
                VisualizerControl(label: 'Insert Tail', icon: Icons.vertical_align_bottom, onPressed: _showInsertEndDialog),
                VisualizerControl(label: 'Delete', icon: Icons.delete, onPressed: _showDeleteDialog),
                VisualizerControl(label: 'Search', icon: Icons.search, onPressed: _showSearchDialog),
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
                  Text('Linked List Insights', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  SizedBox(height: 8),
                  Text('• HEAD points to first node\n• Each node has data + next pointer\n• Last node points to null\n• No random access — must traverse from HEAD',
                      style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5)),
                  SizedBox(height: 12),
                  Text('Complexities', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  SizedBox(height: 8),
                  Text('• Insert at head: O(1)\n• Insert at tail: O(n) or O(1) with tail\n• Search: O(n)\n• Delete: O(n)',
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
