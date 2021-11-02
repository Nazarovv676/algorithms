part of linked_list;

class CircularNode<T> extends ListNode<T> {
  @override
  final T data;
  late CircularNode<T> next;

  CircularNode(this.data);

  @override
  String toString() {
    return '${runtimeType.toString()}(data: $data, next: $next)';
  }
}

class CircularLinkedList<T> implements LinkedList<T> {
  CircularNode<T>? _first;

  @override
  ListNode<T>? get firstNode => _first;

  @override
  bool get isEmpty => _first == null;

  @override
  T get first {
    _maybeThrowEmptyState();
    return _first!.data;
  }

  @override
  T get last {
    _maybeThrowEmptyState();
    return _findLast()!.data;
  }

  @override
  int get length {
    CircularNode<T>? prev = _first;
    CircularNode<T>? next = _first?.next;
    int iterator = 0;
    if (prev != null) {
      iterator++;
    }
    while (next != _first && next != null) {
      iterator++;
      prev = next;
      next = next.next;
    }
    return iterator;
  }

  @override
  T operator [](int index) => _findByIndex(index).data;

  @override
  void add(T value) {
    final newNode = CircularNode(value);
    if (isEmpty) {
      _first = newNode;
    } else {
      _findLast()!.next = newNode;
    }
    newNode.next = _first!;
  }

  @override
  void addAfter(int index, T value) {
    final prev = _findByIndex(index);
    final newNode = CircularNode(value);
    final next = prev.next;
    newNode.next = next;
    prev.next = newNode;
  }

  @override
  void addAll(covariant CircularLinkedList<T> values) {
    if (isEmpty) {
      _first = values._first;
      return;
    }
    values._findLast()?.next = _first!;
    _findLast()!.next = values._first ?? _first!;
  }

  @override
  void addToStart(T value) {
    final newNode = CircularNode(value);
    newNode.next = _first ?? newNode;
    _findLast()?.next = newNode;
    _first = newNode;
  }

  @override
  void clear() {
    _first = null;
  }

  @override
  LinkedList<T> copy() {
    CircularNode<T>? prev = _first;
    CircularNode<T>? next = prev?.next;
    final newList = CircularLinkedList<T>();
    if (prev == null) {
      return newList;
    }
    do {
      newList.add(prev!.data);
      prev = next;
      next = next?.next;
    } while (prev != _first);
    return newList;
  }

  @override
  void deleteFirstWhere(bool Function(T value) callback) {
    _deleteWhere(callback, true);
  }

  @override
  void deleteAllWhere(bool Function(T value) callback) {
    _deleteWhere(callback);
  }

  void _deleteWhere(bool Function(T value) callback,
      [bool breakOnFirst = false]) {
    if (_first != null) {
      // TODO: refactor with while usage
      for (var i = 0; i < length; i++) {
        if (callback.call(this[i])) {
          _deleteNextNode(i == 0 ? null : _findByIndex(i - 1));
          if (breakOnFirst) {
            break;
          }
        }
      }
    }
  }

  @override
  bool equals(covariant CircularLinkedList<T> other) {
    if (length != other.length) {
      return false;
    }
    CircularNode<T>? oPrev = other._first;
    CircularNode<T>? oNext = oPrev?.next;
    CircularNode<T>? prev = _first;
    CircularNode<T>? next = prev?.next;
    if (prev == null && oPrev == null) {
      return true;
    }
    do {
      if (prev!.data != oPrev!.data) {
        return false;
      }
      prev = next;
      next = next?.next;
      oPrev = oNext;
      oNext = oNext?.next;
    } while (prev != _first && oPrev != other._first);
    return true;
  }

  @override
  void sort(Comparator<T> comparator) {
    // TODO: delete List usage
    // Troubles with sort speed. External sort is faster
    final list = List.generate(length, (i) => this[i]);
    list.sort(comparator);
    clear();
    for (var item in list) {
      add(item);
    }
  }

  @override
  bool contains(T value) {
    CircularNode<T>? prev = _first;
    CircularNode<T>? next = _first?.next;
    while (prev != _first && prev != null) {
      if (prev.data == value) {
        return true;
      }
      prev = next;
      next = next?.next;
    }
    return false;
  }

  void _maybeThrowEmptyState() {
    if (isEmpty) {
      throw StateError('List is empty');
    }
  }

  void _deleteNextNode(CircularNode<T>? node) {
    if (!isEmpty) {
      if (node == null) {
        _findLast()?.next = _first!.next;
        _first = _first?.next;
      } else {
        node.next = node.next.next;
      }
    }
  }

  CircularNode<T>? _findLast() {
    CircularNode<T>? prev = _first;
    CircularNode<T>? next = prev?.next;
    while (next != _first && next != null) {
      prev = next;
      next = next.next;
    }
    return prev;
  }

  // Checks [isEmpty]
  CircularNode<T> _findByIndex(int index) {
    _maybeThrowEmptyState();
    RangeError.checkNotNegative(index);

    CircularNode<T> prev = _first!;
    CircularNode<T>? next = _first?.next;
    int iterator = 0;
    while (next != _first && next != null && iterator != index) {
      prev = next;
      next = next.next;
      iterator++;
    }
    if (iterator != index) {
      throw RangeError.range(index, 0, iterator);
    }
    return prev;
  }
}
