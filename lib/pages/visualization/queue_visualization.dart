import 'package:flutter/material.dart';

class QueueVisualization extends StatefulWidget {
  const QueueVisualization({super.key});

  @override
  State<QueueVisualization> createState() => _QueueVisualizationState();
}

class _QueueVisualizationState extends State<QueueVisualization> {
  final TextEditingController _valueController = TextEditingController();
  List<String> queue = [];

  void _enqueue() {
    if (_valueController.text.isEmpty) return;
    setState(() {
      queue.add(_valueController.text);
      _valueController.clear();
    });
  }

  void _dequeue() {
    if (queue.isEmpty) return;
    setState(() {
      queue.removeAt(0);
    });
  }

  void _clear() {
    setState(() {
      queue.clear();
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
          const SizedBox(height: 18),
          Wrap(
            spacing: 16,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              _opButton('Enqueue', _enqueue),
              _opButton('Dequeue', _dequeue),
              _opButton('Clear', _clear, fill: true),
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
            child: queue.isEmpty
                ? const Text('add values to begin 🚎', style: TextStyle(color: Colors.white54, fontStyle: FontStyle.italic))
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int i = 0; i < queue.length; i++)
                          _queueBox(queue[i], isFront: i == 0, isRear: i == queue.length - 1),
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

  Widget _queueBox(String value, {bool isFront = false, bool isRear = false}) {
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
              if (isFront) const Text('Front', style: TextStyle(color: Color(0xFF3FB950), fontSize: 12)),
              if (isRear) const Text('Rear', style: TextStyle(color: Color(0xFF3FB950), fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}