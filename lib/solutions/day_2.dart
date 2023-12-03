import 'package:advent_of_code_2023/services/file_service.dart';

Future<int> calculateSolutionForDay2A() async {
  final lines = await FileService().getLinesFromFile('lib/input/day2.txt');

  int totalCount = 0;

  for (var entry in lines.asMap().entries) {
    final gameResults = entry.value.substring(entry.value.indexOf(':') + 2);

    if (isPossible(gameResults)) {
      totalCount += entry.key + 1;
    }
  }

  return totalCount;
}

Future<int> calculateSolutionForDay2B() async {
  final lines = await FileService().getLinesFromFile('lib/input/day2.txt');

  int totalCount = 0;

  for (var entry in lines.asMap().entries) {
    final gameResults = entry.value.substring(entry.value.indexOf(':') + 2);

    final numbers = getMinimumNumbers(gameResults);
    totalCount += numbers.reduce((value, element) => value * element);
  }

  return totalCount;
}

List<int> getMinimumNumbers(String input) {
  ///RBG
  List<int> numbers = [0, 0, 0];

  final games = input.split(';');

  for (var game in games) {
    final elements = game.split(',');

    for (var element in elements) {
      final number = int.parse(element.replaceAll(RegExp(r'[^0-9]'), ''));
      if (element.contains('red') && numbers[0] < number) numbers[0] = number;
      if (element.contains('blue') && numbers[1] < number) numbers[1] = number;
      if (element.contains('green') && numbers[2] < number) numbers[2] = number;
    }
  }

  return numbers;
}

bool isPossible(String input) {
  return !input.split(';').map((e) {
    return e.split(',').map((e) {
      final number = int.parse(e.replaceAll(RegExp(r'[^0-9]'), ''));
      if (e.contains('red') && number <= 12) return true;
      if (e.contains('blue') && number <= 14) return true;
      if (e.contains('green') && number <= 13) return true;
      return false;
    }).any((element) => element == false); //check if a number is not possible
  }).any((element) => element == true);
}
