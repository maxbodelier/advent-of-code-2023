import 'package:advent_of_code_2023/services/file_service.dart';
import 'package:dart_numerics/dart_numerics.dart' as numerics;

Future<int> calculateSolutionForDay8A() async {
  final lines = await FileService().getLinesFromFile('lib/input/day8.txt');

  final instructions = lines[0];
  final nodes = lines;
  nodes.removeRange(0, 2);

  return runInstructions(instructions, parseNodes(nodes), 'AAA', 'ZZZ');
}

Future<int> calculateSolutionForDay8B() async {
  final lines = await FileService().getLinesFromFile('lib/input/day8.txt');

  final instructions = lines[0];
  final nodes = lines;
  nodes.removeRange(0, 2);

  List<List<String>> startNodes =
      parseNodes(nodes).where((element) => element[0].contains('A')).toList();

  List<int> whenOnEndPosition = [];

  for (var startNode in startNodes) {
    whenOnEndPosition.add(
        runInstructions(instructions, parseNodes(nodes), startNode[0], 'Z'));
  }

  return numerics.leastCommonMultipleOfMany(whenOnEndPosition);
}

List<List<String>> parseNodes(List<String> nodes) {
  return nodes
      .map((e) => e
          .replaceAll('= ', '')
          .replaceAll('(', '')
          .replaceAll(')', '')
          .replaceAll(',', '')
          .split(' '))
      .toList();
}

int runInstructions(String instructions, List<List<String>> nodes,
    String startNodeKey, String endNodeContains) {
  List<String> currentNode =
      nodes.singleWhere((element) => element[0] == startNodeKey);
  int stepsCount = 0;
  bool reachedEnd = false;

  while (!reachedEnd) {
    for (var rune in instructions.runes) {
      final character = String.fromCharCode(rune);
      final leftOrRightIndex = character == 'L' ? 1 : 2;

      final newNode = nodes.where((element) {
        return currentNode[leftOrRightIndex] == element[0];
      });

      currentNode = newNode.first.isNotEmpty ? newNode.first : currentNode;
      stepsCount++;

      if (currentNode[0].contains(endNodeContains)) {
        reachedEnd = true;
        break;
      }
    }
  }

  return stepsCount;
}
