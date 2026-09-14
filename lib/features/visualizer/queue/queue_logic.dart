class QueueVisualizerState {
  final List<int> queue;
  final String lastOperation;
  final String complexity;
  final String? errorMessage;
  final int? peekIndex;
  final bool isEnqueueAnimation;
  final bool isDequeueAnimation;

  QueueVisualizerState({
    List<int>? queue,
    this.lastOperation = 'Queue initialized',
    this.complexity = 'Enqueue/Dequeue: O(1)',
    this.errorMessage,
    this.peekIndex,
    this.isEnqueueAnimation = false,
    this.isDequeueAnimation = false,
  }) : queue = queue ?? [10, 20, 30];

  QueueVisualizerState copyWith({
    List<int>? queue,
    String? lastOperation,
    String? complexity,
    String? errorMessage,
    int? peekIndex,
    bool? isEnqueueAnimation,
    bool? isDequeueAnimation,
    bool clearError = false,
    bool clearPeek = false,
  }) {
    return QueueVisualizerState(
      queue: queue ?? List.from(this.queue),
      lastOperation: lastOperation ?? this.lastOperation,
      complexity: complexity ?? this.complexity,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      peekIndex: clearPeek ? null : (peekIndex ?? this.peekIndex),
      isEnqueueAnimation: isEnqueueAnimation ?? false,
      isDequeueAnimation: isDequeueAnimation ?? false,
    );
  }

  bool get isEmpty => queue.isEmpty;
  int? get front => queue.isEmpty ? null : queue.first;
  int? get rear => queue.isEmpty ? null : queue.last;
}

class QueueLogic {
  QueueVisualizerState _state;
  final void Function(QueueVisualizerState) onStateChanged;

  QueueLogic({QueueVisualizerState? initialState, required this.onStateChanged})
      : _state = initialState ?? QueueVisualizerState();

  QueueVisualizerState get state => _state;

  void _update(QueueVisualizerState s) {
    _state = s;
    onStateChanged(_state);
  }

  void enqueue(int value) {
    final newQueue = List<int>.from(_state.queue)..add(value);
    _update(QueueVisualizerState(
      queue: newQueue,
      lastOperation: '$value enqueued at REAR.\nFIFO: First In, First Out',
      complexity: 'Enqueue: O(1)',
      isEnqueueAnimation: true,
    ));
    Future.delayed(const Duration(milliseconds: 300), () {
      _update(_state.copyWith(isEnqueueAnimation: false));
    });
  }

  void dequeue() {
    if (_state.queue.isEmpty) {
      _update(_state.copyWith(
        errorMessage: 'Queue underflow — cannot dequeue from empty queue',
        lastOperation: 'Dequeue failed: queue is empty',
        complexity: '—',
      ));
      return;
    }
    final newQueue = List<int>.from(_state.queue);
    final removed = newQueue.removeAt(0);
    _update(QueueVisualizerState(
      queue: newQueue,
      lastOperation: '$removed dequeued from FRONT.\nFirst in is first out.',
      complexity: 'Dequeue: O(1) with linked list, O(n) with array',
      isDequeueAnimation: true,
    ));
    Future.delayed(const Duration(milliseconds: 300), () {
      _update(_state.copyWith(isDequeueAnimation: false));
    });
  }

  void peek() {
    if (_state.queue.isEmpty) {
      _update(_state.copyWith(
        errorMessage: 'Queue is empty — nothing at front',
        lastOperation: 'Peek failed',
      ));
      return;
    }
    _update(_state.copyWith(
      lastOperation: 'Front element is ${_state.front}. Peek does not remove it.',
      complexity: 'Peek: O(1)',
      peekIndex: 0,
      clearError: true,
    ));
    Future.delayed(const Duration(milliseconds: 1500), () {
      _update(_state.copyWith(clearPeek: true));
    });
  }

  void clear() {
    _update(QueueVisualizerState(
      queue: [],
      lastOperation: 'Queue cleared',
      complexity: 'Clear: O(n)',
    ));
  }

  void reset() {
    _update(QueueVisualizerState(
      queue: [10, 20, 30],
      lastOperation: 'Queue reset',
      complexity: 'Enqueue/Dequeue: O(1)',
    ));
  }
}
