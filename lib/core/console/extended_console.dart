import 'package:dart_console/dart_console.dart';

class ExtendedConsole extends Console {
  ExtendedConsole() : super();
  ExtendedConsole.scrolling({bool recordBlanks = true})
      : super.scrolling(recordBlanks: recordBlanks);

  int? readInt({
    String? placeHolder,
    bool cancelOnBreak = false,
    bool cancelOnEscape = false,
    bool cancelOnEOF = false,
    Function(String text, Key lastPressed)? callback,
  }) {
    while (true) {
      try {
        final res = readLineWithPlaceHolder(
          placeHolder: placeHolder,
          cancelOnBreak: cancelOnBreak,
          cancelOnEscape: cancelOnEscape,
          cancelOnEOF: cancelOnEOF,
          callback: callback,
        );
        if (res == null) {
          return null;
        }
        return int.parse(res);
      } on FormatException catch (_) {
        cursorUp();
        eraseLine();
      }
    }
  }

  String? readLineWithPlaceHolder({
    String? placeHolder,
    bool cancelOnBreak = false,
    bool cancelOnEscape = false,
    bool cancelOnEOF = false,
    Function(String text, Key lastPressed)? callback,
  }) {
    if (placeHolder != null) {
      write(placeHolder);
    }
    final res = readLine(
      cancelOnBreak: cancelOnBreak,
      cancelOnEscape: cancelOnEscape,
      cancelOnEOF: cancelOnEOF,
      callback: callback,
    );
    return res;
  }
}
