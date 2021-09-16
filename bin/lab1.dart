import 'package:lab1/core/console/extended_console.dart';
import 'package:lab1/data/address.dart';
import 'package:lab1/data/person.dart';
import 'package:lab1/feature/menu/menu.dart';

final console = ExtendedConsole();
void main(List<String> arguments) async {
  final List<Person> people = [];
  Menu(
    items: [
      MenuItem(
        label: 'Add person',
        onSelect: () {
          final name = console.readLineWithPlaceHolder(placeHolder: 'Name: ');
          final surname =
              console.readLineWithPlaceHolder(placeHolder: 'Surname: ');

          final country =
              console.readLineWithPlaceHolder(placeHolder: 'Country: ');
          final city = console.readLineWithPlaceHolder(placeHolder: 'City: ');
          final street =
              console.readLineWithPlaceHolder(placeHolder: 'Street: ');
          final house = console.readLineWithPlaceHolder(placeHolder: 'House: ');

          final telNum = console.readLineWithPlaceHolder(
              placeHolder: 'Telephone number: ');

          final person = Person(
            name: name ?? '',
            surname: surname ?? '',
            address: Address(
              country: country ?? '',
              city: city ?? '',
              street: street ?? '',
              house: house ?? '',
            ),
            telNum: telNum ?? '',
          );

          people.add(person);
        },
      ),
      MenuItem(label: 'Delete person'),
      MenuItem(
        label: 'Show all people',
        onSelect: () {
          print(people);
          console.readKey();
        },
      )
    ],
  ).show();
}
