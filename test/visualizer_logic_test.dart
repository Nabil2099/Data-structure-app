import 'package:flutter_test/flutter_test.dart';
import 'package:datastructure/features/visualizer/array/array_logic.dart';
import 'package:datastructure/features/visualizer/stack/stack_logic.dart';
import 'package:datastructure/features/visualizer/queue/queue_logic.dart';
import 'package:datastructure/features/visualizer/linked_list/linked_list_logic.dart';
import 'package:datastructure/features/visualizer/tree/tree_logic.dart';
import 'package:datastructure/features/visualizer/graph/graph_logic.dart';
import 'package:datastructure/features/visualizer/hash_table/hash_table_logic.dart';

void main() {
  group('Array Logic', () {
    test('insert at valid index', () {
      late ArrayVisualizerState state;
      final logic = ArrayLogic(
        initialState: ArrayVisualizerState(array: [1, 2, 3]),
        onStateChanged: (s) => state = s,
      );
      logic.insert(1, 99);
      expect(state.array, [1, 99, 2, 3]);
      expect(state.lastOperation, contains('99'));
    });

    test('insert at invalid index shows error', () {
      late ArrayVisualizerState state;
      final logic = ArrayLogic(
        initialState: ArrayVisualizerState(array: [1, 2]),
        onStateChanged: (s) => state = s,
      );
      logic.insert(10, 5);
      expect(state.errorMessage, isNotNull);
    });

    test('update valid index', () {
      late ArrayVisualizerState state;
      final logic = ArrayLogic(
        initialState: ArrayVisualizerState(array: [10, 20, 30]),
        onStateChanged: (s) => state = s,
      );
      logic.update(1, 99);
      expect(state.array[1], 99);
    });

    test('removeAt', () {
      late ArrayVisualizerState state;
      final logic = ArrayLogic(
        initialState: ArrayVisualizerState(array: [10, 20, 30]),
        onStateChanged: (s) => state = s,
      );
      logic.removeAt(1);
      expect(state.array, [10, 30]);
    });

    test('reset restores initial', () {
      late ArrayVisualizerState state;
      final logic = ArrayLogic(
        initialState: ArrayVisualizerState(array: [1, 2]),
        onStateChanged: (s) => state = s,
      );
      logic.reset();
      expect(state.array.isNotEmpty, true);
    });
  });

  group('Stack Logic', () {
    test('push adds to top', () {
      late StackVisualizerState state;
      final logic = StackLogic(
        initialState: StackVisualizerState(stack: [10, 20]),
        onStateChanged: (s) => state = s,
      );
      logic.push(30);
      expect(state.stack, [10, 20, 30]);
      expect(state.top, 30);
    });

    test('pop removes top', () {
      late StackVisualizerState state;
      final logic = StackLogic(
        initialState: StackVisualizerState(stack: [10, 20, 30]),
        onStateChanged: (s) => state = s,
      );
      logic.pop();
      expect(state.stack, [10, 20]);
    });

    test('pop empty shows error', () {
      late StackVisualizerState state;
      final logic = StackLogic(
        initialState: StackVisualizerState(stack: []),
        onStateChanged: (s) => state = s,
      );
      logic.pop();
      expect(state.errorMessage, isNotNull);
    });

    test('peek shows top', () {
      late StackVisualizerState state;
      final logic = StackLogic(
        initialState: StackVisualizerState(stack: [10, 20]),
        onStateChanged: (s) => state = s,
      );
      logic.peek();
      expect(state.peekIndex, 1);
    });

    test('LIFO behavior', () {
      late StackVisualizerState state;
      final logic = StackLogic(
        initialState: StackVisualizerState(stack: []),
        onStateChanged: (s) => state = s,
      );
      logic.push(1);
      logic.push(2);
      logic.push(3);
      expect(state.stack, [1, 2, 3]);
      logic.pop();
      expect(state.stack, [1, 2]);
      expect(state.top, 2);
    });
  });

  group('Queue Logic', () {
    test('enqueue adds at rear', () {
      late QueueVisualizerState state;
      final logic = QueueLogic(
        initialState: QueueVisualizerState(queue: [10, 20]),
        onStateChanged: (s) => state = s,
      );
      logic.enqueue(30);
      expect(state.queue, [10, 20, 30]);
      expect(state.rear, 30);
    });

    test('dequeue removes from front', () {
      late QueueVisualizerState state;
      final logic = QueueLogic(
        initialState: QueueVisualizerState(queue: [10, 20, 30]),
        onStateChanged: (s) => state = s,
      );
      logic.dequeue();
      expect(state.queue, [20, 30]);
      expect(state.front, 20);
    });

    test('dequeue empty shows error', () {
      late QueueVisualizerState state;
      final logic = QueueLogic(
        initialState: QueueVisualizerState(queue: []),
        onStateChanged: (s) => state = s,
      );
      logic.dequeue();
      expect(state.errorMessage, isNotNull);
    });

    test('FIFO behavior', () {
      late QueueVisualizerState state;
      final logic = QueueLogic(
        initialState: QueueVisualizerState(queue: []),
        onStateChanged: (s) => state = s,
      );
      logic.enqueue(1);
      logic.enqueue(2);
      logic.enqueue(3);
      expect(state.queue, [1, 2, 3]);
      logic.dequeue();
      expect(state.queue, [2, 3]);
      expect(state.front, 2);
    });
  });

  group('Linked List Logic', () {
    test('insert at beginning', () {
      late LinkedListVisualizerState state;
      final logic = LinkedListLogic(
        initialState: LinkedListVisualizerState(nodes: [10, 20]),
        onStateChanged: (s) => state = s,
      );
      logic.insertAtBeginning(5);
      expect(state.nodes, [5, 10, 20]);
    });

    test('insert at end', () {
      late LinkedListVisualizerState state;
      final logic = LinkedListLogic(
        initialState: LinkedListVisualizerState(nodes: [10, 20]),
        onStateChanged: (s) => state = s,
      );
      logic.insertAtEnd(30);
      expect(state.nodes, [10, 20, 30]);
    });

    test('delete existing value', () {
      late LinkedListVisualizerState state;
      final logic = LinkedListLogic(
        initialState: LinkedListVisualizerState(nodes: [10, 20, 30]),
        onStateChanged: (s) => state = s,
      );
      logic.delete(20);
      expect(state.nodes, [10, 30]);
    });

    test('delete non-existing shows error', () {
      late LinkedListVisualizerState state;
      final logic = LinkedListLogic(
        initialState: LinkedListVisualizerState(nodes: [10, 20]),
        onStateChanged: (s) => state = s,
      );
      logic.delete(99);
      expect(state.errorMessage, isNotNull);
    });
  });

  group('Tree Logic', () {
    test('BST insertion maintains property', () {
      late TreeVisualizerState state;
      final logic = TreeLogic(
        initialState: TreeVisualizerState(values: []),
        onStateChanged: (s) => state = s,
      );
      logic.insert(50);
      logic.insert(30);
      logic.insert(70);
      expect(state.values, containsAll([50, 30, 70]));
      expect(state.root?.value, 50);
    });

    test('BST duplicate not allowed', () {
      late TreeVisualizerState state;
      final logic = TreeLogic(
        initialState: TreeVisualizerState(values: [50, 30]),
        onStateChanged: (s) => state = s,
      );
      logic.insert(30);
      expect(state.errorMessage, isNotNull);
    });

    test('BST delete', () {
      late TreeVisualizerState state;
      final logic = TreeLogic(
        initialState: TreeVisualizerState(values: [50, 30, 70]),
        onStateChanged: (s) => state = s,
      );
      logic.delete(30);
      expect(state.values, isNot(contains(30)));
    });

    test('BST traversals produce correct counts', () async {
      late TreeVisualizerState state;
      final logic = TreeLogic(
        initialState: TreeVisualizerState(values: [50, 30, 70, 20, 40]),
        onStateChanged: (s) => state = s,
      );
      await logic.inorderTraversal();
      expect(state.traversalResult.length, 5);
      // inorder should be sorted
      final sorted = List<int>.from(state.traversalResult)..sort();
      expect(state.traversalResult, sorted);
    });
  });

  group('Graph Logic', () {
    test('add node', () {
      late GraphVisualizerState state;
      final logic = GraphLogic(
        initialState: GraphVisualizerState(adjacency: {}, positions: {}),
        onStateChanged: (s) => state = s,
      );
      logic.addNode('A');
      expect(state.adjacency.containsKey('A'), true);
    });

    test('add duplicate node shows error', () {
      late GraphVisualizerState state;
      final logic = GraphLogic(
        initialState: GraphVisualizerState(adjacency: {'A': []}, positions: {}),
        onStateChanged: (s) => state = s,
      );
      logic.addNode('A');
      expect(state.errorMessage, isNotNull);
    });

    test('add edge', () {
      late GraphVisualizerState state;
      final logic = GraphLogic(
        initialState: GraphVisualizerState(adjacency: {'A': [], 'B': []}, positions: {}),
        onStateChanged: (s) => state = s,
      );
      logic.addEdge('A', 'B');
      expect(state.adjacency['A'], contains('B'));
    });

    test('BFS traversal order', () async {
      late GraphVisualizerState state;
      final logic = GraphLogic(
        initialState: GraphVisualizerState(
          adjacency: {
            'A': ['B', 'C'],
            'B': ['D'],
            'C': [],
            'D': [],
          },
          positions: {},
        ),
        onStateChanged: (s) => state = s,
      );
      await logic.bfs('A');
      expect(state.traversalOrder.first, 'A');
      expect(state.traversalOrder.length, 4);
    });

    test('DFS traversal order', () async {
      late GraphVisualizerState state;
      final logic = GraphLogic(
        initialState: GraphVisualizerState(
          adjacency: {
            'A': ['B', 'C'],
            'B': ['D'],
            'C': [],
            'D': [],
          },
          positions: {},
        ),
        onStateChanged: (s) => state = s,
      );
      await logic.dfs('A');
      expect(state.traversalOrder.first, 'A');
      expect(state.traversalOrder.length, 4);
    });
  });

  group('Hash Table Logic', () {
    test('insert and search', () {
      late HashTableVisualizerState state;
      final logic = HashTableLogic(
        initialState: HashTableVisualizerState(buckets: List.generate(6, (_) => [])),
        onStateChanged: (s) => state = s,
      );
      logic.insert('key1', 'value1');
      expect(state.buckets.expand((b) => b).any((e) => e.key == 'key1'), true);
    });

    test('collision detection', () {
      late HashTableVisualizerState state;
      final logic = HashTableLogic(
        initialState: HashTableVisualizerState(buckets: List.generate(5, (_) => []), bucketCount: 5),
        onStateChanged: (s) => state = s,
      );
      // Keys with same hash: using sum %5, 'a'(97%5=2), 'f'(102%5=2) both 2
      logic.insert('a', '1');
      logic.insert('f', '2');
      expect(state.showCollisionExplanation, true);
      expect(state.buckets[2].length, 2);
    });

    test('delete key', () {
      late HashTableVisualizerState state;
      final logic = HashTableLogic(
        initialState: HashTableVisualizerState(buckets: List.generate(6, (_) => [])),
        onStateChanged: (s) => state = s,
      );
      logic.insert('test', 'val');
      logic.delete('test');
      expect(state.buckets.expand((b) => b).any((e) => e.key == 'test'), false);
    });
  });
}
