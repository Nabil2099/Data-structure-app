import 'package:flutter/material.dart';
import '../../../core/widgets/common_widgets.dart';
import 'array_logic.dart';

class ArrayVisualizerScreen extends StatefulWidget {
  const ArrayVisualizerScreen({super.key});

  @override
  State<ArrayVisualizerScreen> createState() => _ArrayVisualizerScreenState();
}

class _ArrayVisualizerScreenState extends State<ArrayVisualizerScreen> {
  late ArrayLogic _logic;
  late ArrayVisualizerState _state;
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _indexController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _state = ArrayVisualizerState();
    _logic = ArrayLogic(
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
    _searchController.dispose();
    super.dispose();
  }

  void _showInsertDialog() {
    _valueController.clear();
    _indexController.clear();
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
            const Text('Insert Value',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration('Value (e.g. 42)'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _indexController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration('Index (0-${_state.array.length})'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final val = int.tryParse(_valueController.text);
                  final idx = int.tryParse(_indexController.text);
                  if (val == null || idx == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enter valid numbers')),
                    );
                    return;
                  }
                  Navigator.pop(ctx);
                  _logic.insert(idx, val);
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

  void _showUpdateDialog() {
    _valueController.clear();
    _indexController.clear();
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
            const Text('Update Value',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: _indexController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration('Index'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration('New Value'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final val = int.tryParse(_valueController.text);
                  final idx = int.tryParse(_indexController.text);
                  if (val == null || idx == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enter valid numbers')),
                    );
                    return;
                  }
                  Navigator.pop(ctx);
                  _logic.update(idx, val);
                },
                child: const Text('Update'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showRemoveDialog() {
    _indexController.clear();
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
            const Text('Remove at Index',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: _indexController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration('Index'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final idx = int.tryParse(_indexController.text);
                  if (idx == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enter valid index')),
                    );
                    return;
                  }
                  Navigator.pop(ctx);
                  _logic.removeAt(idx);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                child: const Text('Remove'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showSearchDialog() {
    _searchController.clear();
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
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: _searchController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration('Value to search'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final val = int.tryParse(_searchController.text);
                  if (val == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enter valid number')),
                    );
                    return;
                  }
                  Navigator.pop(ctx);
                  _logic.search(val);
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

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white38),
      filled: true,
      fillColor: const Color(0xFF232323),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white24),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white24),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF3FB950), width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Array Visualizer'),
        backgroundColor: const Color(0xFF0C8159),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              title: 'Array',
              subtitle: 'Contiguous memory, O(1) random access',
            ),
            const SizedBox(height: 16),
            // Visualization
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF181A1B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white12),
              ),
              child: _state.array.isEmpty
                  ? const EmptyState(
                      message: 'Array is empty.\nInsert a value to get started.',
                      icon: Icons.data_array,
                    )
                  : Column(
                      children: [
                        // Index row
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(_state.array.length, (i) {
                              final isHighlighted = _state.highlightedIndex == i;
                              final isFound = _state.foundIndex == i;
                              final isVisited = _state.visitedIndices.contains(i);
                              Color bgColor = const Color(0xFF232323);
                              Color borderColor = Colors.white24;
                              if (isFound) {
                                bgColor = const Color(0xFF3FB950);
                                borderColor = const Color(0xFF3FB950);
                              } else if (isHighlighted) {
                                bgColor = Colors.orange.withValues(alpha: 0.3);
                                borderColor = Colors.orange;
                              } else if (isVisited) {
                                bgColor = Colors.white10;
                              }

                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: Column(
                                  children: [
                                    Text(
                                      '$i',
                                      style: const TextStyle(
                                        color: Colors.white54,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: bgColor,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: borderColor, width: 2),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${_state.array[i]}',
                                          style: TextStyle(
                                            color: isFound ? Colors.black : Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Index: ',
                                style: TextStyle(color: Colors.white54, fontSize: 12)),
                            Text(
                              _state.array.isEmpty
                                  ? '—'
                                  : '0 → ${_state.array.length - 1}',
                              style: const TextStyle(color: Colors.white38, fontSize: 12),
                            ),
                            const SizedBox(width: 16),
                            const Text('Length: ',
                                style: TextStyle(color: Colors.white54, fontSize: 12)),
                            Text(
                              '${_state.array.length}',
                              style: const TextStyle(color: Colors.white38, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 16),
            // Controls
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                VisualizerControl(
                  label: 'Insert',
                  icon: Icons.add,
                  onPressed: _showInsertDialog,
                  primary: true,
                ),
                VisualizerControl(
                  label: 'Update',
                  icon: Icons.edit,
                  onPressed: _showUpdateDialog,
                ),
                VisualizerControl(
                  label: 'Remove',
                  icon: Icons.remove,
                  onPressed: _showRemoveDialog,
                ),
                VisualizerControl(
                  label: 'Search',
                  icon: Icons.search,
                  onPressed: _showSearchDialog,
                ),
                VisualizerControl(
                  label: 'Random',
                  icon: Icons.shuffle,
                  onPressed: _logic.randomize,
                ),
                VisualizerControl(
                  label: 'Reset',
                  icon: Icons.refresh,
                  onPressed: _logic.reset,
                ),
                VisualizerControl(
                  label: 'Clear',
                  icon: Icons.clear,
                  onPressed: _logic.clear,
                ),
              ],
            ),
            const SizedBox(height: 16),
            ExplanationCard(
              operation: _state.lastOperation,
              complexity: _state.complexity,
              error: _state.errorMessage,
            ),
            const SizedBox(height: 16),
            // Complexity info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF181A1B),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Time Complexities',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                  SizedBox(height: 8),
                  Text('• Access by index: O(1)',
                      style: TextStyle(color: Colors.white70, fontSize: 12)),
                  Text('• Search (linear): O(n)',
                      style: TextStyle(color: Colors.white70, fontSize: 12)),
                  Text('• Insert/Remove middle: O(n)',
                      style: TextStyle(color: Colors.white70, fontSize: 12)),
                  Text('• Update: O(1)',
                      style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
