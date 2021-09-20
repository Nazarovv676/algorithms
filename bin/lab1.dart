import 'package:console/console.dart';
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
      MenuItem(
        label: 'Delete person',
        onSelect: () {
          people = _requestPersonDeletion(people) ?? people;
          ExtendedConsole.readKey();
        },
      ),
      MenuItem(
        label: 'Show all people',
        onSelect: () {
          _showAllPeople(people);
          ExtendedConsole.readKey();
        },
      )
    ],
  ).show();
}

List<Person>? _requestPersonDeletion(List<Person> people) {
  if (people.isEmpty) {
    Console.write('The list is empty');
    return null;
  }

  _showAllPeople(people);

  final index = ExtendedConsole.readIntInRange(
    1,
    people.length,
    'Whom to remove from the list: ',
    'Select a person from the list',
  );

  if (index != null) {
    return List<Person>.from(people)..removeAt(index - 1);
  }
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
  if (people.isEmpty) {
    Console.write('The list is empty');
    return;
  }

  DataTable(
    columns: [
      DataColumn(label: 'Name'),
      DataColumn(label: 'Surname'),
      DataColumn(label: 'Country'),
      DataColumn(label: 'City'),
      DataColumn(label: 'Street'),
      DataColumn(label: 'House'),
      DataColumn(label: 'Telephone number', length: 20),
    ],
    rows: [
      ...people.map((e) => DataRow([
            DataCell(e.name),
            DataCell(e.surname),
            DataCell(e.address.country),
            DataCell(e.address.city),
            DataCell(e.address.street),
            DataCell(e.address.house),
            DataCell(e.telNum),
          ]))
    ],
  ).show();
}
