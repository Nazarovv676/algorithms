import 'package:console/console.dart';
import 'package:lab1/core/elements/showable.dart';

class DataTable<T> extends Showable<void> {
  final List<String>? header;
  final bool numerate;
  final List<T> data;
  final List<String> Function(T rowData) converter;
  final int columnsCount;
  late final List<int> columnLength;

  DataTable({
    this.header,
    this.numerate = false,
    required this.data,
    required this.converter,
    required this.columnsCount,
    List<int>? columnLength,
  }) {
    assert(columnsCount > 0, 'Columns count can not be less then zero');
    if (header != null) {
      assert(header!.length == columnsCount,
          'Header elements count must match columns count');
    }
    this.columnLength = columnLength ?? List.filled(columnsCount, 15);
  }

  @override
  void show() {
    for (final rowData in data) {
      if (header != null) {}
      final row = converter(rowData);
      if (row.length != columnsCount) {
        throw Exception('Converted data length must match columns count');
      }
      Console.write(row.toString());
    }
  }
}
