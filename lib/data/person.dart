import 'package:equatable/equatable.dart';

import 'address.dart';

class Person extends Equatable {
  final String name;
  final String surname;
  final Address address;
  final String telNum;

  Person({
    this.name = '',
    this.surname = '',
    this.address = const Address(),
    this.telNum = '',
  });

  @override
  List<Object?> get props => [
        name,
        surname,
        address,
        telNum,
      ];
}
