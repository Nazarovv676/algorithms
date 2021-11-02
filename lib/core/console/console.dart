import 'dart:io';

import 'package:console/console.dart';

class ExtendedConsole extends Console {
  static int? readIntInRange(
    int start,
    int end, [
    String? placeHolder,
    String? errorMessage,
  ]) {
    int? res;
    do {
      final placeHolderLinesCount = (placeHolder ?? '').split(r'\n').length;
      if (res != null && errorMessage != null) {
        Console.write('$errorMessage\n');
        ExtendedConsole.awaitEnterClick();
        clearLastLines(placeHolderLinesCount + 1);
      }
      if (res != null) {
        clearLastLines(placeHolderLinesCount);
      }
      res = readInt(placeHolder);
      if (res == null) {
        return null;
      }
    } while (res < start || res > end);
    return res;
  }

  static int? readInt([String? placeHolder]) {
    while (true) {
      try {
        final res = readLineWithPlaceHolder(placeHolder);
        if (res == null) {
          return null;
        }
        return int.parse(res);
      } on FormatException catch (_) {
        clearLastLines();
      }
    }
  }

  static String? readLineWithPlaceHolder([String? placeHolder]) {
    if (placeHolder != null) {
      Console.write(placeHolder);
    }
    final res = Console.readLine();
    return res;
  }

  @Deprecated('Error in library "lineMode"')
  static int readKey() {
    stdin.lineMode = false;
    final res = stdin.readByteSync();
    stdin.lineMode = true;
    return res;
  }

  static void awaitEnterClick() {
    ExtendedConsole.readLineWithPlaceHolder('Click "Enter"...');
  }

  static void clearDisplay() {
    Console.write("\x1B[2J\x1B[0;0H");
  }

  static void clearLastLines([int count = 1]) {
    for (var i = 0; i < count; i++) {
      Console.moveCursorUp();
      Console.eraseLine();
    }
  }
}
