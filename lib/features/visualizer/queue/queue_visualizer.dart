import 'package:flutter/material.dart';
import '../../../core/widgets/common_widgets.dart';
import 'queue_logic.dart';

class QueueVisualizerScreen extends StatefulWidget {
  const QueueVisualizerScreen({super.key});

  @override
  State<QueueVisualizerScreen> createState() => _QueueVisualizerScreenState();
}

class _QueueVisualizerScreenState extends State<QueueVisualizerScreen> {
  late QueueLogic _logic;
  late QueueVisualizerState _state;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _state = QueueVisualizerState();
    _logic = QueueLogic(
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

  void _showEnqueueDialog() {
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
            const Text('Enqueue Value',
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
                  _logic.enqueue(v);
                },
                child: const Text('Enqueue'),
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
        title: const Text('Queue Visualizer'),
        backgroundColor: const Color(0xFF0C8159),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              title: 'Queue',
              subtitle: 'FIFO — First In, First Out',
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
              child: _state.queue.isEmpty
                  ? const EmptyState(
                      message: 'Your queue is empty.\nEnqueue a value to get started.',
                      icon: Icons.compare_arrows,
                    )
                  : Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('FRONT',
                                style: TextStyle(
                                    color: Color(0xFF3FB950),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                            SizedBox(width: 4),
                            Icon(Icons.arrow_forward,
                                color: Color(0xFF3FB950), size: 14),
                            SizedBox(width: 16),
                            Icon(Icons.arrow_back,
                                color: Colors.orange, size: 14),
                            SizedBox(width: 4),
                            Text('REAR',
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(_state.queue.length, (i) {
                              final isFront = i == 0;
                              final isRear = i == _state.queue.length - 1;
                              final isPeeked = _state.peekIndex == i;
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 16),
                                decoration: BoxDecoration(
                                  color: isPeeked
                                      ? Colors.orange.withValues(alpha: 0.3)
                                      : const Color(0xFF232323),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isFront
                                        ? const Color(0xFF3FB950)
                                        : isRear
                                            ? Colors.orange
                                            : isPeeked
                                                ? Colors.orange
                                                : Colors.white24,
                                    width: (isFront || isRear) ? 2.5 : 1.5,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      '${_state.queue[i]}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    if (isFront)
                                      const Text('FRONT',
                                          style: TextStyle(
                                              color: Color(0xFF3FB950),
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold)),
                                    if (isRear && !isFront)
                                      const Text('REAR',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold)),
                                    if (isFront && isRear)
                                      const Text('FRONT/REAR',
                                          style: TextStyle(
                                              color: Color(0xFF3FB950),
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'FRONT → [${_state.queue.join('] [')}] ← REAR',
                          style: const TextStyle(
                              color: Colors.white38, fontSize: 11, fontFamily: 'monospace'),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                VisualizerControl(
                  label: 'Enqueue',
                  icon: Icons.add,
                  onPressed: _showEnqueueDialog,
                  primary: true,
                ),
                VisualizerControl(
                  label: 'Dequeue',
                  icon: Icons.remove,
                  onPressed: _logic.dequeue,
                ),
                VisualizerControl(
                  label: 'Peek Front',
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
                  Text('How Queue Works',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                  SizedBox(height: 8),
                  Text(
                    '• Enqueue adds at REAR\n• Dequeue removes from FRONT\n• FIFO: First In, First Out\n• Real use: Printer jobs, task scheduling, BFS',
                    style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
                  ),
                  SizedBox(height: 12),
                  Text('Time Complexities',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                  SizedBox(height: 8),
                  Text('• Enqueue: O(1)\n• Dequeue: O(1) (linked list)\n• Peek: O(1)',
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
