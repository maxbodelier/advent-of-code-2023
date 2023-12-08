import 'dart:math';

import 'package:advent_of_code_2023/services/file_service.dart';

Future<int> calculateSolutionForDay4A() async {
  final lines = await FileService().getLinesFromFile('lib/input/day4.txt');

  List<int> cardValues = [];

  for (var line in lines) {
    final numbers = line.substring(line.indexOf(':') + 2);
    final entryNumbers = numbers
        .split('|')[1]
        .trim()
        .split(' ')
        .where((value) => value.trim().isNotEmpty);
    final winningNumbers = numbers
        .split('|')[0]
        .trim()
        .split(' ')
        .where((value) => value.trim().isNotEmpty);

    int winningNumberCount = 0;

    for (var entryNumber in entryNumbers) {
      if (winningNumbers.contains(entryNumber)) {
        winningNumberCount += 1;
      }
      ;
    }

    cardValues.add(pow(2, winningNumberCount - 1).toInt());
  }

  return cardValues.reduce((a, b) => a + b);
}

Future<int> calculateSolutionForDay4B() async {
  final lines = await FileService().getLinesFromFile('lib/input/day4.txt');

  var cardData = lines.asMap().entries.map((e) => [e.key, false, 1]).toSet();

  for (var line in lines.asMap().entries) {
    final numbers = line.value.substring(line.value.indexOf(':') + 2);
    final entryNumbers = numbers
        .split('|')[1]
        .trim()
        .split(' ')
        .where((value) => value.trim().isNotEmpty);
    final winningNumbers = numbers
        .split('|')[0]
        .trim()
        .split(' ')
        .where((value) => value.trim().isNotEmpty);

    int winningNumberCount = 0;

    for (var entryNumber in entryNumbers) {
      if (winningNumbers.contains(entryNumber)) {
        winningNumberCount += 1;
      }
    }

    if (winningNumberCount > 0) {
      print(line.key);
      cardData.remove(cardData.elementAt(line.key));
      cardData.add([line.key, true, winningNumberCount]);
    }
  }

  print(cardData);

  return 1;
}
