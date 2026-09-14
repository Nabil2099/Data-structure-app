import 'dart:collection';

class GraphVisualizerState {
  final Map<String, List<String>> adjacency;
  final Map<String, Offset> positions; // for visualization
  final String lastOperation;
  final String complexity;
  final String? errorMessage;
  final List<String> traversalOrder;
  final Set<String> visited;
  final String? currentNode;
  final bool isTraversing;
  final String? startNode;

  GraphVisualizerState({
    Map<String, List<String>>? adjacency,
    Map<String, Offset>? positions,
    this.lastOperation = 'Graph initialized',
    this.complexity = 'BFS/DFS: O(V+E)',
    this.errorMessage,
    List<String>? traversalOrder,
    Set<String>? visited,
    this.currentNode,
    this.isTraversing = false,
    this.startNode,
  })  : adjacency = adjacency ??
            {
              'A': ['B', 'C'],
              'B': ['D', 'E'],
              'C': ['F'],
              'D': [],
              'E': ['F'],
              'F': [],
            },
        positions = positions ??
            {
              'A': const Offset(0, -80),
              'B': const Offset(-80, 0),
              'C': const Offset(80, 0),
              'D': const Offset(-120, 80),
              'E': const Offset(-40, 80),
              'F': const Offset(80, 80),
            },
        traversalOrder = traversalOrder ?? [],
        visited = visited ?? {};

  GraphVisualizerState copyWith({
    Map<String, List<String>>? adjacency,
    Map<String, Offset>? positions,
    String? lastOperation,
    String? complexity,
    String? errorMessage,
    List<String>? traversalOrder,
    Set<String>? visited,
    String? currentNode,
    bool? isTraversing,
    String? startNode,
    bool clearCurrent = false,
    bool clearError = false,
  }) {
    return GraphVisualizerState(
      adjacency: adjacency ??
          Map.from(this.adjacency)
              .map((k, v) => MapEntry(k, List<String>.from(v))),
      positions: positions ?? Map.from(this.positions),
      lastOperation: lastOperation ?? this.lastOperation,
      complexity: complexity ?? this.complexity,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      traversalOrder: traversalOrder ?? List.from(this.traversalOrder),
      visited: visited ?? Set.from(this.visited),
      currentNode: clearCurrent ? null : (currentNode ?? this.currentNode),
      isTraversing: isTraversing ?? this.isTraversing,
      startNode: startNode ?? this.startNode,
    );
  }
}

class Offset {
  final double dx, dy;
  const Offset(this.dx, this.dy);
}

class GraphLogic {
  GraphVisualizerState _state;
  final void Function(GraphVisualizerState) onStateChanged;

  GraphLogic({GraphVisualizerState? initialState, required this.onStateChanged})
      : _state = initialState ?? GraphVisualizerState();

  GraphVisualizerState get state => _state;

  void _update(GraphVisualizerState s) {
    _state = s;
    onStateChanged(_state);
  }

  void addNode(String node) {
    final trimmed = node.trim().toUpperCase();
    if (trimmed.isEmpty) {
      _update(_state.copyWith(
        errorMessage: 'Node name cannot be empty',
        lastOperation: 'Add node failed',
      ));
      return;
    }
    if (_state.adjacency.containsKey(trimmed)) {
      _update(_state.copyWith(
        errorMessage: 'Node $trimmed already exists',
        lastOperation: 'Add node failed: duplicate',
      ));
      return;
    }
    final newAdj = Map<String, List<String>>.from(_state.adjacency);
    newAdj[trimmed] = [];
    final newPos = Map<String, Offset>.from(_state.positions);
    // place new node at random-ish position
    final idx = newAdj.length;
    newPos[trimmed] = Offset((idx % 3 - 1) * 80.0, (idx ~/ 3) * 80.0);

    _update(GraphVisualizerState(
      adjacency: newAdj,
      positions: newPos,
      lastOperation: 'Added node $trimmed',
      complexity: 'Add node: O(1)',
    ));
  }

  void addEdge(String from, String to) {
    final f = from.trim().toUpperCase();
    final t = to.trim().toUpperCase();
    if (f.isEmpty || t.isEmpty) {
      _update(_state.copyWith(
        errorMessage: 'Both nodes required',
        lastOperation: 'Add edge failed',
      ));
      return;
    }
    if (!_state.adjacency.containsKey(f) || !_state.adjacency.containsKey(t)) {
      _update(_state.copyWith(
        errorMessage: 'Both nodes must exist. Missing: ${!_state.adjacency.containsKey(f) ? f : ''} ${!_state.adjacency.containsKey(t) ? t : ''}',
        lastOperation: 'Add edge failed',
      ));
      return;
    }
    if (_state.adjacency[f]!.contains(t)) {
      _update(_state.copyWith(
        errorMessage: 'Edge $f → $t already exists',
        lastOperation: 'Add edge failed: duplicate',
      ));
      return;
    }
    final newAdj = Map<String, List<String>>.from(_state.adjacency)
        .map((k, v) => MapEntry(k, List<String>.from(v)));
    newAdj[f]!.add(t);
    _update(GraphVisualizerState(
      adjacency: newAdj,
      positions: _state.positions,
      lastOperation: 'Added edge $f → $t',
      complexity: 'Add edge: O(1)',
    ));
  }

  void removeNode(String node) {
    final n = node.trim().toUpperCase();
    if (!_state.adjacency.containsKey(n)) {
      _update(_state.copyWith(
        errorMessage: 'Node $n does not exist',
        lastOperation: 'Remove failed',
      ));
      return;
    }
    final newAdj = Map<String, List<String>>.from(_state.adjacency)
        .map((k, v) => MapEntry(k, List<String>.from(v)));
    newAdj.remove(n);
    for (var key in newAdj.keys) {
      newAdj[key]!.remove(n);
    }
    final newPos = Map<String, Offset>.from(_state.positions)..remove(n);
    _update(GraphVisualizerState(
      adjacency: newAdj,
      positions: newPos,
      lastOperation: 'Removed node $n and its edges',
      complexity: 'Remove node: O(V+E)',
    ));
  }

  void removeEdge(String from, String to) {
    final f = from.trim().toUpperCase();
    final t = to.trim().toUpperCase();
    if (!_state.adjacency.containsKey(f)) {
      _update(_state.copyWith(
        errorMessage: 'Node $f does not exist',
        lastOperation: 'Remove edge failed',
      ));
      return;
    }
    if (!_state.adjacency[f]!.contains(t)) {
      _update(_state.copyWith(
        errorMessage: 'Edge $f → $t does not exist',
        lastOperation: 'Remove edge failed',
      ));
      return;
    }
    final newAdj = Map<String, List<String>>.from(_state.adjacency)
        .map((k, v) => MapEntry(k, List<String>.from(v)));
    newAdj[f]!.remove(t);
    _update(GraphVisualizerState(
      adjacency: newAdj,
      positions: _state.positions,
      lastOperation: 'Removed edge $f → $t',
      complexity: 'Remove edge: O(E)',
    ));
  }

  Future<void> bfs(String start) async {
    final s = start.trim().toUpperCase();
    if (!_state.adjacency.containsKey(s)) {
      _update(_state.copyWith(
        errorMessage: 'Start node $s does not exist',
        lastOperation: 'BFS failed',
      ));
      return;
    }
    _update(GraphVisualizerState(
      adjacency: _state.adjacency,
      positions: _state.positions,
      lastOperation: 'BFS starting from $s\nBFS explores neighbors level by level using Queue (FIFO)',
      complexity: 'BFS: O(V+E)',
      isTraversing: true,
      startNode: s,
      traversalOrder: [],
      visited: {},
    ));

    Queue<String> queue = Queue();
    Set<String> visited = {};
    List<String> order = [];

    queue.add(s);
    visited.add(s);

    while (queue.isNotEmpty) {
      final current = queue.removeFirst();
      order.add(current);
      _update(GraphVisualizerState(
        adjacency: _state.adjacency,
        positions: _state.positions,
        lastOperation:
            'BFS visiting $current\nVisited: ${order.join(' → ')}\nQueue: ${queue.join(', ')}',
        complexity: 'BFS: O(V+E) — explores level by level',
        traversalOrder: List.from(order),
        visited: Set.from(visited),
        currentNode: current,
        isTraversing: true,
        startNode: s,
      ));
      await Future.delayed(const Duration(milliseconds: 900));

      for (var neighbor in _state.adjacency[current] ?? []) {
        if (!visited.contains(neighbor)) {
          visited.add(neighbor);
          queue.add(neighbor);
        }
      }
    }

    _update(GraphVisualizerState(
      adjacency: _state.adjacency,
      positions: _state.positions,
      lastOperation:
          'BFS complete from $s\nTraversal: ${order.join(' → ')}\nBFS finds shortest path in unweighted graphs',
      complexity: 'BFS: O(V+E)',
      traversalOrder: order,
      visited: visited,
      isTraversing: false,
      startNode: s,
    ));
  }

  Future<void> dfs(String start) async {
    final s = start.trim().toUpperCase();
    if (!_state.adjacency.containsKey(s)) {
      _update(_state.copyWith(
        errorMessage: 'Start node $s does not exist',
        lastOperation: 'DFS failed',
      ));
      return;
    }
    _update(GraphVisualizerState(
      adjacency: _state.adjacency,
      positions: _state.positions,
      lastOperation:
          'DFS starting from $s\nDFS explores as deep as possible before backtracking using Stack',
      complexity: 'DFS: O(V+E)',
      isTraversing: true,
      startNode: s,
      traversalOrder: [],
      visited: {},
    ));

    Set<String> visited = {};
    List<String> order = [];

    await _dfsRecursive(s, visited, order);

    _update(GraphVisualizerState(
      adjacency: _state.adjacency,
      positions: _state.positions,
      lastOperation:
          'DFS complete from $s\nTraversal: ${order.join(' → ')}\nDFS uses stack/recursion, good for topological sort, cycle detection',
      complexity: 'DFS: O(V+E)',
      traversalOrder: order,
      visited: visited,
      isTraversing: false,
      startNode: s,
    ));
  }

  Future<void> _dfsRecursive(
      String node, Set<String> visited, List<String> order) async {
    if (visited.contains(node)) return;
    visited.add(node);
    order.add(node);

    _update(GraphVisualizerState(
      adjacency: _state.adjacency,
      positions: _state.positions,
      lastOperation:
          'DFS visiting $node\nVisited: ${order.join(' → ')}\nStack (recursion): ${order.join(' → ')}',
      complexity: 'DFS: O(V+E) — goes deep first',
      traversalOrder: List.from(order),
      visited: Set.from(visited),
      currentNode: node,
      isTraversing: true,
      startNode: _state.startNode,
    ));
    await Future.delayed(const Duration(milliseconds: 900));

    for (var neighbor in _state.adjacency[node] ?? []) {
      if (!visited.contains(neighbor)) {
        await _dfsRecursive(neighbor, visited, order);
      }
    }
  }

  void reset() {
    _update(GraphVisualizerState(
      lastOperation: 'Graph reset to initial state',
      complexity: 'BFS/DFS: O(V+E)',
    ));
  }

  void clear() {
    _update(GraphVisualizerState(
      adjacency: {},
      positions: {},
      lastOperation: 'Graph cleared',
      complexity: '—',
    ));
  }
}
