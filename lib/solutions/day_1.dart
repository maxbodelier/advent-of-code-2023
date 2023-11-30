import 'package:advent_of_code_2023/services/file_service.dart';

Future<String> calculateSolutionForDay1A() async {
  final test = await FileService().getLinesFromFile('lib/input/day1.txt');
  return test.first;
}
