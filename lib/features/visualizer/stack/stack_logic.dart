class StackVisualizerState {
  final List<int> stack;
  final String lastOperation;
  final String complexity;
  final String? errorMessage;
  final int? peekIndex;
  final bool isPushAnimation;
  final bool isPopAnimation;

  StackVisualizerState({
    List<int>? stack,
    this.lastOperation = 'Stack initialized',
    this.complexity = 'Push/Pop: O(1)',
    this.errorMessage,
    this.peekIndex,
    this.isPushAnimation = false,
    this.isPopAnimation = false,
  }) : stack = stack ?? [10, 20, 30];

  StackVisualizerState copyWith({
    List<int>? stack,
    String? lastOperation,
    String? complexity,
    String? errorMessage,
    int? peekIndex,
    bool? isPushAnimation,
    bool? isPopAnimation,
    bool clearError = false,
    bool clearPeek = false,
  }) {
    return StackVisualizerState(
      stack: stack ?? List.from(this.stack),
      lastOperation: lastOperation ?? this.lastOperation,
      complexity: complexity ?? this.complexity,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      peekIndex: clearPeek ? null : (peekIndex ?? this.peekIndex),
      isPushAnimation: isPushAnimation ?? false,
      isPopAnimation: isPopAnimation ?? false,
    );
  }

  bool get isEmpty => stack.isEmpty;
  int? get top => stack.isEmpty ? null : stack.last;
}

class StackLogic {
  StackVisualizerState _state;
  final void Function(StackVisualizerState) onStateChanged;

  StackLogic({StackVisualizerState? initialState, required this.onStateChanged})
      : _state = initialState ?? StackVisualizerState();

  StackVisualizerState get state => _state;

  void _update(StackVisualizerState s) {
    _state = s;
    onStateChanged(_state);
  }

  void push(int value) {
    final newStack = List<int>.from(_state.stack)..add(value);
    _update(StackVisualizerState(
      stack: newStack,
      lastOperation: '$value was added to the top of the stack.',
      complexity: 'Push: O(1)',
      isPushAnimation: true,
    ));
    Future.delayed(const Duration(milliseconds: 300), () {
      _update(_state.copyWith(isPushAnimation: false));
    });
  }

  void pop() {
    if (_state.stack.isEmpty) {
      _update(_state.copyWith(
        errorMessage: 'Stack underflow — cannot pop from empty stack',
        lastOperation: 'Pop failed: stack is empty',
        complexity: '—',
      ));
      return;
    }
    final newStack = List<int>.from(_state.stack);
    final removed = newStack.removeLast();
    _update(StackVisualizerState(
      stack: newStack,
      lastOperation: '$removed was removed from the top.\nLIFO: Last In, First Out',
      complexity: 'Pop: O(1)',
      isPopAnimation: true,
    ));
    Future.delayed(const Duration(milliseconds: 300), () {
      _update(_state.copyWith(isPopAnimation: false));
    });
  }

  void peek() {
    if (_state.stack.isEmpty) {
      _update(_state.copyWith(
        errorMessage: 'Stack is empty — nothing to peek',
        lastOperation: 'Peek failed',
      ));
      return;
    }
    _update(_state.copyWith(
      lastOperation: 'Top element is ${_state.top}. Peek does not remove it.',
      complexity: 'Peek: O(1)',
      peekIndex: _state.stack.length - 1,
      clearError: true,
    ));
    Future.delayed(const Duration(milliseconds: 1500), () {
      _update(_state.copyWith(clearPeek: true));
    });
  }

  void clear() {
    _update(StackVisualizerState(
      stack: [],
      lastOperation: 'Stack cleared',
      complexity: 'Clear: O(n) or O(1) depending on implementation',
    ));
  }

  void reset() {
    _update(StackVisualizerState(
      stack: [10, 20, 30],
      lastOperation: 'Stack reset',
      complexity: 'Push/Pop: O(1)',
    ));
  }
}
