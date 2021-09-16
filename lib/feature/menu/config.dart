import 'package:equatable/equatable.dart';

class MenuConfig extends Equatable {
  final bool clearMenu;
  final String requestString;

  const MenuConfig({
    this.clearMenu = true,
    this.requestString = '-->',
  });

  @override
  List<Object?> get props => [
        clearMenu,
        requestString,
      ];
}
