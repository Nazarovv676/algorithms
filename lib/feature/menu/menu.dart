library menu;

import 'package:console/console.dart';
import 'package:lab1/core/console/console.dart';
import 'package:lab1/core/elements/showable.dart';

import 'config.dart';
import 'item.dart';

export 'config.dart';
export 'item.dart';

typedef ItemSelected = void Function(MenuItem item);

class Menu extends Showable<MenuItem> {
  final MenuConfig config;
  final List<MenuItem> items;
  final ItemSelected? onSelect;

  Menu({
    this.config = const MenuConfig(),
    this.items = const [],
    this.onSelect,
  });

  @override
  MenuItem? show() {
    _clear();

    String buffer = '';
    for (int i = 0; i < items.length; i++) {
      buffer += '${i + 1}. ${items[i].label}\n';
    }
    Console.write(buffer);

    final res = ExtendedConsole.readInt('${config.requestString} ');

    _clear();
    if (res != null) {
      if (res < 1 || res > items.length) {
        return show();
      }
      final selected = items[res - 1];
      onSelect?.call(selected);
      selected.onSelect?.call();
      if (selected.onSelect != null) {
        return show();
      }
      return selected;
    }
  }

  void _clear() {
    if (config.clearMenu) {
      ExtendedConsole.clearDisplay();
    }
  }
}
