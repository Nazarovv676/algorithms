import 'package:console/console.dart';
import 'package:lab1/core/elements/showable.dart';

const _columnDivider = '|';
const _rowDivider = '-';

class DataTable extends Showable<void> {
  final List<DataColumn> columns;
  final List<DataRow> rows;
  DataTable({
    required this.columns,
    required this.rows,
  })  : assert(columns.isNotEmpty),
        assert(!rows.any((DataRow row) => row.cells.length != columns.length));

  @override
  void show() {
    print(_generateDivider());
    print(_generateRow(-1));
    print(_generateDivider());
    for (var i = 0; i < rows.length; i++) {
      print(_generateRow(i));
    }
    print(_generateDivider());
  }

  String _generateDivider() {
    return List.filled(
      columns.map((e) => e.length).reduce((value, element) => value + element) +
          columns.length +
          1,
      '-',
    ).join('');
  }

  // set [i] to -1 for header generating
  String _generateRow(int i) {
    if (i < -1 || i >= rows.length) {
      throw ArgumentError(
          'Index outside range. Available range is -1..${rows.length - 1}');
    }
    List<String> data;
    if (i == -1) {
      data = [...columns.map((e) => _padCell(e.label, e.length))];
    } else {
      data = [
        for (int j = 0; j < columns.length; j++)
          _padCell(rows[i].cells[j].data, columns[j].length)
      ];
    }

    return '$_columnDivider ${data.join(' $_columnDivider ')} $_columnDivider';
  }

  String _padCell(String data, int length) {
    String label = data;
    label = label.padRight(length - 2);
    if (label.length > length - 2) {
      label = label.substring(0, length - 5) + '...';
    }
    return label;
  }
}

class DataColumn {
  final String label;
  final int length;

  DataColumn({
    required this.label,
    this.length = 15,
  });
}

class DataRow {
  final List<DataCell> cells;

  DataRow(this.cells);
}

class DataCell {
  final String data;

  DataCell(this.data);
}
