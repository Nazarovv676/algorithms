library linked_list;

part 'singly_linked_list.dart';
part 'node.dart';

abstract class LinkedList<T> {
  factory LinkedList() = _SinglyLinkedList<T>;

  T get first;
  T get last;

  T operator [](int index);

  int get length;

  bool get isEmpty;

  void add(T value);
  void addToStart(T value);
  void addAfter(int index, T value);
  void addAll(LinkedList<T> values);

  void deleteFirstWhere(bool Function(T) callback);
  void deleteAllWhere(bool Function(T) callback);

  void sort(Comparator<T> comparator);

  LinkedList<T> copy();

  void clear();

  bool contains(T value);

  bool equals(LinkedList<T> other);
}
