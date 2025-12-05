import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class SortingVisualizer extends StatefulWidget {
  final Function(List<int>, Function(List<int>, int, int)) sortFunction;

  const SortingVisualizer({super.key, required this.sortFunction});

  @override
  State<SortingVisualizer> createState() => _SortingVisualizerState();
}

class _SortingVisualizerState extends State<SortingVisualizer> {
  List<int> _numbers = [];
  int _sampleSize = 60;
  bool _isSorting = false;
  int _activeIdx1 = -1;
  int _activeIdx2 = -1;
  StreamController<List<int>> _streamController = StreamController();

  @override
  void initState() {
    super.initState();
    _reset();
  }

  void _reset() {
    if (_isSorting) return;
    _numbers = [];
    for (int i = 0; i < _sampleSize; i++) {
      _numbers.add(Random().nextInt(150) + 10);
    }
    _streamController.add(_numbers);
    setState(() {
      _activeIdx1 = -1;
      _activeIdx2 = -1;
    });
  }

  Future<void> _sort() async {
    if (_isSorting) return;
    setState(() {
      _isSorting = true;
    });

    await widget.sortFunction(_numbers, (list, idx1, idx2) async {
      if (!mounted) return;
      setState(() {
        _activeIdx1 = idx1;
        _activeIdx2 = idx2;
      });
      _streamController.add(list);
      // Faster delay for smoother animation
      await Future.delayed(const Duration(milliseconds: 10));
    });

    if (mounted) {
      setState(() {
        _isSorting = false;
        _activeIdx1 = -1;
        _activeIdx2 = -1;
      });
    }
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 250,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF232323),
            borderRadius: BorderRadius.circular(12),
          ),
          child: StreamBuilder<List<int>>(
            stream: _streamController.stream,
            initialData: _numbers,
            builder: (context, snapshot) {
              List<int> numbers = snapshot.data ?? [];
              return LayoutBuilder(
                builder: (context, constraints) {
                  final double barWidth = constraints.maxWidth / numbers.length;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(numbers.length, (index) {
                      return Container(
                        width: barWidth * 0.8, // 80% width for spacing
                        margin: EdgeInsets.symmetric(
                          horizontal: barWidth * 0.1,
                        ),
                        height: numbers[index].toDouble(),
                        decoration: BoxDecoration(
                          color:
                              (index == _activeIdx1 || index == _activeIdx2)
                                  ? Colors.red
                                  : const Color(0xFF0C8159),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      );
                    }),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _isSorting ? null : _reset,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
                foregroundColor: Colors.white,
              ),
              child: const Text('Reset'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: _isSorting ? null : _sort,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0C8159),
                foregroundColor: Colors.white,
              ),
              child: const Text('Sort'),
            ),
          ],
        ),
      ],
    );
  }
}
