import 'package:advent_of_code_2023/services/file_service.dart';

Future<int> calculateSolutionForDay1A() async {
  final lines = await FileService().getLinesFromFile('lib/input/day1.txt');

  int totalCount = 0;

  for (var line in lines) {
    totalCount += getNumbersFromString(line);
  }

  return totalCount;
}

Future<int> calculateSolutionForDay1B() async {
  final lines = await FileService().getLinesFromFile('lib/input/day1.txt');

  int totalCount = 0;

  for (var line in lines) {
    final stringNumbersFromString = getStringNumbersFromString(line);
    totalCount += getNumbersFromString(stringNumbersFromString);
  }

  return totalCount;
}

int getNumbersFromString(String input) {
  final numbers = input.replaceAll(RegExp(r'[^0-9]'), '');
  if (numbers.isEmpty) return 0;

  if (numbers.length == 1) {
    return int.parse(numbers[0] + numbers[0]);
  }

  final result = numbers[0] + numbers[numbers.length - 1];

  return int.parse(result);
}

String getStringNumbersFromString(String input) {
  String stringNumbers = input;
  const acceptedStringNumbersWithReplacement = [
    {'one', 'on1e'},
    {'two', 'tw2o'},
    {'three', 'th3ree'},
    {'four', 'fo4ur'},
    {'five', 'fi5ve'},
    {'six', 'si6x'},
    {'seven', 'se7ven'},
    {'eight', 'ei8ght'},
    {'nine', 'ni9ne'}
  ];

  for (var asnwr in acceptedStringNumbersWithReplacement) {
    stringNumbers = stringNumbers.replaceAll(asnwr.first, asnwr.last);
  }

  return stringNumbers;
}
