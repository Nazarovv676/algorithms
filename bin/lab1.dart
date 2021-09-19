import 'package:lab1/data/address.dart';
import 'package:lab1/data/person.dart';
import 'package:lab1/feature/data_table/data_table.dart';
import 'package:lab1/feature/menu/menu.dart';
import 'package:lab1/core/console/console.dart';

void lab1(List<String> arguments) async {
  List<Person> people = [];
  Menu(
    items: [
      MenuItem(
        label: 'Add person',
        onSelect: () => people = _addPerson(people),
      ),
      MenuItem(label: 'Delete person'),
      MenuItem(
        label: 'Show all people',
        onSelect: () => _showAllPeople(people),
      )
    ],
  ).show();
}

List<Person> _addPerson(List<Person> people) {
  final name = ExtendedConsole.readLineWithPlaceHolder('Name: ');
  final surname = ExtendedConsole.readLineWithPlaceHolder('Surname: ');
  final country = ExtendedConsole.readLineWithPlaceHolder('Country: ');
  final city = ExtendedConsole.readLineWithPlaceHolder('City: ');
  final street = ExtendedConsole.readLineWithPlaceHolder('Street: ');
  final house = ExtendedConsole.readLineWithPlaceHolder('House: ');
  final telNum = ExtendedConsole.readLineWithPlaceHolder('Telephone number: ');

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

  return List<Person>.from([...people, person]);
}

void _showAllPeople(List<Person> people) {
  DataTable<Person>(
    columnsCount: 7,
    data: people,
    converter: (data) => [
      data.name,
      data.surname,
      data.address.country,
      data.address.city,
      data.address.street,
      data.address.house,
      data.telNum,
    ],
  ).show();
  ExtendedConsole.readKey();
}
