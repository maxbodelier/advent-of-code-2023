import 'package:advent_of_code_2023/services/file_service.dart';

Future<int> calculateSolutionForDay3A() async {
  final lines = await FileService().getLinesFromFile('lib/input/day3.txt');

  List<int> partNumbers = [];
  RegExp regex = RegExp(r'\d+');

  for (var line in lines.asMap().entries) {
    final numbers = regex.allMatches(line.value);
    for (var number in numbers) {
      if (isEnginePart(
          lines.asMap().entries, number.start, number.end, line.key)) {
        partNumbers.add(int.parse(number[0]!));
      }
    }
  }

  return partNumbers.reduce((a, b) => a + b);
}

Future<int> calculateSolutionForDay3B() async {
  final lines = await FileService().getLinesFromFile('lib/input/day3.txt');

  List<int> gearRatios = [];
  RegExp regex = RegExp(r'\*');

  for (var line in lines.asMap().entries) {
    final gears = regex.allMatches(line.value);
    for (var gear in gears) {
      calculateGearRatio(lines.asMap().entries, gear.start, gear.end, line.key);
      gearRatios.add(1);
    }
  }

  return gearRatios.reduce((a, b) => a + b);
}

int calculateGearRatio(Iterable<MapEntry<int, String>> lines,
    int startPositionGear, int endPositionGear, int lineIndex) {
  print(getSurroundingStringFromLine(
      lineIndex, lines, startPositionGear, endPositionGear));

  return 1;
}

bool isEnginePart(Iterable<MapEntry<int, String>> lines,
    int startPositionNumber, int endPositionNumber, int lineIndex) {
  List<String> surroundingSymbols = [];

  if (lineIndex - 1 >= 0) {
    surroundingSymbols.add(getSurroundingStringFromLine(
        lineIndex - 1, lines, startPositionNumber, endPositionNumber));
  }

  if (lineIndex + 1 < lines.length) {
    surroundingSymbols.add(getSurroundingStringFromLine(
        lineIndex + 1, lines, startPositionNumber, endPositionNumber));
  }

  if (startPositionNumber > 0) {
    surroundingSymbols
        .add(lines.elementAt(lineIndex).value[startPositionNumber - 1]);
  }

  if (endPositionNumber < lines.elementAt(lineIndex).value.length) {
    surroundingSymbols.add(lines.elementAt(lineIndex).value[endPositionNumber]);
  }

  return validateSpecialChars(surroundingSymbols);
}

String getSurroundingStringFromLine(int lineIndex,
    Iterable<MapEntry<int, String>> lines, int startPosition, int endPosition) {
  return lines.elementAt(lineIndex).value.substring(
      startPosition > 0 ? startPosition - 1 : startPosition,
      endPosition < lines.elementAt(lineIndex).value.length
          ? endPosition + 1
          : endPosition);
}

bool validateSpecialChars(List<String> input) {
  RegExp specialChars = RegExp(r'[^.0-9]');
  final result = input.map((e) => specialChars.hasMatch(e));

  return result.any((element) => element == true);
}
