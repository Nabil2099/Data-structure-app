import 'package:flutter/material.dart';

class LinkedListVisualizer extends StatefulWidget {
  const LinkedListVisualizer({super.key});

  @override
  State<LinkedListVisualizer> createState() => _LinkedListVisualizerState();
}

class _LinkedListVisualizerState extends State<LinkedListVisualizer> {
  final List<int> _nodes = [10, 20, 30];
  final TextEditingController _valueController = TextEditingController();

  void _insertHead() {
    if (_valueController.text.isNotEmpty) {
      setState(() {
        _nodes.insert(0, int.parse(_valueController.text));
        _valueController.clear();
      });
    }
  }

  void _insertTail() {
    if (_valueController.text.isNotEmpty) {
      setState(() {
        _nodes.add(int.parse(_valueController.text));
        _valueController.clear();
      });
    }
  }

  void _deleteValue() {
    if (_valueController.text.isNotEmpty) {
      setState(() {
        _nodes.remove(int.parse(_valueController.text));
        _valueController.clear();
      });
    }
  }

  void _reset() {
    setState(() {
      _nodes.clear();
      _nodes.addAll([10, 20, 30]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    _nodes.asMap().entries.map((entry) {
                      int index = entry.key;
                      int value = entry.value;
                      return Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                value.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          if (index < _nodes.length - 1)
                            const Icon(
                              Icons.arrow_right_alt,
                              color: Colors.white,
                              size: 40,
                            ),
                        ],
                      );
                    }).toList(),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                child: TextField(
                  controller: _valueController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Value',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ElevatedButton(
                    onPressed: _insertHead,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0C8159),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Insert Head'),
                  ),
                  ElevatedButton(
                    onPressed: _insertTail,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0C8159),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Insert Tail'),
                  ),
                  ElevatedButton(
                    onPressed: _deleteValue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Delete'),
                  ),
                  ElevatedButton(
                    onPressed: _reset,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Reset'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
