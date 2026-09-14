import 'dart:math';

class ArrayVisualizerState {
  List<int> array;
  int? highlightedIndex;
  int? foundIndex;
  String lastOperation;
  String complexity;
  String? errorMessage;
  List<int> visitedIndices;

  ArrayVisualizerState({
    List<int>? array,
    this.highlightedIndex,
    this.foundIndex,
    this.lastOperation = 'Array initialized',
    this.complexity = 'Access: O(1)',
    this.errorMessage,
    List<int>? visitedIndices,
  })  : array = array ?? [10, 25, 31, 42, 18],
        visitedIndices = visitedIndices ?? [];

  ArrayVisualizerState copyWith({
    List<int>? array,
    int? highlightedIndex,
    int? foundIndex,
    String? lastOperation,
    String? complexity,
    String? errorMessage,
    List<int>? visitedIndices,
    bool clearHighlight = false,
    bool clearFound = false,
    bool clearError = false,
  }) {
    return ArrayVisualizerState(
      array: array ?? List.from(this.array),
      highlightedIndex: clearHighlight ? null : (highlightedIndex ?? this.highlightedIndex),
      foundIndex: clearFound ? null : (foundIndex ?? this.foundIndex),
      lastOperation: lastOperation ?? this.lastOperation,
      complexity: complexity ?? this.complexity,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      visitedIndices: visitedIndices ?? List.from(this.visitedIndices),
    );
  }
}

class ArrayLogic {
  ArrayVisualizerState _state;
  final void Function(ArrayVisualizerState) onStateChanged;

  ArrayLogic({ArrayVisualizerState? initialState, required this.onStateChanged})
      : _state = initialState ?? ArrayVisualizerState();

  ArrayVisualizerState get state => _state;

  void _update(ArrayVisualizerState newState) {
    _state = newState;
    onStateChanged(_state);
  }

  void insert(int index, int value) {
    if (index < 0 || index > _state.array.length) {
      _update(_state.copyWith(
        errorMessage: 'Invalid index $index. Valid range: 0-${_state.array.length}',
        lastOperation: 'Insert failed',
        complexity: '—',
      ));
      return;
    }
    final newArray = List<int>.from(_state.array);
    newArray.insert(index, value);
    _update(ArrayVisualizerState(
      array: newArray,
      highlightedIndex: index,
      lastOperation: 'Inserted $value at index $index',
      complexity: 'Insert: O(n) — shifts elements',
      visitedIndices: [],
    ));
  }

  void update(int index, int value) {
    if (index < 0 || index >= _state.array.length) {
      _update(_state.copyWith(
        errorMessage: 'Invalid index $index. Valid range: 0-${_state.array.length - 1}',
        lastOperation: 'Update failed',
      ));
      return;
    }
    final newArray = List<int>.from(_state.array);
    final old = newArray[index];
    newArray[index] = value;
    _update(ArrayVisualizerState(
      array: newArray,
      highlightedIndex: index,
      lastOperation: 'Updated index $index: $old → $value',
      complexity: 'Update: O(1)',
    ));
  }

  void removeAt(int index) {
    if (_state.array.isEmpty) {
      _update(_state.copyWith(
        errorMessage: 'Array is empty',
        lastOperation: 'Remove failed',
      ));
      return;
    }
    if (index < 0 || index >= _state.array.length) {
      _update(_state.copyWith(
        errorMessage: 'Invalid index $index',
        lastOperation: 'Remove failed',
      ));
      return;
    }
    final newArray = List<int>.from(_state.array);
    final removed = newArray.removeAt(index);
    _update(ArrayVisualizerState(
      array: newArray,
      lastOperation: 'Removed $removed from index $index',
      complexity: 'Remove: O(n) — shifts elements',
    ));
  }

  Future<void> search(int value, {void Function()? onStep}) async {
    if (_state.array.isEmpty) {
      _update(_state.copyWith(
        errorMessage: 'Array is empty',
        lastOperation: 'Search failed',
      ));
      return;
    }
    _update(ArrayVisualizerState(
      array: _state.array,
      lastOperation: 'Searching for $value...',
      complexity: 'Linear search: O(n)',
      visitedIndices: [],
    ));

    for (int i = 0; i < _state.array.length; i++) {
      _update(ArrayVisualizerState(
        array: _state.array,
        highlightedIndex: i,
        lastOperation: 'Checking index $i: ${_state.array[i]} == $value ?',
        complexity: 'Linear search: O(n)',
        visitedIndices: List.generate(i, (idx) => idx),
      ));
      await Future.delayed(const Duration(milliseconds: 600));
      if (_state.array[i] == value) {
        _update(ArrayVisualizerState(
          array: _state.array,
          foundIndex: i,
          highlightedIndex: i,
          lastOperation: 'Found $value at index $i!',
          complexity: 'Found in ${i + 1} steps — O(n)',
          visitedIndices: List.generate(i, (idx) => idx),
        ));
        return;
      }
    }
    _update(ArrayVisualizerState(
      array: _state.array,
      lastOperation: '$value not found after checking all ${_state.array.length} elements',
      complexity: 'Not found — O(n)',
      visitedIndices: List.generate(_state.array.length, (i) => i),
    ));
  }

  void reset() {
    _update(ArrayVisualizerState(
      array: [10, 25, 31, 42, 18],
      lastOperation: 'Array reset to initial state',
      complexity: 'Access: O(1)',
    ));
  }

  void clear() {
    _update(ArrayVisualizerState(
      array: [],
      lastOperation: 'Array cleared',
      complexity: '—',
    ));
  }

  void randomize() {
    final rnd = Random();
    final newArray = List.generate(5 + rnd.nextInt(4), (_) => rnd.nextInt(100));
    _update(ArrayVisualizerState(
      array: newArray,
      lastOperation: 'Random array generated',
      complexity: 'Access: O(1)',
    ));
  }
}
