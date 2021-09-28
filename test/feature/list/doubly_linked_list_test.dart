import 'package:lab1/feature/list/linked_list.dart';

import 'linked_list_test.dart';

void main() {
  // Modify the constructor to test a different implementation
  LinkedList<int> createList() => LinkedList.doubly();
  linkedListTester(createList);
}
