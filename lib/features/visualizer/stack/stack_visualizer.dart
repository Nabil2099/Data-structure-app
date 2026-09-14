import 'package:flutter/material.dart';
import '../../../core/widgets/common_widgets.dart';
import 'stack_logic.dart';

class StackVisualizerScreen extends StatefulWidget {
  const StackVisualizerScreen({super.key});

  @override
  State<StackVisualizerScreen> createState() => _StackVisualizerScreenState();
}

class _StackVisualizerScreenState extends State<StackVisualizerScreen> {
  late StackLogic _logic;
  late StackVisualizerState _state;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _state = StackVisualizerState();
    _logic = StackLogic(
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

  void _showPushDialog() {
    _controller.clear();
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
            const Text('Push Value',
                style: TextStyle(
                    color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter value',
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
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final v = int.tryParse(_controller.text);
                  if (v == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enter valid number')),
                    );
                    return;
                  }
                  Navigator.pop(ctx);
                  _logic.push(v);
                },
                child: const Text('Push'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Stack Visualizer'),
        backgroundColor: const Color(0xFF0C8159),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              title: 'Stack',
              subtitle: 'LIFO — Last In, First Out',
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF181A1B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white12),
              ),
              child: _state.stack.isEmpty
                  ? const EmptyState(
                      message: 'Your stack is empty.\nPush a value to get started.',
                      icon: Icons.layers,
                    )
                  : Column(
                      children: [
                        if (_state.stack.isNotEmpty)
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('TOP',
                                  style: TextStyle(
                                      color: Color(0xFF3FB950),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                              SizedBox(width: 4),
                              Icon(Icons.arrow_downward,
                                  color: Color(0xFF3FB950), size: 14),
                            ],
                          ),
                        const SizedBox(height: 8),
                        ..._state.stack.reversed.map((value) {
                          final isTop = _state.stack.last == value &&
                              _state.stack.lastIndexOf(value) == _state.stack.length - 1;
                          final isPeeked = _state.peekIndex != null &&
                              _state.stack[_state.peekIndex!] == value &&
                              _state.peekIndex == _state.stack.length - 1;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            width: 200,
                            decoration: BoxDecoration(
                              color: isPeeked
                                  ? Colors.orange.withValues(alpha: 0.3)
                                  : const Color(0xFF232323),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isTop
                                    ? const Color(0xFF3FB950)
                                    : isPeeked
                                        ? Colors.orange
                                        : Colors.white24,
                                width: isTop ? 2.5 : 1.5,
                              ),
                              boxShadow: isTop
                                  ? [
                                      BoxShadow(
                                        color: const Color(0xFF3FB950)
                                            .withValues(alpha: 0.3),
                                        blurRadius: 8,
                                      )
                                    ]
                                  : null,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '$value',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                if (isTop)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF3FB950),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Text('TOP',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold)),
                                  ),
                              ],
                            ),
                          );
                        }),
                        const SizedBox(height: 12),
                        Container(
                          width: 200,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text('Bottom',
                            style: TextStyle(color: Colors.white38, fontSize: 10)),
                      ],
                    ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                VisualizerControl(
                  label: 'Push',
                  icon: Icons.add,
                  onPressed: _showPushDialog,
                  primary: true,
                ),
                VisualizerControl(
                  label: 'Pop',
                  icon: Icons.remove,
                  onPressed: _logic.pop,
                ),
                VisualizerControl(
                  label: 'Peek',
                  icon: Icons.visibility,
                  onPressed: _logic.peek,
                ),
                VisualizerControl(
                  label: 'Clear',
                  icon: Icons.clear,
                  onPressed: _logic.clear,
                ),
                VisualizerControl(
                  label: 'Reset',
                  icon: Icons.refresh,
                  onPressed: _logic.reset,
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
                  Text('How Stack Works',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                  SizedBox(height: 8),
                  Text(
                    '• Push adds to TOP\n• Pop removes from TOP\n• LIFO: Last In, First Out\n• Real use: Browser back button, undo, function calls',
                    style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
                  ),
                  SizedBox(height: 12),
                  Text('Time Complexities',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                  SizedBox(height: 8),
                  Text('• Push: O(1)\n• Pop: O(1)\n• Peek: O(1)\n• Search: O(n)',
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
