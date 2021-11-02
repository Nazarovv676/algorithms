part of linked_list;

class SinglyNode<T> extends ListNode<T> {
  @override
  final T data;
  SinglyNode<T>? next;

  SinglyNode(this.data);

  @override
  String toString() {
    return '${runtimeType.toString()}(data: $data, next: $next)';
  }
}

class SinglyLinkedList<T> implements LinkedList<T> {
  SinglyNode<T>? _first;

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
    SinglyNode<T>? prev = _first;
    SinglyNode<T>? next = _first?.next;
    int iterator = 0;
    while (prev != null) {
      prev = next;
      next = next?.next;
      iterator++;
    }
    return iterator;
  }

  @override
  T operator [](int index) => _findByIndex(index).data;

  @override
  void add(T value) {
    final newNode = SinglyNode(value);
    if (isEmpty) {
      _first = newNode;
    } else {
      _findLast()!.next = newNode;
    }
  }

  @override
  void addAfter(int index, T value) {
    final prev = _findByIndex(index);
    final newNode = SinglyNode(value);
    final next = prev.next;
    newNode.next = next;
    prev.next = newNode;
  }

  @override
  void addAll(covariant SinglyLinkedList<T> values) {
    if (isEmpty) {
      _first = values._first;
      return;
    }
    _findLast()!.next = values._first;
  }

  @override
  void addToStart(T value) {
    final newNode = SinglyNode(value);
    newNode.next = _first;
    _first = newNode;
  }

  @override
  void clear() {
    _first = null;
  }

  @override
  LinkedList<T> copy() {
    SinglyNode<T>? prev = _first;
    SinglyNode<T>? next = prev?.next;
    final newList = SinglyLinkedList<T>();
    while (prev != null) {
      newList.add(prev.data);
      prev = next;
      next = next?.next;
    }
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
    SinglyNode<T>? prevPrev;
    SinglyNode<T>? prev = _first;
    SinglyNode<T>? next = prev?.next;
    while (prev != null) {
      if (callback.call(prev.data)) {
        _deleteNextNode(prevPrev);
        if (breakOnFirst) {
          break;
        }
      }
      prevPrev = prev;
      prev = next;
      next = next?.next;
    }
  }

  @override
  bool equals(covariant SinglyLinkedList<T> other) {
    if (length != other.length) {
      return false;
    }
    SinglyNode<T>? oPrev = other._first;
    SinglyNode<T>? oNext = oPrev?.next;
    SinglyNode<T>? prev = _first;
    SinglyNode<T>? next = prev?.next;
    while (prev != null && oPrev != null) {
      if (prev.data != oPrev.data) {
        return false;
      }
      prev = next;
      next = next?.next;
      oPrev = oNext;
      oNext = oNext?.next;
    }
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
    SinglyNode<T>? prev = _first;
    SinglyNode<T>? next = _first?.next;
    while (prev != null) {
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

  void _deleteNextNode(SinglyNode<T>? node) {
    if (node == null) {
      _first = _first?.next;
    } else {
      node.next = node.next?.next;
    }
  }

  SinglyNode<T>? _findLast() {
    SinglyNode<T>? prev = _first;
    SinglyNode<T>? next = prev?.next;
    while (next != null) {
      prev = next;
      next = next.next;
    }
    return prev;
  }

  // Checks [isEmpty]
  SinglyNode<T> _findByIndex(int index) {
    _maybeThrowEmptyState();
    RangeError.checkNotNegative(index);

    SinglyNode<T> prev = _first!;
    SinglyNode<T>? next = _first?.next;
    int iterator = 0;
    while (next != null && iterator != index) {
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
