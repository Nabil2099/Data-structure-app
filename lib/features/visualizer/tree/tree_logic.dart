import 'dart:math';

class TreeNode {
  int value;
  TreeNode? left;
  TreeNode? right;
  TreeNode(this.value);
}

class TreeVisualizerState {
  final TreeNode? root;
  final List<int> values; // for easy rebuild
  final String lastOperation;
  final String complexity;
  final String? errorMessage;
  final int? highlightedValue;
  final List<int> traversalResult;
  final List<int> visitedOrder;
  final bool isTraversing;

  TreeVisualizerState({
    this.root,
    List<int>? values,
    this.lastOperation = 'BST initialized',
    this.complexity = 'Search/Insert: O(log n) avg, O(n) worst',
    this.errorMessage,
    this.highlightedValue,
    List<int>? traversalResult,
    List<int>? visitedOrder,
    this.isTraversing = false,
  })  : values = values ?? [50, 30, 70, 20, 40, 60, 80],
        traversalResult = traversalResult ?? [],
        visitedOrder = visitedOrder ?? [];

  TreeVisualizerState copyWith({
    TreeNode? root,
    List<int>? values,
    String? lastOperation,
    String? complexity,
    String? errorMessage,
    int? highlightedValue,
    List<int>? traversalResult,
    List<int>? visitedOrder,
    bool? isTraversing,
    bool clearHighlight = false,
    bool clearError = false,
  }) {
    return TreeVisualizerState(
      root: root ?? this.root,
      values: values ?? List.from(this.values),
      lastOperation: lastOperation ?? this.lastOperation,
      complexity: complexity ?? this.complexity,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      highlightedValue:
          clearHighlight ? null : (highlightedValue ?? this.highlightedValue),
      traversalResult: traversalResult ?? List.from(this.traversalResult),
      visitedOrder: visitedOrder ?? List.from(this.visitedOrder),
      isTraversing: isTraversing ?? this.isTraversing,
    );
  }
}

class TreeLogic {
  TreeVisualizerState _state;
  final void Function(TreeVisualizerState) onStateChanged;

  TreeLogic({TreeVisualizerState? initialState, required this.onStateChanged})
      : _state = initialState ?? TreeVisualizerState() {
    _rebuildTree();
  }

  TreeVisualizerState get state => _state;

  void _update(TreeVisualizerState s) {
    _state = s;
    onStateChanged(_state);
  }

  void _rebuildTree() {
    TreeNode? root;
    for (var v in _state.values) {
      root = _insertNode(root, v);
    }
    _state = _state.copyWith(root: root);
    onStateChanged(_state);
  }

  TreeNode _insertNode(TreeNode? node, int value) {
    if (node == null) return TreeNode(value);
    if (value < node.value) {
      node.left = _insertNode(node.left, value);
    } else if (value > node.value) {
      node.right = _insertNode(node.right, value);
    }
    return node;
  }

  bool _searchNode(TreeNode? node, int value) {
    if (node == null) return false;
    if (node.value == value) return true;
    if (value < node.value) return _searchNode(node.left, value);
    return _searchNode(node.right, value);
  }

  TreeNode? _deleteNode(TreeNode? node, int value) {
    if (node == null) return null;
    if (value < node.value) {
      node.left = _deleteNode(node.left, value);
    } else if (value > node.value) {
      node.right = _deleteNode(node.right, value);
    } else {
      if (node.left == null) return node.right;
      if (node.right == null) return node.left;
      // two children: get inorder successor
      var succ = node.right!;
      while (succ.left != null) succ = succ.left!;
      node.value = succ.value;
      node.right = _deleteNode(node.right, succ.value);
    }
    return node;
  }

  void insert(int value) {
    if (_state.values.contains(value)) {
      _update(_state.copyWith(
        errorMessage: 'Duplicate value $value not allowed in BST',
        lastOperation: 'Insert failed: duplicate',
        complexity: '—',
      ));
      return;
    }
    final newValues = List<int>.from(_state.values)..add(value);
    TreeNode? newRoot;
    for (var v in newValues) {
      newRoot = _insertNode(newRoot, v);
    }
    _update(TreeVisualizerState(
      root: newRoot,
      values: newValues,
      lastOperation: 'Inserted $value into BST.\nBST property: left < parent < right',
      complexity: 'Insert: O(log n) avg, O(n) worst',
      highlightedValue: value,
    ));
  }

  Future<void> search(int value) async {
    if (_state.root == null) {
      _update(_state.copyWith(
        errorMessage: 'Tree is empty',
        lastOperation: 'Search failed',
      ));
      return;
    }
    _update(_state.copyWith(
      lastOperation: 'Searching for $value starting from root...',
      complexity: 'Search: O(log n) avg',
      isTraversing: true,
      visitedOrder: [],
      clearHighlight: true,
    ));

    TreeNode? current = _state.root;
    List<int> visited = [];
    while (current != null) {
      visited.add(current.value);
      _update(_state.copyWith(
        lastOperation:
            'Visiting ${current.value}: ${value == current.value ? 'Found!' : value < current.value ? '$value < ${current.value} → go left' : '$value > ${current.value} → go right'}',
        highlightedValue: current.value,
        visitedOrder: List.from(visited),
        isTraversing: true,
      ));
      await Future.delayed(const Duration(milliseconds: 800));
      if (current.value == value) {
        _update(_state.copyWith(
          lastOperation: 'Found $value in BST!',
          complexity: 'Found in ${visited.length} steps',
          highlightedValue: value,
          visitedOrder: visited,
          isTraversing: false,
        ));
        return;
      } else if (value < current.value) {
        current = current.left;
      } else {
        current = current.right;
      }
    }
    _update(_state.copyWith(
      lastOperation: '$value not found in BST after ${visited.length} steps',
      complexity: 'Not found — O(log n) avg',
      visitedOrder: visited,
      isTraversing: false,
      clearHighlight: true,
    ));
  }

  void delete(int value) {
    if (!_state.values.contains(value)) {
      _update(_state.copyWith(
        errorMessage: 'Value $value not found',
        lastOperation: 'Delete failed',
      ));
      return;
    }
    final newValues = List<int>.from(_state.values)..remove(value);
    TreeNode? newRoot;
    for (var v in newValues) {
      newRoot = _insertNode(newRoot, v);
    }
    _update(TreeVisualizerState(
      root: newRoot,
      values: newValues,
      lastOperation: 'Deleted $value from BST.\nTree restructured to maintain BST property.',
      complexity: 'Delete: O(log n) avg, O(n) worst',
    ));
  }

  Future<void> inorderTraversal() async {
    if (_state.root == null) {
      _update(_state.copyWith(
        errorMessage: 'Tree is empty',
        lastOperation: 'Traversal failed',
      ));
      return;
    }
    _update(_state.copyWith(
      lastOperation: 'Inorder traversal: Left → Root → Right\nYields sorted order for BST',
      complexity: 'Traversal: O(n)',
      isTraversing: true,
      traversalResult: [],
      visitedOrder: [],
    ));

    List<int> result = [];
    List<int> visited = [];
    await _inorder(_state.root, result, visited);
    _update(_state.copyWith(
      lastOperation: 'Inorder complete: ${result.join(' → ')}',
      complexity: 'O(n) — visits each node once',
      traversalResult: result,
      visitedOrder: visited,
      isTraversing: false,
      clearHighlight: true,
    ));
  }

  Future<void> _inorder(
      TreeNode? node, List<int> result, List<int> visited) async {
    if (node == null) return;
    await _inorder(node.left, result, visited);
    visited.add(node.value);
    result.add(node.value);
    _update(_state.copyWith(
      highlightedValue: node.value,
      traversalResult: List.from(result),
      visitedOrder: List.from(visited),
      isTraversing: true,
    ));
    await Future.delayed(const Duration(milliseconds: 700));
    await _inorder(node.right, result, visited);
  }

  Future<void> preorderTraversal() async {
    if (_state.root == null) {
      _update(_state.copyWith(
        errorMessage: 'Tree is empty',
        lastOperation: 'Traversal failed',
      ));
      return;
    }
    _update(_state.copyWith(
      lastOperation: 'Preorder: Root → Left → Right\nUsed to copy tree',
      complexity: 'O(n)',
      isTraversing: true,
      traversalResult: [],
      visitedOrder: [],
    ));
    List<int> result = [];
    List<int> visited = [];
    await _preorder(_state.root, result, visited);
    _update(_state.copyWith(
      lastOperation: 'Preorder complete: ${result.join(' → ')}',
      traversalResult: result,
      visitedOrder: visited,
      isTraversing: false,
      clearHighlight: true,
    ));
  }

  Future<void> _preorder(
      TreeNode? node, List<int> result, List<int> visited) async {
    if (node == null) return;
    visited.add(node.value);
    result.add(node.value);
    _update(_state.copyWith(
      highlightedValue: node.value,
      traversalResult: List.from(result),
      visitedOrder: List.from(visited),
      isTraversing: true,
    ));
    await Future.delayed(const Duration(milliseconds: 700));
    await _preorder(node.left, result, visited);
    await _preorder(node.right, result, visited);
  }

  Future<void> postorderTraversal() async {
    if (_state.root == null) {
      _update(_state.copyWith(
        errorMessage: 'Tree is empty',
        lastOperation: 'Traversal failed',
      ));
      return;
    }
    _update(_state.copyWith(
      lastOperation: 'Postorder: Left → Right → Root\nUsed to delete tree',
      complexity: 'O(n)',
      isTraversing: true,
      traversalResult: [],
      visitedOrder: [],
    ));
    List<int> result = [];
    List<int> visited = [];
    await _postorder(_state.root, result, visited);
    _update(_state.copyWith(
      lastOperation: 'Postorder complete: ${result.join(' → ')}',
      traversalResult: result,
      visitedOrder: visited,
      isTraversing: false,
      clearHighlight: true,
    ));
  }

  Future<void> _postorder(
      TreeNode? node, List<int> result, List<int> visited) async {
    if (node == null) return;
    await _postorder(node.left, result, visited);
    await _postorder(node.right, result, visited);
    visited.add(node.value);
    result.add(node.value);
    _update(_state.copyWith(
      highlightedValue: node.value,
      traversalResult: List.from(result),
      visitedOrder: List.from(visited),
      isTraversing: true,
    ));
    await Future.delayed(const Duration(milliseconds: 700));
  }

  void reset() {
    final initialValues = [50, 30, 70, 20, 40, 60, 80];
    TreeNode? newRoot;
    for (var v in initialValues) {
      newRoot = _insertNode(newRoot, v);
    }
    _update(TreeVisualizerState(
      root: newRoot,
      values: initialValues,
      lastOperation: 'BST reset to initial state',
      complexity: 'Balanced BST height ~ log n',
    ));
  }

  void clear() {
    _update(TreeVisualizerState(
      root: null,
      values: [],
      lastOperation: 'Tree cleared',
      complexity: '—',
    ));
  }
}
