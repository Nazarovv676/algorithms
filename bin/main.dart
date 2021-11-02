import 'package:console/console.dart';
import 'package:lab1/core/console/console.dart';

import 'lab1.dart';
import 'lab2.dart';

void main(List<String> arguments) async {
  try {
    await init();

    lab2(arguments);
  } catch (exc) {
    print('An error has occurred: ${exc.toString()}');
  }
}

Future<void> init() async {
  Console.init();
  ExtendedConsole.clearDisplay();
}
