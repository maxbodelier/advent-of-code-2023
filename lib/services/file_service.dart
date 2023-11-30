import 'dart:io';

class FileService {
  Future<List<String>> getLinesFromFile(String path) async {
    File file = File(path);
    return await file.readAsLines();
  }
}
