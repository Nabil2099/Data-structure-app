enum DataStructureTopic {
  arrays,
  linkedLists,
  stacks,
  queues,
  trees,
  graphs,
  hashTables;

  String get displayName {
    switch (this) {
      case DataStructureTopic.arrays:
        return 'Arrays';
      case DataStructureTopic.linkedLists:
        return 'Linked Lists';
      case DataStructureTopic.stacks:
        return 'Stacks';
      case DataStructureTopic.queues:
        return 'Queues';
      case DataStructureTopic.trees:
        return 'Trees';
      case DataStructureTopic.graphs:
        return 'Graphs';
      case DataStructureTopic.hashTables:
        return 'Hash Tables';
    }
  }

  String get description {
    switch (this) {
      case DataStructureTopic.arrays:
        return 'Contiguous memory, O(1) random access';
      case DataStructureTopic.linkedLists:
        return 'Dynamic nodes linked by pointers';
      case DataStructureTopic.stacks:
        return 'LIFO — Last In, First Out';
      case DataStructureTopic.queues:
        return 'FIFO — First In, First Out';
      case DataStructureTopic.trees:
        return 'Hierarchical parent-child structure';
      case DataStructureTopic.graphs:
        return 'Nodes connected by edges';
      case DataStructureTopic.hashTables:
        return 'Key-value with hash collisions';
    }
  }

  // Recommended learning order
  static List<DataStructureTopic> get learningOrder => [
        arrays,
        linkedLists,
        stacks,
        queues,
        hashTables,
        trees,
        graphs,
      ];

  int get orderIndex => learningOrder.indexOf(this);
}

enum QuizDifficulty { beginner, intermediate, advanced }

extension QuizDifficultyX on QuizDifficulty {
  String get displayName {
    switch (this) {
      case QuizDifficulty.beginner:
        return 'Beginner';
      case QuizDifficulty.intermediate:
        return 'Intermediate';
      case QuizDifficulty.advanced:
        return 'Advanced';
    }
  }
}

enum QuizQuestionType { concept, predictResult, realWorld, complexity }

extension QuizQuestionTypeX on QuizQuestionType {
  String get displayName {
    switch (this) {
      case QuizQuestionType.concept:
        return 'Concept';
      case QuizQuestionType.predictResult:
        return 'Predict Result';
      case QuizQuestionType.realWorld:
        return 'Real-World';
      case QuizQuestionType.complexity:
        return 'Complexity';
    }
  }
}
