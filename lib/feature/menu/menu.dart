library menu;

import 'package:lab1/core/console/extended_console.dart';

import 'config.dart';
import 'item.dart';

export 'config.dart';
export 'item.dart';

typedef ItemSelected = void Function(MenuItem item);

class Menu {
  final MenuConfig config;
  final List<MenuItem> items;
  final ItemSelected? onSelect;

  Menu({
    this.config = const MenuConfig(),
    this.items = const [],
    this.onSelect,
  });

  final _console = ExtendedConsole();

  MenuItem? show() {
    _clear();

    String buffer = '';
    for (int i = 0; i < items.length; i++) {
      buffer += '${i + 1}. ${items[i].label}\n';
    }
    _console.write(buffer);

    final res = _console.readInt(
      placeHolder: '${config.requestString} ',
      cancelOnEscape: true,
      cancelOnEOF: true,
    );

    _clear();
    if (res != null) {
      if (res < 1 || res > items.length) {
        return show();
      }
      final selected = items[res - 1];
      onSelect?.call(selected);
      selected.onSelect?.call();
      if (selected.onSelect != null && selected.reshowAfterCallback) {
        return show();
      }
      return selected;
    }
  }

  void _clear() {
    if (config.clearMenu) {
      _console.clearScreen();
    }
  }
}
