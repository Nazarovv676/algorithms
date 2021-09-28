part of linked_list;

class _DoublyLinkedList<T> implements LinkedList<T> {
  @override
  T operator [](int index) {
    // TODO: implement []
    throw UnimplementedError();
  }

  @override
  void add(T value) {
    // TODO: implement add
  }

  @override
  void addAfter(int index, T value) {
    // TODO: implement addAfter
  }

  @override
  void addAll(LinkedList<T> values) {
    // TODO: implement addAll
  }

  @override
  void addToStart(T value) {
    // TODO: implement addToStart
  }

  @override
  void clear() {
    // TODO: implement clear
  }

  @override
  bool contains(T value) {
    // TODO: implement contains
    throw UnimplementedError();
  }

  @override
  LinkedList<T> copy() {
    // TODO: implement copy
    throw UnimplementedError();
  }

  @override
  void deleteAllWhere(bool Function(T p1) callback) {
    // TODO: implement deleteAllWhere
  }

  @override
  void deleteFirstWhere(bool Function(T p1) callback) {
    // TODO: implement deleteFirstWhere
  }

  @override
  bool equals(LinkedList<T> other) {
    // TODO: implement equals
    throw UnimplementedError();
  }

  @override
  // TODO: implement first
  T get first => throw UnimplementedError();

  @override
  // TODO: implement isEmpty
  bool get isEmpty => throw UnimplementedError();

  @override
  // TODO: implement last
  T get last => throw UnimplementedError();

  @override
  // TODO: implement length
  int get length => throw UnimplementedError();

  @override
  void sort(Comparator<T> comparator) {
    // TODO: implement sort
  }
}
