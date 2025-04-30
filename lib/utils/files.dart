import 'dart:io';

import 'package:path/path.dart';
import 'package:rename/custom_exceptions.dart';
import 'package:rename/enums.dart';

/// Reads a file line by line.
/// Parameters:
/// - `filePath`: The path of the file to be read.
/// Returns: Future<List<String?>>, a list of lines in the file.
/// Throws [FileReadException] if there is an error reading the file.
Future<List<String?>> readFileAsLineByline({
  required String filePath,
  required RenamePlatform platform,
}) async {
  try {
    var fileAsString = await File(filePath).readAsString();
    var fileContent = fileAsString.split('\n');
    _checkFileExists(
      fileContent: fileContent,
      filePath: filePath,
      platform: platform,
    );
    return fileContent;
  } catch (e) {
    throw FileReadException(
      filePath: filePath,
      platform: platform,
      details: e.toString(),
    );
  }
}

/// Writes the provided [content] to a file at the specified [filePath].
/// Parameters:
/// - `filePath`: The path of the file to be written to.
/// - `content`: The content to be written to the file.
/// Returns: Future<File>, the file with the written content.
/// Throws [FileWriteException] if there is an error writing to the file.
Future<File> writeFile({
  required String filePath,
  required String content,
  required RenamePlatform platform,
}) async {
  try {
    return await File(filePath).writeAsString(content);
  } catch (e) {
    throw FileWriteException(
      filePath: filePath,
      platform: platform,
      details: e.toString(),
    );
  }
}

/// Checks if a file exists by verifying that its content is not null or empty.
/// Parameters:
/// - `fileContent`: The content of the file.
/// - `filePath`: The path of the file.
/// Returns: bool, true if the file exists, false otherwise.
/// Throws [FileNotExistException] if the file does not exist.
bool _checkFileExists({
  required List? fileContent,
  required String filePath,
  required RenamePlatform platform,
}) {
  if (fileContent == null || fileContent.isEmpty) {
    throw FileNotExistException(
      filePath: filePath,
      platform: platform,
      details: 'File content is null or empty',
    );
  }
  return true;
}

/// Converts a list of path segments into a platform-specific file path.
/// Parameters:
/// - `paths`: A list of path segments.
/// Returns: String, the platform-specific file path.
String convertPath(List<String> paths) {
  return joinAll(paths);
}
