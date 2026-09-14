import '../../../core/models/topic.dart';
import '../models/quiz_models.dart';

class QuestionsBank {
  static final List<QuizQuestion> _allQuestions = [
    // Arrays - 10 questions
    QuizQuestion(
      id: 'arr_1',
      topic: DataStructureTopic.arrays,
      difficulty: QuizDifficulty.beginner,
      type: QuizQuestionType.concept,
      question: 'What is the time complexity of accessing an element by index in an array?',
      options: ['O(n)', 'O(log n)', 'O(1)', 'O(n²)'],
      correctAnswerIndex: 2,
      explanation:
          'Arrays store elements in contiguous memory, so any index can be accessed directly via pointer arithmetic. This is constant time O(1).',
      complexityExplanation: 'Access: O(1)',
    ),
    QuizQuestion(
      id: 'arr_2',
      topic: DataStructureTopic.arrays,
      difficulty: QuizDifficulty.beginner,
      type: QuizQuestionType.concept,
      question: 'Which of the following is true about arrays?',
      options: [
        'Arrays have dynamic size in all languages',
        'Arrays store elements of different types',
        'Arrays have fixed size and same type elements',
        'Arrays use non-contiguous memory'
      ],
      correctAnswerIndex: 2,
      explanation:
          'In most low-level languages, arrays have fixed size and store same-type elements in contiguous memory for cache efficiency.',
    ),
    QuizQuestion(
      id: 'arr_3',
      topic: DataStructureTopic.arrays,
      difficulty: QuizDifficulty.intermediate,
      type: QuizQuestionType.predictResult,
      question: 'What will the array contain after these operations?',
      codeSnippet: 'var arr = [10, 20, 30];\narr.insert(1, 15);\narr.removeAt(0);',
      options: [
        '[15, 20, 30]',
        '[10, 15, 20, 30]',
        '[15, 20]',
        '[10, 20, 30]'
      ],
      correctAnswerIndex: 0,
      explanation:
          'Insert 15 at index 1 → [10,15,20,30]. Remove at 0 → [15,20,30]. Insertion/removal in middle requires shifting → O(n).',
      complexityExplanation: 'Insert/Remove middle: O(n)',
    ),
    QuizQuestion(
      id: 'arr_4',
      topic: DataStructureTopic.arrays,
      difficulty: QuizDifficulty.intermediate,
      type: QuizQuestionType.complexity,
      question: 'What is the time complexity of linear search in an unsorted array?',
      options: ['O(1)', 'O(log n)', 'O(n)', 'O(n log n)'],
      correctAnswerIndex: 2,
      explanation:
          'Linear search checks each element one by one until found or end. Worst case visits all n elements → O(n).',
      complexityExplanation: 'Linear search: O(n)',
    ),
    QuizQuestion(
      id: 'arr_5',
      topic: DataStructureTopic.arrays,
      difficulty: QuizDifficulty.beginner,
      type: QuizQuestionType.realWorld,
      question: 'You need to store a 1000x1000 image pixel data for fast random access. Which structure is most appropriate?',
      options: ['Linked List', 'Stack', '2D Array', 'Queue'],
      correctAnswerIndex: 2,
      explanation:
          'Images are naturally represented as 2D arrays/matrices, allowing O(1) access to any pixel via row, column indexes.',
    ),
    QuizQuestion(
      id: 'arr_6',
      topic: DataStructureTopic.arrays,
      difficulty: QuizDifficulty.advanced,
      type: QuizQuestionType.complexity,
      question: 'What is the cost of resizing a dynamic array when capacity is exceeded?',
      options: [
        'O(1) always',
        'O(n) to copy elements, but amortized O(1)',
        'O(log n)',
        'O(n²)'
      ],
      correctAnswerIndex: 1,
      explanation:
          'Resizing allocates new bigger array and copies n elements → O(n), but since it happens rarely, amortized cost per insertion is O(1).',
      complexityExplanation: 'Resize: O(n), amortized O(1)',
    ),
    QuizQuestion(
      id: 'arr_7',
      topic: DataStructureTopic.arrays,
      difficulty: QuizDifficulty.intermediate,
      type: QuizQuestionType.predictResult,
      question: 'Given arr = [1,2,3,4,5], what is arr[2] + arr[4]?',
      codeSnippet: 'int[] arr = {1,2,3,4,5};\n// 0-based indexing',
      options: ['5', '7', '8', '9'],
      correctAnswerIndex: 2,
      explanation: '0-based: arr[2]=3, arr[4]=5, sum=8.',
    ),
    QuizQuestion(
      id: 'arr_8',
      topic: DataStructureTopic.arrays,
      difficulty: QuizDifficulty.beginner,
      type: QuizQuestionType.concept,
      question: 'Which operation is expensive in arrays?',
      options: [
        'Access by index',
        'Insertion at beginning',
        'Reading first element',
        'Getting length'
      ],
      correctAnswerIndex: 1,
      explanation:
          'Insertion at beginning requires shifting all elements right → O(n). Access by index is O(1).',
      complexityExplanation: 'Insert at beginning: O(n)',
    ),
    QuizQuestion(
      id: 'arr_9',
      topic: DataStructureTopic.arrays,
      difficulty: QuizDifficulty.advanced,
      type: QuizQuestionType.complexity,
      question: 'Binary search requires the array to be sorted. What is its time complexity?',
      options: ['O(n)', 'O(log n)', 'O(1)', 'O(n log n)'],
      correctAnswerIndex: 1,
      explanation:
          'Binary search halves the search space each step → O(log n). Much faster than linear O(n) for large arrays.',
      complexityExplanation: 'Binary search: O(log n)',
    ),
    QuizQuestion(
      id: 'arr_10',
      topic: DataStructureTopic.arrays,
      difficulty: QuizDifficulty.intermediate,
      type: QuizQuestionType.realWorld,
      question: 'Why do arrays have excellent cache performance?',
      options: [
        'They use pointers',
        'They are stored in contiguous memory',
        'They are dynamic',
        'They use hashing'
      ],
      correctAnswerIndex: 1,
      explanation:
          'Contiguous memory means CPU cache can load nearby elements efficiently (spatial locality).',
    ),

    // Linked Lists - 10 questions
    QuizQuestion(
      id: 'll_1',
      topic: DataStructureTopic.linkedLists,
      difficulty: QuizDifficulty.beginner,
      type: QuizQuestionType.concept,
      question: 'What does each node in a singly linked list contain?',
      options: [
        'Only data',
        'Data and pointer to next node',
        'Data and pointer to previous node',
        'Two pointers'
      ],
      correctAnswerIndex: 1,
      explanation:
          'Singly linked list node has data and next pointer. Doubly linked has prev and next.',
    ),
    QuizQuestion(
      id: 'll_2',
      topic: DataStructureTopic.linkedLists,
      difficulty: QuizDifficulty.beginner,
      type: QuizQuestionType.concept,
      question: 'What is the time complexity of inserting at the head of a linked list?',
      options: ['O(1)', 'O(n)', 'O(log n)', 'O(n²)'],
      correctAnswerIndex: 0,
      explanation:
          'Insert at head only updates head pointer and new node next → O(1). No shifting needed.',
      complexityExplanation: 'Insert head: O(1)',
    ),
    QuizQuestion(
      id: 'll_3',
      topic: DataStructureTopic.linkedLists,
      difficulty: QuizDifficulty.intermediate,
      type: QuizQuestionType.complexity,
      question: 'What is the time complexity of searching for a value in a linked list?',
      options: ['O(1)', 'O(log n)', 'O(n)', 'O(n log n)'],
      correctAnswerIndex: 2,
      explanation:
          'No random access, must traverse from head node by node → O(n) worst case.',
      complexityExplanation: 'Search: O(n)',
    ),
    QuizQuestion(
      id: 'll_4',
      topic: DataStructureTopic.linkedLists,
      difficulty: QuizDifficulty.intermediate,
      type: QuizQuestionType.predictResult,
      question: 'Head → [10] → [20] → null. After inserting 5 at head, what is the list?',
      options: [
        '[10] → [20] → [5] → null',
        '[5] → [10] → [20] → null',
        '[5] → [20] → null',
        '[10] → [5] → [20] → null'
      ],
      correctAnswerIndex: 1,
      explanation: 'Insert at head makes new node the head: 5 → 10 → 20.',
    ),
    QuizQuestion(
      id: 'll_5',
      topic: DataStructureTopic.linkedLists,
      difficulty: QuizDifficulty.advanced,
      type: QuizQuestionType.concept,
      question: 'Why does linked list have poor cache locality compared to arrays?',
      options: [
        'Nodes are scattered in memory',
        'Nodes are contiguous',
        'It uses hashing',
        'It is fixed size'
      ],
      correctAnswerIndex: 0,
      explanation:
          'Nodes allocated separately via malloc/new can be anywhere in heap, not contiguous, hurting CPU cache.',
    ),
    QuizQuestion(
      id: 'll_6',
      topic: DataStructureTopic.linkedLists,
      difficulty: QuizDifficulty.beginner,
      type: QuizQuestionType.realWorld,
      question: 'Which real-world use case fits linked list well?',
      options: [
        'Image pixel storage',
        'Undo history where you insert/delete at head frequently',
        'Random access lookup table',
        '2D matrix'
      ],
      correctAnswerIndex: 1,
      explanation:
          'Undo history or browser history with frequent insertions at head is O(1) for linked list vs O(n) for array.',
    ),
    QuizQuestion(
      id: 'll_7',
      topic: DataStructureTopic.linkedLists,
      difficulty: QuizDifficulty.intermediate,
      type: QuizQuestionType.predictResult,
      question: 'What happens when you delete the head node?',
      codeSnippet: 'head = head->next;',
      options: [
        'List becomes empty always',
        'Second node becomes new head',
        'Last node becomes head',
        'List is reversed'
      ],
      correctAnswerIndex: 1,
      explanation: 'Deleting head moves head pointer to next node. Second node becomes new head.',
    ),
    QuizQuestion(
      id: 'll_8',
      topic: DataStructureTopic.linkedLists,
      difficulty: QuizDifficulty.advanced,
      type: QuizQuestionType.complexity,
      question: 'What is the extra memory overhead per node in linked list vs array?',
      options: [
        'No overhead',
        'One pointer per node',
        'Two pointers per node always',
        'O(n) pointers total'
      ],
      correctAnswerIndex: 1,
      explanation:
          'Singly linked list stores one extra pointer per node (8 bytes on 64-bit). Doubly stores two.',
    ),
    QuizQuestion(
      id: 'll_9',
      topic: DataStructureTopic.linkedLists,
      difficulty: QuizDifficulty.intermediate,
      type: QuizQuestionType.concept,
      question: 'How do you detect the end of a singly linked list?',
      options: [
        'next == null',
        'data == 0',
        'prev == null',
        'head == null'
      ],
      correctAnswerIndex: 0,
      explanation: 'Last node next pointer is null, indicating end.',
    ),
    QuizQuestion(
      id: 'll_10',
      topic: DataStructureTopic.linkedLists,
      difficulty: QuizDifficulty.beginner,
      type: QuizQuestionType.concept,
      question: 'Linked lists are best when you need:',
      options: [
        'Fast random access',
        'Frequent insertions/deletions at beginning',
        'Small memory footprint',
        'Sorted data'
      ],
      correctAnswerIndex: 1,
      explanation:
          'Frequent insertions at beginning/middle when node is known are O(1). Random access is O(n) poor.',
    ),

    // Stacks - 10 questions
    QuizQuestion(
      id: 'st_1',
      topic: DataStructureTopic.stacks,
      difficulty: QuizDifficulty.beginner,
      type: QuizQuestionType.concept,
      question: 'Which principle does Stack follow?',
      options: ['FIFO', 'LIFO', 'Random', 'Sorted'],
      correctAnswerIndex: 1,
      explanation: 'Stack is LIFO — Last In, First Out. Last pushed is first popped.',
    ),
    QuizQuestion(
      id: 'st_2',
      topic: DataStructureTopic.stacks,
      difficulty: QuizDifficulty.beginner,
      type: QuizQuestionType.concept,
      question: 'What is the time complexity of push and pop in a stack?',
      options: ['O(n)', 'O(log n)', 'O(1)', 'O(n²)'],
      correctAnswerIndex: 2,
      explanation: 'Push/pop only operate on top pointer → O(1).',
      complexityExplanation: 'Push/Pop: O(1)',
    ),
    QuizQuestion(
      id: 'st_3',
      topic: DataStructureTopic.stacks,
      difficulty: QuizDifficulty.intermediate,
      type: QuizQuestionType.predictResult,
      question: 'Stack = [10,20,30] (top is 30). After pop(), what remains?',
      codeSnippet: 'stack = [10, 20, 30]\nstack.removeLast() // pop',
      options: ['[10,20]', '[20,30]', '[10,30]', '[]'],
      correctAnswerIndex: 0,
      explanation: 'Pop removes top element (30). Remaining [10,20] with 20 as new top.',
    ),
    QuizQuestion(
      id: 'st_4',
      topic: DataStructureTopic.stacks,
      difficulty: QuizDifficulty.intermediate,
      type: QuizQuestionType.realWorld,
      question: 'You are implementing Back button in a browser. Which structure is most appropriate?',
      options: ['Queue', 'Stack', 'Array', 'Hash Table'],
      correctAnswerIndex: 1,
      explanation:
          'Browser back navigation is LIFO: last visited page is first to go back to. Stack perfectly models this.',
      realWorldContext: 'Browser history, undo operations, function call stack',
    ),
    QuizQuestion(
      id: 'st_5',
      topic: DataStructureTopic.stacks,
      difficulty: QuizDifficulty.advanced,
      type: QuizQuestionType.concept,
      question: 'What happens if you pop from an empty stack?',
      options: [
        'Returns null always',
        'Stack underflow error',
        'Returns 0',
        'Creates new stack'
      ],
      correctAnswerIndex: 1,
      explanation: 'Popping empty stack causes underflow — should be handled gracefully with error message.',
    ),
    QuizQuestion(
      id: 'st_6',
      topic: DataStructureTopic.stacks,
      difficulty: QuizDifficulty.beginner,
      type: QuizQuestionType.concept,
      question: 'Which operation lets you see top element without removing it?',
      options: ['Push', 'Pop', 'Peek', 'Clear'],
      correctAnswerIndex: 2,
      explanation: 'Peek (or top) returns top element without modifying stack.',
    ),
    QuizQuestion(
      id: 'st_7',
      topic: DataStructureTopic.stacks,
      difficulty: QuizDifficulty.intermediate,
      type: QuizQuestionType.predictResult,
      question: 'Push 10, Push 20, Pop, Push 30. What is top?',
      options: ['10', '20', '30', 'Empty'],
      correctAnswerIndex: 2,
      explanation: '10→[10], 20→[10,20], Pop→[10], 30→[10,30]. Top is 30.',
    ),
    QuizQuestion(
      id: 'st_8',
      topic: DataStructureTopic.stacks,
      difficulty: QuizDifficulty.advanced,
      type: QuizQuestionType.realWorld,
      question: 'Function call stack uses which structure?',
      options: ['Queue', 'Stack', 'Tree', 'Graph'],
      correctAnswerIndex: 1,
      explanation:
          'Function calls are LIFO: last called function must return first. Stack manages call frames.',
    ),
    QuizQuestion(
      id: 'st_9',
      topic: DataStructureTopic.stacks,
      difficulty: QuizDifficulty.intermediate,
      type: QuizQuestionType.complexity,
      question: 'What is space complexity of a stack with n elements?',
      options: ['O(1)', 'O(log n)', 'O(n)', 'O(n²)'],
      correctAnswerIndex: 2,
      explanation: 'Stack stores n elements → O(n) space.',
      complexityExplanation: 'Space: O(n)',
    ),
    QuizQuestion(
      id: 'st_10',
      topic: DataStructureTopic.stacks,
      difficulty: QuizDifficulty.beginner,
      type: QuizQuestionType.concept,
      question: 'Stack is also called:',
      options: [
        'FIFO list',
        'LIFO list',
        'Random list',
        'Sorted list'
      ],
      correctAnswerIndex: 1,
      explanation: 'LIFO list is another name for stack.',
    ),

    // Queues - 9 questions
    QuizQuestion(
      id: 'qu_1',
      topic: DataStructureTopic.queues,
      difficulty: QuizDifficulty.beginner,
      type: QuizQuestionType.concept,
      question: 'Which principle does Queue follow?',
      options: ['LIFO', 'FIFO', 'Random', 'Sorted'],
      correctAnswerIndex: 1,
      explanation: 'Queue is FIFO — First In, First Out. First enqueued is first dequeued.',
    ),
    QuizQuestion(
      id: 'qu_2',
      topic: DataStructureTopic.queues,
      difficulty: QuizDifficulty.beginner,
      type: QuizQuestionType.concept,
      question: 'What are the two ends of a queue called?',
      options: [
        'Top and Bottom',
        'Front and Rear',
        'Head and Tail',
        'Start and End'
      ],
      correctAnswerIndex: 1,
      explanation: 'Enqueue at rear, dequeue from front. Head/Tail also used in some implementations.',
    ),
    QuizQuestion(
      id: 'qu_3',
      topic: DataStructureTopic.queues,
      difficulty: QuizDifficulty.intermediate,
      type: QuizQuestionType.predictResult,
      question: 'Queue: Enqueue 10, Enqueue 20, Dequeue, Enqueue 30. What is front?',
      options: ['10', '20', '30', 'Empty'],
      correctAnswerIndex: 1,
      explanation:
          '10→[10], 20→[10,20], Dequeue→[20], 30→[20,30]. Front is 20, Rear is 30.',
    ),
    QuizQuestion(
      id: 'qu_4',
      topic: DataStructureTopic.queues,
      difficulty: QuizDifficulty.intermediate,
      type: QuizQuestionType.realWorld,
      question: 'Which real-world example uses Queue?',
      options: [
        'Browser back button',
        'Printer job scheduling',
        'Function calls',
        'Undo operation'
      ],
      correctAnswerIndex: 1,
      explanation:
          'Printer jobs: first submitted prints first (FIFO). Browser back is Stack (LIFO).',
      realWorldContext: 'Task scheduling, BFS, printer queue, message queues',
    ),
    QuizQuestion(
      id: 'qu_5',
      topic: DataStructureTopic.queues,
      difficulty: QuizDifficulty.beginner,
      type: QuizQuestionType.complexity,
      question: 'What is time complexity of enqueue and dequeue (with proper implementation)?',
      options: ['O(n)', 'O(1)', 'O(log n)', 'O(n²)'],
      correctAnswerIndex: 1,
      explanation: 'Using linked list or circular array, enqueue/dequeue are O(1).',
      complexityExplanation: 'Enqueue/Dequeue: O(1)',
    ),
    QuizQuestion(
      id: 'qu_6',
      topic: DataStructureTopic.queues,
      difficulty: QuizDifficulty.advanced,
      type: QuizQuestionType.concept,
      question: 'What is a circular queue?',
      options: [
        'Queue that sorts elements',
        'Queue where rear wraps to front when full to reuse space',
        'Queue that reverses order',
        'Queue with only one element'
      ],
      correctAnswerIndex: 1,
      explanation:
          'Circular queue reuses empty space at front when rear reaches end, avoiding shifting.',
    ),
    QuizQuestion(
      id: 'qu_7',
      topic: DataStructureTopic.queues,
      difficulty: QuizDifficulty.intermediate,
      type: QuizQuestionType.predictResult,
      question: 'Queue = [10,20,30] front=10. After dequeue twice, what remains?',
      options: ['[10]', '[20]', '[30]', '[]'],
      correctAnswerIndex: 2,
      explanation: 'Dequeue removes front twice: [10,20,30] → [20,30] → [30].',
    ),
    QuizQuestion(
      id: 'qu_8',
      topic: DataStructureTopic.queues,
      difficulty: QuizDifficulty.advanced,
      type: QuizQuestionType.concept,
      question: 'Which algorithm uses Queue as auxiliary structure?',
      options: ['DFS', 'BFS', 'Binary Search', 'Quick Sort'],
      correctAnswerIndex: 1,
      explanation: 'BFS uses queue to explore level by level (FIFO). DFS uses stack.',
    ),
    QuizQuestion(
      id: 'qu_9',
      topic: DataStructureTopic.queues,
      difficulty: QuizDifficulty.beginner,
      type: QuizQuestionType.concept,
      question: 'What happens when you dequeue from empty queue?',
      options: [
        'Returns 0',
        'Underflow error',
        'Creates new queue',
        'Returns null always'
      ],
      correctAnswerIndex: 1,
      explanation: 'Dequeueing empty queue causes underflow, should handle gracefully.',
    ),

    // Trees - 10 questions
    QuizQuestion(
      id: 'tr_1',
      topic: DataStructureTopic.trees,
      difficulty: QuizDifficulty.beginner,
      type: QuizQuestionType.concept,
      question: 'What is the topmost node of a tree called?',
      options: ['Leaf', 'Root', 'Parent', 'Child'],
      correctAnswerIndex: 1,
      explanation: 'Root is topmost node with no parent. Leaves have no children.',
    ),
    QuizQuestion(
      id: 'tr_2',
      topic: DataStructureTopic.trees,
      difficulty: QuizDifficulty.beginner,
      type: QuizQuestionType.concept,
      question: 'In a Binary Search Tree, where are smaller values stored relative to a node?',
      options: ['Left subtree', 'Right subtree', 'Both', 'Random'],
      correctAnswerIndex: 0,
      explanation: 'BST property: left < node < right. Smaller goes left, larger goes right.',
    ),
    QuizQuestion(
      id: 'tr_3',
      topic: DataStructureTopic.trees,
      difficulty: QuizDifficulty.intermediate,
      type: QuizQuestionType.predictResult,
      question: 'BST insertion order: 50,30,70,20,40. What is root left child?',
      options: ['20', '30', '40', '70'],
      correctAnswerIndex: 1,
      explanation: '50 root, 30 <50 left, 70 right, 20 <50 and <30 left of 30, 40 >30 left subtree right.',
    ),
    QuizQuestion(
      id: 'tr_4',
      topic: DataStructureTopic.trees,
      difficulty: QuizDifficulty.intermediate,
      type: QuizQuestionType.complexity,
      question: 'What is average time complexity of search in balanced BST?',
      options: ['O(n)', 'O(log n)', 'O(1)', 'O(n log n)'],
      correctAnswerIndex: 1,
      explanation: 'Balanced BST height is log n, search traverses height → O(log n). Worst O(n) if skewed.',
      complexityExplanation: 'Balanced BST search: O(log n)',
    ),
    QuizQuestion(
      id: 'tr_5',
      topic: DataStructureTopic.trees,
      difficulty: QuizDifficulty.intermediate,
      type: QuizQuestionType.concept,
      question: 'Which traversal visits nodes in sorted order for BST?',
      options: ['Preorder', 'Inorder', 'Postorder', 'Level order'],
      correctAnswerIndex: 1,
      explanation: 'Inorder (left, root, right) yields sorted order for BST.',
    ),
    QuizQuestion(
      id: 'tr_6',
      topic: DataStructureTopic.trees,
      difficulty: QuizDifficulty.beginner,
      type: QuizQuestionType.concept,
      question: 'What is a leaf node?',
      options: [
        'Node with no children',
        'Node with one child',
        'Root node',
        'Node with two children'
      ],
      correctAnswerIndex: 0,
      explanation: 'Leaf has no children. Internal nodes have at least one child.',
    ),
    QuizQuestion(
      id: 'tr_7',
      topic: DataStructureTopic.trees,
      difficulty: QuizDifficulty.advanced,
      type: QuizQuestionType.predictResult,
      question: 'Tree: 50,30,70,20,40,60,80. Inorder traversal is?',
      options: [
        '20,30,40,50,60,70,80',
        '50,30,20,40,70,60,80',
        '20,40,30,60,80,70,50',
        '50,30,70,20,40,60,80'
      ],
      correctAnswerIndex: 0,
      explanation: 'Inorder left-root-right gives sorted order: 20,30,40,50,60,70,80.',
    ),
    QuizQuestion(
      id: 'tr_8',
      topic: DataStructureTopic.trees,
      difficulty: QuizDifficulty.advanced,
      type: QuizQuestionType.complexity,
      question: 'What is worst-case height of BST with n nodes?',
      options: ['O(log n)', 'O(n)', 'O(1)', 'O(n²)'],
      correctAnswerIndex: 1,
      explanation: 'If inserted sorted, BST becomes skewed like linked list → height n → O(n) search.',
      complexityExplanation: 'Worst BST height: O(n)',
    ),
    QuizQuestion(
      id: 'tr_9',
      topic: DataStructureTopic.trees,
      difficulty: QuizDifficulty.intermediate,
      type: QuizQuestionType.realWorld,
      question: 'Which real-world use uses tree structure?',
      options: [
        'File system hierarchy',
        'Printer queue',
        'Browser back button',
        'Hash table collision'
      ],
      correctAnswerIndex: 0,
      explanation: 'File systems, DOM, organization charts are hierarchical → trees.',
    ),
    QuizQuestion(
      id: 'tr_10',
      topic: DataStructureTopic.trees,
      difficulty: QuizDifficulty.advanced,
      type: QuizQuestionType.concept,
      question: 'Preorder traversal order is:',
      options: [
        'Left, Root, Right',
        'Root, Left, Right',
        'Left, Right, Root',
        'Right, Root, Left'
      ],
      correctAnswerIndex: 1,
      explanation: 'Preorder: Root first, then left, then right. Used to copy tree.',
    ),

    // Graphs - 10 questions
    QuizQuestion(
      id: 'gr_1',
      topic: DataStructureTopic.graphs,
      difficulty: QuizDifficulty.beginner,
      type: QuizQuestionType.concept,
      question: 'What are the two main components of a graph?',
      options: [
        'Root and Leaves',
        'Nodes and Edges',
        'Front and Rear',
        'Top and Bottom'
      ],
      correctAnswerIndex: 1,
      explanation: 'Graph has vertices (nodes) and edges (connections).',
    ),
    QuizQuestion(
      id: 'gr_2',
      topic: DataStructureTopic.graphs,
      difficulty: QuizDifficulty.beginner,
      type: QuizQuestionType.concept,
      question: 'What is BFS?',
      options: [
        'Depth-first exploration',
        'Breadth-first level by level exploration',
        'Binary search',
        'Sorting algorithm'
      ],
      correctAnswerIndex: 1,
      explanation: 'BFS explores neighbors level by level using queue. DFS goes deep using stack.',
    ),
    QuizQuestion(
      id: 'gr_3',
      topic: DataStructureTopic.graphs,
      difficulty: QuizDifficulty.intermediate,
      type: QuizQuestionType.complexity,
      question: 'What is time complexity of BFS and DFS?',
      options: ['O(n)', 'O(log n)', 'O(V+E)', 'O(V²)'],
      correctAnswerIndex: 2,
      explanation: 'Both visit each vertex V and edge E once → O(V+E).',
      complexityExplanation: 'BFS/DFS: O(V+E)',
    ),
    QuizQuestion(
      id: 'gr_4',
      topic: DataStructureTopic.graphs,
      difficulty: QuizDifficulty.intermediate,
      type: QuizQuestionType.concept,
      question: 'Which data structure does BFS use?',
      options: ['Stack', 'Queue', 'Array', 'Tree'],
      correctAnswerIndex: 1,
      explanation: 'BFS uses queue (FIFO) for level order. DFS uses stack (or recursion).',
    ),
    QuizQuestion(
      id: 'gr_5',
      topic: DataStructureTopic.graphs,
      difficulty: QuizDifficulty.intermediate,
      type: QuizQuestionType.predictResult,
      question: 'Graph: A-B, A-C, B-D. BFS starting at A visits:',
      options: [
        'A,B,C,D (level order)',
        'A,B,D,C (deep)',
        'A,C,B,D',
        'A,D,B,C'
      ],
      correctAnswerIndex: 0,
      explanation: 'BFS: A first, then its neighbors B,C, then D (child of B). Level by level.',
    ),
    QuizQuestion(
      id: 'gr_6',
      topic: DataStructureTopic.graphs,
      difficulty: QuizDifficulty.advanced,
      type: QuizQuestionType.realWorld,
      question: 'Which real-world problem is modeled as graph?',
      options: [
        'Social network friendships',
        'Stack of plates',
        'Array indexing',
        'Queue at store'
      ],
      correctAnswerIndex: 0,
      explanation: 'Social networks, maps, internet routing are graphs: people/cities as nodes, relationships/roads as edges.',
    ),
    QuizQuestion(
      id: 'gr_7',
      topic: DataStructureTopic.graphs,
      difficulty: QuizDifficulty.advanced,
      type: QuizQuestionType.concept,
      question: 'What is a directed graph?',
      options: [
        'All edges are bidirectional',
        'Edges have direction (one-way)',
        'No edges',
        'All nodes connected'
      ],
      correctAnswerIndex: 1,
      explanation: 'Directed graph edges have direction: A→B not necessarily B→A. Undirected is bidirectional.',
    ),
    QuizQuestion(
      id: 'gr_8',
      topic: DataStructureTopic.graphs,
      difficulty: QuizDifficulty.intermediate,
      type: QuizQuestionType.concept,
      question: 'DFS is implemented using:',
      options: ['Queue', 'Stack or Recursion', 'Array', 'Hash Table'],
      correctAnswerIndex: 1,
      explanation: 'DFS uses stack (explicit or recursion call stack) to go deep before backtracking.',
    ),
    QuizQuestion(
      id: 'gr_9',
      topic: DataStructureTopic.graphs,
      difficulty: QuizDifficulty.beginner,
      type: QuizQuestionType.concept,
      question: 'What is a cycle in a graph?',
      options: [
        'Path that starts and ends at same node',
        'Node with no edges',
        'Graph with one node',
        'Linear path'
      ],
      correctAnswerIndex: 0,
      explanation: 'Cycle is path that returns to start. Important for detecting loops.',
    ),
    QuizQuestion(
      id: 'gr_10',
      topic: DataStructureTopic.graphs,
      difficulty: QuizDifficulty.advanced,
      type: QuizQuestionType.complexity,
      question: 'BFS finds shortest path in:',
      options: [
        'Weighted graph with negative weights',
        'Unweighted graph',
        'Any graph',
        'Only trees'
      ],
      correctAnswerIndex: 1,
      explanation: 'BFS finds shortest path in unweighted graphs (fewest edges). For weighted, need Dijkstra.',
    ),

    // Hash Tables - 10 questions
    QuizQuestion(
      id: 'ht_1',
      topic: DataStructureTopic.hashTables,
      difficulty: QuizDifficulty.beginner,
      type: QuizQuestionType.concept,
      question: 'What is the average time complexity of lookup in a hash table?',
      options: ['O(n)', 'O(log n)', 'O(1)', 'O(n²)'],
      correctAnswerIndex: 2,
      explanation: 'Hash table gives O(1) average lookup via hash function, worst O(n) with many collisions.',
      complexityExplanation: 'Hash lookup avg: O(1)',
    ),
    QuizQuestion(
      id: 'ht_2',
      topic: DataStructureTopic.hashTables,
      difficulty: QuizDifficulty.beginner,
      type: QuizQuestionType.concept,
      question: 'What is a hash collision?',
      options: [
        'Two keys map to same bucket',
        'Hash table is full',
        'Key not found',
        'Table is empty'
      ],
      correctAnswerIndex: 0,
      explanation: 'Collision when hash function maps different keys to same index/bucket.',
    ),
    QuizQuestion(
      id: 'ht_3',
      topic: DataStructureTopic.hashTables,
      difficulty: QuizDifficulty.intermediate,
      type: QuizQuestionType.concept,
      question: 'Which collision resolution uses chaining?',
      options: [
        'Store colliding entries in linked list at same bucket',
        'Find next empty slot',
        'Double hashing',
        'Resize immediately'
      ],
      correctAnswerIndex: 0,
      explanation: 'Separate chaining stores multiple entries in same bucket via linked list or list.',
    ),
    QuizQuestion(
      id: 'ht_4',
      topic: DataStructureTopic.hashTables,
      difficulty: QuizDifficulty.intermediate,
      type: QuizQuestionType.predictResult,
      question: 'Hash function h(key)=key%5. Keys 1,6,11 all map to bucket 1. This is:',
      options: ['No collision', 'Collision', 'Overflow', 'Underflow'],
      correctAnswerIndex: 1,
      explanation: 'All map to bucket 1 → collision. Chaining would store [1→6→11] at bucket 1.',
    ),
    QuizQuestion(
      id: 'ht_5',
      topic: DataStructureTopic.hashTables,
      difficulty: QuizDifficulty.advanced,
      type: QuizQuestionType.complexity,
      question: 'Worst-case lookup in hash table with chaining and n keys in same bucket?',
      options: ['O(1)', 'O(log n)', 'O(n)', 'O(n log n)'],
      correctAnswerIndex: 2,
      explanation: 'If all keys collide into one bucket, lookup becomes linear search O(n) in that chain.',
      complexityExplanation: 'Worst lookup: O(n)',
    ),
    QuizQuestion(
      id: 'ht_6',
      topic: DataStructureTopic.hashTables,
      difficulty: QuizDifficulty.beginner,
      type: QuizQuestionType.realWorld,
      question: 'Which real-world use fits hash table?',
      options: [
        'Dictionary word lookup',
        'Sorting numbers',
        'Level order traversal',
        'Undo history'
      ],
      correctAnswerIndex: 0,
      explanation: 'Dictionary, cache, database indexing use hash tables for O(1) key lookup.',
    ),
    QuizQuestion(
      id: 'ht_7',
      topic: DataStructureTopic.hashTables,
      difficulty: QuizDifficulty.intermediate,
      type: QuizQuestionType.concept,
      question: 'What is load factor?',
      options: [
        'Number of buckets',
        'Ratio of entries to buckets (n/m)',
        'Hash function complexity',
        'Number of collisions'
      ],
      correctAnswerIndex: 1,
      explanation: 'Load factor = entries/buckets. High load factor → more collisions, need resizing.',
    ),
    QuizQuestion(
      id: 'ht_8',
      topic: DataStructureTopic.hashTables,
      difficulty: QuizDifficulty.advanced,
      type: QuizQuestionType.concept,
      question: 'Open addressing resolves collisions by:',
      options: [
        'Chaining at same bucket',
        'Probing for next empty slot',
        'Using tree',
        'Ignoring collision'
      ],
      correctAnswerIndex: 1,
      explanation: 'Open addressing finds another empty slot via linear/quadratic probing or double hashing.',
    ),
    QuizQuestion(
      id: 'ht_9',
      topic: DataStructureTopic.hashTables,
      difficulty: QuizDifficulty.intermediate,
      type: QuizQuestionType.predictResult,
      question: 'Hash table with 5 buckets, h(key)=len(key)%5. Keys: "Alex"(4), "Sara"(4) → bucket?',
      options: ['Different buckets', 'Same bucket 4 → collision', 'Bucket 0', 'Error'],
      correctAnswerIndex: 1,
      explanation: 'Both length 4 → bucket 4 → collision. Chaining stores both: Sara→Alex or vice versa.',
    ),
    QuizQuestion(
      id: 'ht_10',
      topic: DataStructureTopic.hashTables,
      difficulty: QuizDifficulty.beginner,
      type: QuizQuestionType.concept,
      question: 'Hash table is also called:',
      options: ['Hash map', 'Stack', 'Queue', 'Tree'],
      correctAnswerIndex: 0,
      explanation: 'Hash map, dictionary, associative array are synonyms for hash table.',
    ),
  ];

  static List<QuizQuestion> getAll() => List.unmodifiable(_allQuestions);

  static List<QuizQuestion> getByTopic(DataStructureTopic topic) {
    return _allQuestions.where((q) => q.topic == topic).toList();
  }

  static List<QuizQuestion> getByTopicAndDifficulty(
      DataStructureTopic topic, QuizDifficulty difficulty) {
    return _allQuestions
        .where((q) => q.topic == topic && q.difficulty == difficulty)
        .toList();
  }

  static List<QuizQuestion> getRecommended(
      {DataStructureTopic? topic, QuizDifficulty? difficulty, int count = 10}) {
    var filtered = _allQuestions;
    if (topic != null) {
      filtered = filtered.where((q) => q.topic == topic).toList();
    }
    if (difficulty != null) {
      filtered = filtered.where((q) => q.difficulty == difficulty).toList();
    }
    filtered.shuffle();
    return filtered.take(count).toList();
  }
}
