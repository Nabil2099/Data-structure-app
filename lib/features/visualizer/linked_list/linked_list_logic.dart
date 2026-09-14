class LinkedListNode {
  final int value;
  LinkedListNode? next;
  LinkedListNode(this.value);
}

class LinkedListVisualizerState {
  final List<int> nodes;
  final String lastOperation;
  final String complexity;
  final String? errorMessage;
  final int? highlightedIndex;
  final int? foundIndex;
  final List<int> visitedIndices;
  final bool isTraversing;

  LinkedListVisualizerState({
    List<int>? nodes,
    this.lastOperation = 'Linked List initialized',
    this.complexity = 'Access: O(n)',
    this.errorMessage,
    this.highlightedIndex,
    this.foundIndex,
    List<int>? visitedIndices,
    this.isTraversing = false,
  })  : nodes = nodes ?? [10, 20, 30],
        visitedIndices = visitedIndices ?? [];

  LinkedListVisualizerState copyWith({
    List<int>? nodes,
    String? lastOperation,
    String? complexity,
    String? errorMessage,
    int? highlightedIndex,
    int? foundIndex,
    List<int>? visitedIndices,
    bool? isTraversing,
    bool clearHighlight = false,
    bool clearFound = false,
    bool clearError = false,
  }) {
    return LinkedListVisualizerState(
      nodes: nodes ?? List.from(this.nodes),
      lastOperation: lastOperation ?? this.lastOperation,
      complexity: complexity ?? this.complexity,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      highlightedIndex:
          clearHighlight ? null : (highlightedIndex ?? this.highlightedIndex),
      foundIndex: clearFound ? null : (foundIndex ?? this.foundIndex),
      visitedIndices: visitedIndices ?? List.from(this.visitedIndices),
      isTraversing: isTraversing ?? this.isTraversing,
    );
  }
}

class LinkedListLogic {
  LinkedListVisualizerState _state;
  final void Function(LinkedListVisualizerState) onStateChanged;

  LinkedListLogic(
      {LinkedListVisualizerState? initialState, required this.onStateChanged})
      : _state = initialState ?? LinkedListVisualizerState();

  LinkedListVisualizerState get state => _state;

  void _update(LinkedListVisualizerState s) {
    _state = s;
    onStateChanged(_state);
  }

  void insertAtBeginning(int value) {
    final newNodes = List<int>.from(_state.nodes);
    newNodes.insert(0, value);
    _update(LinkedListVisualizerState(
      nodes: newNodes,
      lastOperation: 'Inserted $value at beginning (HEAD).\nNew HEAD → $value',
      complexity: 'Insert at head: O(1)',
      highlightedIndex: 0,
    ));
  }

  void insertAtEnd(int value) {
    final newNodes = List<int>.from(_state.nodes);
    newNodes.add(value);
    _update(LinkedListVisualizerState(
      nodes: newNodes,
      lastOperation: 'Inserted $value at end.\nTraversed to tail → O(n), insert O(1)',
      complexity: 'Insert at end: O(n) without tail pointer, O(1) with tail',
      highlightedIndex: newNodes.length - 1,
    ));
  }

  void delete(int value) {
    if (_state.nodes.isEmpty) {
      _update(_state.copyWith(
        errorMessage: 'List is empty',
        lastOperation: 'Delete failed',
      ));
      return;
    }
    final newNodes = List<int>.from(_state.nodes);
    final removed = newNodes.remove(value);
    if (!removed) {
      _update(_state.copyWith(
        errorMessage: 'Value $value not found',
        lastOperation: 'Delete failed: $value not in list',
      ));
      return;
    }
    _update(LinkedListVisualizerState(
      nodes: newNodes,
      lastOperation: 'Deleted $value from list.\nLinks updated to bypass node.',
      complexity: 'Delete: O(n) search + O(1) removal',
    ));
  }

  void deleteAt(int index) {
    if (_state.nodes.isEmpty) {
      _update(_state.copyWith(
        errorMessage: 'List is empty',
        lastOperation: 'Delete failed',
      ));
      return;
    }
    if (index < 0 || index >= _state.nodes.length) {
      _update(_state.copyWith(
        errorMessage: 'Invalid index $index',
        lastOperation: 'Delete failed',
      ));
      return;
    }
    final newNodes = List<int>.from(_state.nodes);
    final removed = newNodes.removeAt(index);
    _update(LinkedListVisualizerState(
      nodes: newNodes,
      lastOperation: 'Deleted $removed at index $index',
      complexity: 'Delete at index: O(n)',
    ));
  }

  Future<void> search(int value) async {
    if (_state.nodes.isEmpty) {
      _update(_state.copyWith(
        errorMessage: 'List is empty',
        lastOperation: 'Search failed',
      ));
      return;
    }
    _update(LinkedListVisualizerState(
      nodes: _state.nodes,
      lastOperation: 'Searching for $value starting from HEAD...',
      complexity: 'Search: O(n)',
      isTraversing: true,
      visitedIndices: [],
    ));

    for (int i = 0; i < _state.nodes.length; i++) {
      _update(LinkedListVisualizerState(
        nodes: _state.nodes,
        lastOperation: 'Visiting node $i: ${_state.nodes[i]} == $value ?',
        complexity: 'Search: O(n)',
        highlightedIndex: i,
        visitedIndices: List.generate(i, (idx) => idx),
        isTraversing: true,
      ));
      await Future.delayed(const Duration(milliseconds: 700));
      if (_state.nodes[i] == value) {
        _update(LinkedListVisualizerState(
          nodes: _state.nodes,
          lastOperation: 'Found $value at position $i!',
          complexity: 'Found in ${i + 1} steps',
          foundIndex: i,
          highlightedIndex: i,
          visitedIndices: List.generate(i, (idx) => idx),
          isTraversing: false,
        ));
        return;
      }
    }
    _update(LinkedListVisualizerState(
      nodes: _state.nodes,
      lastOperation: '$value not found after traversing all ${_state.nodes.length} nodes',
      complexity: 'Not found — O(n)',
      visitedIndices: List.generate(_state.nodes.length, (i) => i),
      isTraversing: false,
    ));
  }

  void reset() {
    _update(LinkedListVisualizerState(
      nodes: [10, 20, 30],
      lastOperation: 'List reset to initial state',
      complexity: 'Access: O(n)',
    ));
  }

  void clear() {
    _update(LinkedListVisualizerState(
      nodes: [],
      lastOperation: 'List cleared — HEAD = null',
      complexity: '—',
    ));
  }
}
