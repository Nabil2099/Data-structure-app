import 'package:flutter/material.dart';
import '../../../core/widgets/common_widgets.dart';
import 'hash_table_logic.dart';

class HashTableVisualizerScreen extends StatefulWidget {
  const HashTableVisualizerScreen({super.key});

  @override
  State<HashTableVisualizerScreen> createState() => _HashTableVisualizerScreenState();
}

class _HashTableVisualizerScreenState extends State<HashTableVisualizerScreen> {
  late HashTableLogic _logic;
  late HashTableVisualizerState _state;
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _state = HashTableVisualizerState();
    _logic = HashTableLogic(
      initialState: _state,
      onStateChanged: (s) {
        if (mounted) setState(() => _state = s);
      },
    );
  }

  @override
  void dispose() {
    _keyController.dispose();
    _valueController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _showInsertDialog() {
    _keyController.clear();
    _valueController.clear();
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
            const Text('Insert Key/Value', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(controller: _keyController, style: const TextStyle(color: Colors.white), decoration: _dec('Key (e.g. Sara)')),
            const SizedBox(height: 12),
            TextField(controller: _valueController, style: const TextStyle(color: Colors.white), decoration: _dec('Value (e.g. 30)')),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () { final k = _keyController.text; final v = _valueController.text; if (k.trim().isEmpty || v.trim().isEmpty) return; Navigator.pop(ctx); _logic.insert(k, v); }, child: const Text('Insert'))),
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
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom, left: 20, right: 20, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Search Key', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(controller: _searchController, style: const TextStyle(color: Colors.white), decoration: _dec('Key to search')),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () { final k = _searchController.text; if (k.trim().isEmpty) return; Navigator.pop(ctx); _logic.search(k); }, child: const Text('Search'))),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog() {
    _searchController.clear();
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
            const Text('Delete Key', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(controller: _searchController, style: const TextStyle(color: Colors.white), decoration: _dec('Key to delete')),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () { final k = _searchController.text; if (k.trim().isEmpty) return; Navigator.pop(ctx); _logic.delete(k); }, style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent), child: const Text('Delete'))),
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
      appBar: AppBar(title: const Text('Hash Table Visualizer'), backgroundColor: const Color(0xFF0C8159)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Hash Table', subtitle: 'Key-Value with hash collisions — separate chaining'),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF181A1B), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white12)),
              child: Column(
                children: List.generate(_state.bucketCount, (i) {
                  final bucket = _state.buckets[i];
                  final isHighlighted = _state.highlightedBucket == i;
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isHighlighted ? const Color(0xFF3FB950).withValues(alpha: 0.15) : const Color(0xFF232323),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: isHighlighted ? const Color(0xFF3FB950) : Colors.white12, width: isHighlighted ? 2 : 1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(color: isHighlighted ? const Color(0xFF3FB950) : Colors.white10, borderRadius: BorderRadius.circular(8)),
                          child: Center(child: Text('$i', style: TextStyle(color: isHighlighted ? Colors.black : Colors.white, fontWeight: FontWeight.bold))),
                        ),
                        const SizedBox(width: 12),
                        const Text('│', style: TextStyle(color: Colors.white24, fontSize: 20)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: bucket.isEmpty
                              ? const Text('empty', style: TextStyle(color: Colors.white24, fontStyle: FontStyle.italic, fontSize: 12))
                              : Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: bucket.map((entry) {
                                    final isKeyHighlighted = _state.highlightedKey == entry.key;
                                    return Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: isKeyHighlighted ? Colors.orange.withValues(alpha: 0.3) : const Color(0xFF181A1B),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: isKeyHighlighted ? Colors.orange : Colors.white24),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(entry.key, style: TextStyle(color: isKeyHighlighted ? Colors.orange : Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                                          const Text(' : ', style: TextStyle(color: Colors.white54, fontSize: 12)),
                                          Text(entry.value, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                                          if (bucket.indexOf(entry) < bucket.length - 1) const Padding(padding: EdgeInsets.only(left: 8), child: Icon(Icons.arrow_right_alt, color: Colors.white24, size: 14)),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            if (_state.showCollisionExplanation && _state.collisionMessage != null) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.orange.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.orange.withValues(alpha: 0.3))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(children: [Icon(Icons.warning_amber, color: Colors.orange, size: 16), SizedBox(width: 6), Text('Collision Detected', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 13))]),
                    const SizedBox(height: 6),
                    Text(_state.collisionMessage!, style: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.4)),
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
                  Text('Hash Table Insights', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  SizedBox(height: 8),
                  Text('• Hash function maps key → bucket index\n• Collision when different keys map to same bucket\n• Separate chaining: store colliding entries as linked list at bucket\n• Load factor = entries/buckets, high → more collisions',
                      style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5)),
                  SizedBox(height: 12),
                  Text('Complexities', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  SizedBox(height: 8),
                  Text('• Insert/Search/Delete avg: O(1)\n• Worst (all collide): O(n)\n• Good hash + resizing keeps avg O(1)',
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
