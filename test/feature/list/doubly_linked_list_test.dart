import 'package:lab1/feature/list/linked_list.dart';
import 'package:test/test.dart';

void main() {
  // Modify the constructor to test a different implementation
  LinkedList<int> createList() => LinkedList.circular();
  test('.add() must add data to filled list', () {
    final list = createList()..add(0);
    int data = 8;

    list.add(data);

    expect(list[1], equals(data));
  });

  test('.add() must add data to empty list', () {
    final list = createList();
    int data = 8;

    list.add(data);

    expect(list[0], equals(data));
  });

  test('.first of empty list must throw StateError', () {
    expect(() => createList().first, throwsStateError);
  });

  test('.first of filled list', () {
    final list = createList();
    final first = 10;
    list
      ..add(first)
      ..add(first + 1);

    expect(list.first, equals(first));
  });

  test('.last of empty list must throw StateError', () {
    expect(() => createList().last, throwsStateError);
  });

  test('.last of filled list', () {
    final list = createList();
    final last = 10;
    list
      ..add(last - 1)
      ..add(last);

    expect(list.last, equals(last));
  });

  test('.length of empty list', () {
    final list = createList();

    expect(list.length, equals(0));
  });

  test('.length of filled list', () {
    final list = createList();

    int data = 8;
    list.add(data);
    list.add(data + 1);

    expect(list.length, equals(2));
  });

  test('.operator[] of empty list must throw StateError', () {
    expect(() => createList()[0], throwsStateError);
  });

  test(
      '.operator[] of filled list with index out of range must throw RangeError',
      () {
    final list = createList();
    list
      ..add(1)
      ..add(2)
      ..add(3);

    expect(() => list[-1], throwsRangeError);
    expect(() => list[3], throwsRangeError);
  });

  test('.operator[] of filled list', () {
    final list = createList();
    list
      ..add(1)
      ..add(2)
      ..add(3);

    expect(list[0], equals(1));
    expect(list[1], equals(2));
    expect(list[2], equals(3));
  });

  test('.addAfter() of empty list must throw StateError', () {
    expect(() => createList().addAfter(0, 1), throwsStateError);
  });

  test(
      '.addAfter() of filled list with index out of range must throw RangeError',
      () {
    final list = createList();
    list
      ..add(1)
      ..add(2)
      ..add(3);

    expect(() => list.addAfter(-1, 1), throwsRangeError);
    expect(() => list.addAfter(3, 1), throwsRangeError);
  });

  test('.addAfter() of filled list', () {
    final list = createList();
    list
      ..add(1)
      ..add(2)
      ..add(3);
    final data = 10;
    final after = 2;

    list.addAfter(after, data);

    expect(list[after + 1], equals(data));
  });

  test('.addAll() of empty list', () {
    final list = createList();
    final listToAdd = createList()
      ..add(1)
      ..add(2);

    list.addAll(listToAdd);

    expect(list[0], equals(listToAdd[0]));
    expect(list[1], equals(listToAdd[1]));
  });

  test('.addAll() of filled list', () {
    final list = createList()
      ..add(-1)
      ..add(-2);
    final listToAdd = createList()
      ..add(1)
      ..add(2);

    list.addAll(listToAdd);

    expect(list[2], equals(listToAdd[0]));
    expect(list[3], equals(listToAdd[1]));
  });

  test('.addAll() add empty list', () {
    final list = createList();
    final listToAdd = createList();

    list.addAll(listToAdd);

    expect(list.length, equals(0));
  });

  test('.addToStart() of empty list', () {
    final list = createList();
    final data = 23;

    list.addToStart(data);

    expect(list[0], equals(data));
  });

  test('.addToStart() of filled list', () {
    final oldFirst = -1;
    final list = createList()
      ..add(oldFirst)
      ..add(-2);
    final data = 23;

    list.addToStart(data);

    expect(list[0], equals(data));
    expect(list[1], equals(oldFirst));
  });

  test('.clear() of empty list', () {
    final list = createList();
    list.clear();
    expect(list.isEmpty, isTrue);
  });

  test('.clear() of filled list', () {
    final list = createList()..add(1);
    list.clear();
    expect(list.isEmpty, isTrue);
  });

  test('.equals() with empty lists', () {
    final list = createList();
    final other = createList();
    expect(list.equals(other), isTrue);
  });

  test('.equals() with empty list and filled other', () {
    final list = createList();
    final other = createList()..add(1);
    expect(list.equals(other), isFalse);
  });

  test('.equals() with filled list and empty other', () {
    final list = createList()..add(1);
    final other = createList();
    expect(list.equals(other), isFalse);
  });

  test('.equals() with same lists', () {
    final list = createList()..add(1);
    final other = createList()..add(1);
    expect(list.equals(other), isTrue);
  });

  test('.copy() must create other object but with the same data', () {
    final list = createList()..add(1);
    final other = list.copy();
    expect(list == other, isFalse);
    expect(list.equals(other), isTrue);
  });

  test('.deleteFirstWhere() must delete first value', () {
    final first = 1;
    final second = 2;
    final third = 3;
    final list = createList()
      ..add(first)
      ..add(second)
      ..add(first)
      ..add(third);

    list.deleteFirstWhere((p0) => p0 == first);

    expect(list.length, equals(3));
    expect(list[0], equals(second));
    expect(list[1], equals(first));
    expect(list[2], equals(third));
  });

  test('.deleteAllWhere() must delete all values', () {
    final first = 1;
    final second = 2;
    final third = 3;
    final list = createList()
      ..add(first)
      ..add(second)
      ..add(first)
      ..add(third)
      ..add(first);

    list.deleteAllWhere((p0) => p0 == first);

    expect(list.length, equals(2));
    expect(list[0], equals(second));
    expect(list[1], equals(third));
  });
}
