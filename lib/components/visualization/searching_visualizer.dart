import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class SearchingVisualizer extends StatefulWidget {
  final Future<void> Function(
    List<int> arr,
    int target,
    Function(int) onStep,
    Function(int) onFound,
  )
  searchFunction;

  final bool requiresSortedArray;

  const SearchingVisualizer({
    super.key,
    required this.searchFunction,
    this.requiresSortedArray = false,
  });

  @override
  State<SearchingVisualizer> createState() => _SearchingVisualizerState();
}

class _SearchingVisualizerState extends State<SearchingVisualizer> {
  List<int> _array = [];
  int? _currentIndex;
  int? _foundIndex;
  bool _isSearching = false;
  final TextEditingController _targetController = TextEditingController();
  int _target = 42;

  @override
  void initState() {
    super.initState();
    _targetController.text = _target.toString();
    _resetArray();
  }

  @override
  void dispose() {
    _targetController.dispose();
    super.dispose();
  }

  void _resetArray() {
    // Generate random numbers
    final random = Random();
    _array = List.generate(15, (index) => random.nextInt(100));

    if (widget.requiresSortedArray) {
      _array.sort();
    }

    setState(() {
      _currentIndex = null;
      _foundIndex = null;
      _isSearching = false;
    });
  }

  Future<void> _startSearch() async {
    if (_isSearching) return;

    final int? inputTarget = int.tryParse(_targetController.text);
    if (inputTarget == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid integer')),
      );
      return;
    }

    setState(() {
      _target = inputTarget;
      _isSearching = true;
      _currentIndex = null;
      _foundIndex = null;
    });

    await widget.searchFunction(
      _array,
      _target,
      (index) async {
        if (!mounted) return;
        setState(() {
          _currentIndex = index;
        });
        await Future.delayed(const Duration(milliseconds: 500));
      },
      (index) async {
        if (!mounted) return;
        setState(() {
          _foundIndex = index;
          _currentIndex = null;
        });
      },
    );

    if (mounted) {
      setState(() {
        _isSearching = false;
      });
    }
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
                    _array.asMap().entries.map((entry) {
                      int index = entry.key;
                      int value = entry.value;

                      Color color = Colors.blue;
                      if (index == _foundIndex) {
                        color = Colors.green;
                      } else if (index == _currentIndex) {
                        color = Colors.orange;
                      }

                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            value.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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
              Text(
                'Target: ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 100,
                child: TextField(
                  controller: _targetController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Enter number',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  onSubmitted: (_) => _startSearch(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _isSearching ? null : _startSearch,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0C8159),
                foregroundColor: Colors.white,
              ),
              child: const Text('Start Search'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: _isSearching ? null : _resetArray,
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
