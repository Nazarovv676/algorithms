import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String country;
  final String city;
  final String street;
  final String house;

  const Address({
    this.country = '',
    this.city = '',
    this.street = '',
    this.house = '',
  });

  @override
  List<Object?> get props => [
        country,
        city,
        street,
        house,
      ];
}
