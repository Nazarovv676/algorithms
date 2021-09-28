part of linked_list;

class _SinglyLinkedList<T> implements LinkedList<T> {
  _ListNode<T>? _first;

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
    _ListNode<T>? prev = _first;
    _ListNode<T>? next = _first?.next;
    int iterator = 0;
    if (prev != null) {
      iterator = 1;
    }
    while (next != null) {
      prev = next;
      next = next.next;
      iterator++;
    }
    return iterator;
  }

  @override
  T operator [](int index) => _findByIndex(index).data;

  @override
  void add(T value) {
    final newNode = _ListNode(value);
    if (isEmpty) {
      _first = newNode;
    } else {
      _findLast()!.next = newNode;
    }
  }

  @override
  void addAfter(int index, T value) {
    final prev = _findByIndex(index);
    final newNode = _ListNode(value);
    final next = prev.next;
    newNode.next = next;
    prev.next = newNode;
  }

  @override
  void addAll(covariant _SinglyLinkedList<T> values) {
    if (isEmpty) {
      _first = values._first;
      return;
    }
    _findLast()!.next = values._first;
  }

  @override
  void addToStart(T value) {
    final newNode = _ListNode(value);
    newNode.next = _first;
    _first = newNode;
  }

  @override
  void clear() {
    _first = null;
  }

  @override
  LinkedList<T> copy() {
    _ListNode<T>? prev = _first;
    _ListNode<T>? next = prev?.next;
    final newList = _SinglyLinkedList<T>();
    if (prev != null) {
      newList.add(prev.data);
    }
    while (next != null) {
      newList.add(next.data);
      prev = next;
      next = next.next;
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
    _ListNode<T>? prevPrev;
    _ListNode<T>? prev = _first;
    _ListNode<T>? next = prev?.next;
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
  bool equals(covariant _SinglyLinkedList<T> other) {
    if (length != other.length) {
      return false;
    }
    _ListNode<T>? oPrev = other._first;
    _ListNode<T>? oNext = oPrev?.next;
    _ListNode<T>? prev = _first;
    _ListNode<T>? next = prev?.next;
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
    _ListNode<T>? prev = _first;
    if (prev?.data == value) {
      return true;
    }
    _ListNode<T>? next = _first?.next;
    while (next != null) {
      prev = next;
      next = next.next;
      if (prev.data == value) {
        return true;
      }
    }
    return false;
  }

  int? _indexOfFirst(T value) {
    _ListNode<T>? prev = _first;
    _ListNode<T>? next = _first?.next;
    int iterator = 0;
    while (prev != null) {
      if (prev.data == value) {
        return iterator++;
      }
      prev = next;
      next = next?.next;
      iterator++;
    }
  }

  void _maybeThrowEmptyState() {
    if (isEmpty) {
      throw StateError('List is empty');
    }
  }

  void _deleteNextNode(_ListNode<T>? node) {
    if (node == null) {
      _first = _first?.next;
    } else {
      node.next = node.next?.next;
    }
  }

  _ListNode<T>? _findLast() {
    _ListNode<T>? prev = _first;
    _ListNode<T>? next = prev?.next;
    while (next != null) {
      prev = next;
      next = next.next;
    }
    return prev;
  }

  // Checks [isEmpty]
  _ListNode<T> _findByIndex(int index) {
    _maybeThrowEmptyState();
    RangeError.checkNotNegative(index);

    _ListNode<T> prev = _first!;
    _ListNode<T>? next = _first?.next;
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
