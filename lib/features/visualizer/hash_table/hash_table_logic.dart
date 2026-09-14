class HashTableEntry {
  final String key;
  final String value;
  HashTableEntry(this.key, this.value);
}

class HashTableVisualizerState {
  final List<List<HashTableEntry>> buckets;
  final int bucketCount;
  final String lastOperation;
  final String complexity;
  final String? errorMessage;
  final int? highlightedBucket;
  final String? highlightedKey;
  final bool showCollisionExplanation;
  final String? collisionMessage;

  HashTableVisualizerState({
    List<List<HashTableEntry>>? buckets,
    this.bucketCount = 6,
    this.lastOperation = 'Hash Table initialized',
    this.complexity = 'Insert/Search avg: O(1)',
    this.errorMessage,
    this.highlightedBucket,
    this.highlightedKey,
    this.showCollisionExplanation = false,
    this.collisionMessage,
  }) : buckets = buckets ??
            List.generate(6, (_) => <HashTableEntry>[]);

  HashTableVisualizerState copyWith({
    List<List<HashTableEntry>>? buckets,
    int? bucketCount,
    String? lastOperation,
    String? complexity,
    String? errorMessage,
    int? highlightedBucket,
    String? highlightedKey,
    bool? showCollisionExplanation,
    String? collisionMessage,
    bool clearHighlight = false,
    bool clearError = false,
  }) {
    return HashTableVisualizerState(
      buckets: buckets ??
          this.buckets.map((b) => List<HashTableEntry>.from(b)).toList(),
      bucketCount: bucketCount ?? this.bucketCount,
      lastOperation: lastOperation ?? this.lastOperation,
      complexity: complexity ?? this.complexity,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      highlightedBucket: clearHighlight ? null : (highlightedBucket ?? this.highlightedBucket),
      highlightedKey: clearHighlight ? null : (highlightedKey ?? this.highlightedKey),
      showCollisionExplanation:
          showCollisionExplanation ?? this.showCollisionExplanation,
      collisionMessage: collisionMessage ?? this.collisionMessage,
    );
  }
}

class HashTableLogic {
  HashTableVisualizerState _state;
  final void Function(HashTableVisualizerState) onStateChanged;

  HashTableLogic(
      {HashTableVisualizerState? initialState, required this.onStateChanged})
      : _state = initialState ?? HashTableVisualizerState() {
    // initial demo data
    if (_state.buckets.every((b) => b.isEmpty)) {
      _state = HashTableVisualizerState(
        buckets: [
          <HashTableEntry>[],
          [HashTableEntry('Alex', '25')],
          <HashTableEntry>[],
          [HashTableEntry('Sara', '30'), HashTableEntry('Mohamed', '28')],
          <HashTableEntry>[],
          <HashTableEntry>[],
        ],
        lastOperation: 'Hash Table initialized with sample data\nBucket 3 has collision: Sara and Mohamed',
        complexity: 'Collision detected — separate chaining used',
        highlightedBucket: 3,
        showCollisionExplanation: true,
        collisionMessage:
            'Collision detected!\nBoth keys mapped to bucket 3.\nSeparate chaining stores both entries as linked list.',
      );
      onStateChanged(_state);
    }
  }

  HashTableVisualizerState get state => _state;

  void _update(HashTableVisualizerState s) {
    _state = s;
    onStateChanged(_state);
  }

  int _hash(String key) {
    // Simple hash: sum of char codes % bucketCount
    int sum = key.codeUnits.fold(0, (a, b) => a + b);
    return sum % _state.bucketCount;
  }

  void insert(String key, String value) {
    final k = key.trim();
    final v = value.trim();
    if (k.isEmpty) {
      _update(_state.copyWith(
        errorMessage: 'Key cannot be empty',
        lastOperation: 'Insert failed',
      ));
      return;
    }
    if (v.isEmpty) {
      _update(_state.copyWith(
        errorMessage: 'Value cannot be empty',
        lastOperation: 'Insert failed',
      ));
      return;
    }

    final bucketIndex = _hash(k);
    final newBuckets = _state.buckets.map((b) => List<HashTableEntry>.from(b)).toList();

    // Check if key already exists — update
    final existingIndex = newBuckets[bucketIndex].indexWhere((e) => e.key == k);
    if (existingIndex != -1) {
      newBuckets[bucketIndex][existingIndex] = HashTableEntry(k, v);
      _update(HashTableVisualizerState(
        buckets: newBuckets,
        bucketCount: _state.bucketCount,
        lastOperation: 'Updated key "$k" in bucket $bucketIndex to value "$v"',
        complexity: 'Update: O(1) avg, O(n) worst in chain',
        highlightedBucket: bucketIndex,
        highlightedKey: k,
      ));
      return;
    }

    final hadCollision = newBuckets[bucketIndex].isNotEmpty;
    newBuckets[bucketIndex].add(HashTableEntry(k, v));

    if (hadCollision) {
      _update(HashTableVisualizerState(
        buckets: newBuckets,
        bucketCount: _state.bucketCount,
        lastOperation:
            'Inserted "$k":"$v" into bucket $bucketIndex\nCollision! Bucket already had ${newBuckets[bucketIndex].length - 1} entry(s)',
        complexity: 'Insert with collision: O(n) in chain, avg O(1)',
        highlightedBucket: bucketIndex,
        highlightedKey: k,
        showCollisionExplanation: true,
        collisionMessage:
            'Collision detected!\nBoth keys mapped to bucket $bucketIndex.\nSeparate chaining is being used to store both entries.\n\nHash("$k") = sum(charCodes) % ${_state.bucketCount} = $bucketIndex\nExisting chain: ${newBuckets[bucketIndex].map((e) => e.key).join(' → ')}',
      ));
    } else {
      _update(HashTableVisualizerState(
        buckets: newBuckets,
        bucketCount: _state.bucketCount,
        lastOperation: 'Inserted "$k":"$v" into bucket $bucketIndex\nNo collision — bucket was empty',
        complexity: 'Insert: O(1) avg',
        highlightedBucket: bucketIndex,
        highlightedKey: k,
        showCollisionExplanation: false,
      ));
    }
  }

  void search(String key) {
    final k = key.trim();
    if (k.isEmpty) {
      _update(_state.copyWith(
        errorMessage: 'Key cannot be empty',
        lastOperation: 'Search failed',
      ));
      return;
    }
    final bucketIndex = _hash(k);
    final bucket = _state.buckets[bucketIndex];
    final found = bucket.where((e) => e.key == k).toList();

    if (found.isNotEmpty) {
      _update(_state.copyWith(
        lastOperation:
            'Found "$k" in bucket $bucketIndex → value: "${found.first.value}"\nSearched chain of ${bucket.length} entries',
        complexity: 'Search: O(1) avg, O(n) worst if many collisions',
        highlightedBucket: bucketIndex,
        highlightedKey: k,
        showCollisionExplanation: bucket.length > 1,
        collisionMessage: bucket.length > 1
            ? 'Bucket $bucketIndex has ${bucket.length} entries due to collisions.\nChain: ${bucket.map((e) => e.key).join(' → ')}'
            : null,
        clearError: true,
      ));
    } else {
      _update(_state.copyWith(
        lastOperation:
            'Key "$k" not found in bucket $bucketIndex\nChecked ${bucket.length} entries in chain',
        complexity: 'Not found — O(n) in chain',
        highlightedBucket: bucketIndex,
        highlightedKey: k,
        showCollisionExplanation: false,
        clearError: true,
      ));
    }
  }

  void delete(String key) {
    final k = key.trim();
    if (k.isEmpty) {
      _update(_state.copyWith(
        errorMessage: 'Key cannot be empty',
        lastOperation: 'Delete failed',
      ));
      return;
    }
    final bucketIndex = _hash(k);
    final newBuckets = _state.buckets.map((b) => List<HashTableEntry>.from(b)).toList();
    final beforeLength = newBuckets[bucketIndex].length;
    newBuckets[bucketIndex].removeWhere((e) => e.key == k);
    final afterLength = newBuckets[bucketIndex].length;

    if (beforeLength == afterLength) {
      _update(_state.copyWith(
        errorMessage: 'Key "$k" not found in bucket $bucketIndex',
        lastOperation: 'Delete failed',
      ));
      return;
    }

    _update(HashTableVisualizerState(
      buckets: newBuckets,
      bucketCount: _state.bucketCount,
      lastOperation: 'Deleted "$k" from bucket $bucketIndex\nRemaining in bucket: $afterLength',
      complexity: 'Delete: O(1) avg, O(n) worst',
      highlightedBucket: bucketIndex,
    ));
  }

  void reset() {
    _update(HashTableVisualizerState(
      buckets: [
        <HashTableEntry>[],
        [HashTableEntry('Alex', '25')],
        <HashTableEntry>[],
        [HashTableEntry('Sara', '30'), HashTableEntry('Mohamed', '28')],
        <HashTableEntry>[],
        <HashTableEntry>[],
      ],
      lastOperation: 'Hash Table reset with sample data showing collision at bucket 3',
      complexity: 'Collision demo — separate chaining',
      highlightedBucket: 3,
      showCollisionExplanation: true,
      collisionMessage:
          'Collision detected!\nBoth keys mapped to bucket 3.\nSeparate chaining stores both.',
    ));
  }

  void clear() {
    _update(HashTableVisualizerState(
      buckets: List.generate(_state.bucketCount, (_) => <HashTableEntry>[]),
      lastOperation: 'Hash Table cleared',
      complexity: '—',
    ));
  }
}
