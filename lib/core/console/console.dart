import 'dart:io';

import 'package:console/console.dart';

class ExtendedConsole extends Console {
  static int? readInt([String? placeHolder]) {
    while (true) {
      try {
        final res = readLineWithPlaceHolder(placeHolder);
        if (res == null) {
          return null;
        }
        return int.parse(res);
      } on FormatException catch (_) {
        Console.moveCursorUp();
        Console.eraseLine();
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

  static int readKey() {
    stdin.lineMode = false;
    final res = stdin.readByteSync();
    stdin.lineMode = true;
    return res;
  }

  static void clearDisplay() {
    print("\x1B[2J\x1B[0;0H");
  }
}
