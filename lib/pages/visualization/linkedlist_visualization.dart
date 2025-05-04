import 'package:flutter/material.dart';

class LinkedListVisualization extends StatefulWidget {
  const LinkedListVisualization({super.key});

  @override
  State<LinkedListVisualization> createState() => _LinkedListVisualizationState();
}

class _LinkedListVisualizationState extends State<LinkedListVisualization> {
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _indexController = TextEditingController();
  List<String> nodes = [];

  void _insertStart() {
    if (_valueController.text.isEmpty) return;
    setState(() {
      nodes.insert(0, _valueController.text);
      _valueController.clear();
    });
  }

  void _insertEnd() {
    if (_valueController.text.isEmpty) return;
    setState(() {
      nodes.add(_valueController.text);
      _valueController.clear();
    });
  }

  void _insertIndex() {
    if (_valueController.text.isEmpty || _indexController.text.isEmpty) return;
    int idx = int.tryParse(_indexController.text) ?? -1;
    if (idx < 0 || idx > nodes.length) return;
    setState(() {
      nodes.insert(idx, _valueController.text);
      _valueController.clear();
      _indexController.clear();
    });
  }

  void _deleteStart() {
    if (nodes.isEmpty) return;
    setState(() {
      nodes.removeAt(0);
    });
  }

  void _deleteEnd() {
    if (nodes.isEmpty) return;
    setState(() {
      nodes.removeLast();
    });
  }

  void _deleteIndex() {
    if (_indexController.text.isEmpty) return;
    int idx = int.tryParse(_indexController.text) ?? -1;
    if (idx < 0 || idx >= nodes.length) return;
    setState(() {
      nodes.removeAt(idx);
      _indexController.clear();
    });
  }

  void _clearList() {
    setState(() {
      nodes.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.white24, width: 1.5),
    );
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF181A1B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Visualization', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 18),
          TextField(
            controller: _valueController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Value',
              hintStyle: const TextStyle(color: Colors.white54),
              filled: true,
              fillColor: Colors.transparent,
              border: border,
              enabledBorder: border,
              focusedBorder: border.copyWith(borderSide: const BorderSide(color: Color(0xFF3FB950), width: 2)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: 180,
            child: TextField(
              controller: _indexController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Index',
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.transparent,
                border: border,
                enabledBorder: border,
                focusedBorder: border.copyWith(borderSide: const BorderSide(color: Color(0xFF3FB950), width: 2)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 16,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              _opButton('Insert Start', _insertStart),
              _opButton('Insert End', _insertEnd),
              _opButton('Insert Index', _insertIndex),
              _opButton('Delete Start', _deleteStart),
              _opButton('Delete End', _deleteEnd),
              _opButton('Delete Index', _deleteIndex),
              _opButton('Clear List', _clearList, fill: true),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white24, style: BorderStyle.solid, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: nodes.isEmpty
                ? const Text('add nodes to begin 🌱', style: TextStyle(color: Colors.white54, fontStyle: FontStyle.italic))
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int i = 0; i < nodes.length; i++) ...[
                          _nodeBox(nodes[i], isHead: i == 0, isTail: i == nodes.length - 1),
                          if (i != nodes.length - 1)
                            const Icon(Icons.arrow_forward, color: Color(0xFF3FB950), size: 32),
                        ]
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _opButton(String label, VoidCallback onTap, {bool fill = false}) {
    return SizedBox(
      width: 180,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: fill ? const Color(0xFF3FB950) : const Color(0xFF3FB950).withOpacity(0.8),
          foregroundColor: Colors.black,
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        onPressed: onTap,
        child: Text(label),
      ),
    );
  }

  Widget _nodeBox(String value, {bool isHead = false, bool isTail = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFF232323),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF3FB950), width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isHead) const Text('Head', style: TextStyle(color: Color(0xFF3FB950), fontSize: 12)),
              if (isTail) const Text('Tail', style: TextStyle(color: Color(0xFF3FB950), fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
} 