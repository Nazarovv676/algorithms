import 'package:console/console.dart';
import 'package:lab1/core/console/console.dart';
import 'package:lab1/feature/data_table/data_table.dart';
import 'package:lab1/feature/list/linked_list.dart';
import 'package:lab1/feature/menu/menu.dart';

void lab2(List<String> arguments) async {
  LinkedList<String> participants = LinkedList.circular();
  LinkedList<String> prizes = LinkedList.circular();

  Menu(
    items: [
      MenuItem(
        label: 'Add participant',
        onSelect: () {
          participants = _addParticipant(participants);
        },
      ),
      MenuItem(
        label: 'Add prize',
        onSelect: () {
          prizes = _addPrize(prizes);
        },
      ),
      MenuItem(
        label: 'Show data',
        onSelect: () {
          Menu(
            items: [
              MenuItem(
                  label: 'Participants',
                  onSelect: () {
                    _showParticipants(participants);
                    ExtendedConsole.awaitEnterClick();
                  }),
              MenuItem(
                  label: 'Prizes',
                  onSelect: () {
                    _showPrizes(prizes);
                    ExtendedConsole.awaitEnterClick();
                  }),
              MenuItem.back(),
            ],
          ).show();
        },
      ),
      MenuItem(
        label: 'SPIN THE WHEEL!!!',
        onSelect: () => _spinWheel(participants, prizes),
      ),
      MenuItem.exit(),
    ],
  ).show();
}

LinkedList<String> _addParticipant(LinkedList<String> participants) {
  final name = ExtendedConsole.readLineWithPlaceHolder('Participant name: ');
  return participants.copy()..add(name ?? '');
}

void _showParticipants(LinkedList<String> participants) {
  DataTable(
    columns: [
      DataColumn(label: 'N'),
      DataColumn(label: 'Name'),
    ],
    rows: [
      for (var i = 0; i < participants.length; i++)
        DataRow([
          DataCell((i + 1).toString()),
          DataCell(participants[i]),
        ])
    ],
  ).show();
}

LinkedList<String> _addPrize(LinkedList<String> prizes) {
  final name = ExtendedConsole.readLineWithPlaceHolder('Prize name: ');
  return prizes.copy()..add(name ?? '');
}

void _showPrizes(LinkedList<String> prizes) {
  DataTable(
    columns: [
      DataColumn(label: 'N'),
      DataColumn(label: 'Name'),
    ],
    rows: [
      for (var i = 0; i < prizes.length; i++)
        DataRow([
          DataCell((i + 1).toString()),
          DataCell(prizes[i]),
        ])
    ],
  ).show();
}

void _spinWheel(LinkedList<String> participants, LinkedList<String> prizes) {
  if (participants.isEmpty || prizes.isEmpty) {
    print('Prizes or participants must not be empty');
    ExtendedConsole.awaitEnterClick();
    return;
  }

  final numberOfWinners = ExtendedConsole.readIntInRange(
    1,
    participants.length,
    'Enter the count of winners: ',
    'Available count from 1 to ${participants.length}',
  );

  final winnersSpreading = ExtendedConsole.readIntInRange(
    0,
    256,
    'Enter the winners spreading intensity: ',
    'Available value from 0 to 256',
  );

  final prizesSpreading = ExtendedConsole.readIntInRange(
    0,
    256,
    'Enter the prizes spreading intensity: ',
    'Available value from 0 to 256',
  );

  ListNode<String> currentPrize = prizes.firstNode!;
  ListNode<String> currentParticipant = participants.firstNode!;
  Map<String, List<String>> results = {};

  for (var i = 0; i < numberOfWinners!; i++) {
    currentPrize = _getListNodeByOffsetFrom(
      currentPrize as CircularNode<String>,
      prizesSpreading!,
    );
    currentParticipant = _getListNodeByOffsetFrom(
      currentParticipant as CircularNode<String>,
      winnersSpreading!,
    );

    results.update(
      currentParticipant.data,
      (winnerPrizes) => [...winnerPrizes, currentPrize.data],
      ifAbsent: () => [currentPrize.data],
    );
  }
  results.forEach((key, value) {
    print(key);
    print(value);
  });
  ExtendedConsole.awaitEnterClick();
}

ListNode<String> _getListNodeByOffsetFrom(
    CircularNode<String> node, int offset) {
  if (offset < 0) {
    throw ArgumentError.value(offset);
  }

  for (var i = 0; i < offset; i++) {
    node = node.next;
  }

  return node;
}
