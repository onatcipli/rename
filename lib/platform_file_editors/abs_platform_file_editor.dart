/// File: abs_platform_file_editor.dart
/// Project: rename
/// Author: Onat Cipli
/// Created Date: 24.09.2023
/// Description: This file defines the abstract class for PlatformFileEditors and its methods.

import 'dart:io';

import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:rename/custom_exceptions.dart';
import 'package:rename/enums.dart';

final Logger logger = Logger(
  filter: ProductionFilter(),
);

/// [AbstractPlatformFileEditor] is an abstract class that provides a blueprint for platform-specific file editors.
/// It defines the common methods that all platform file editors should implement.
/// Attributes:
/// - [platform]: Specifies the platform for which the file editor is defined.
abstract class AbstractPlatformFileEditor {
  final RenamePlatform platform;

  AbstractPlatformFileEditor({required this.platform});

  /// Fetches the Bundle ID of the application.
  /// Returns: Future<String?>, the Bundle ID of the application.
  Future<String?> getBundleId();

  /// Changes the Bundle ID of the application to the provided [bundleId].
  /// Parameters:
  /// - `bundleId`: The new Bundle ID to be set for the application.
  /// Returns: Future<String?>, a success message indicating the change in Bundle ID.
  Future<String?> setBundleId({required String bundleId}) async {
    var old = await getBundleId();
    return 'rename has successfuly changed bundleId for ${platform.name.toUpperCase()}\n$old -> $bundleId';
  }

  /// Fetches the name of the application.
  /// Returns: Future<String?>, the name of the application.
  Future<String?> getAppName();

  /// Changes the name of the application to the provided [appName].
  /// Parameters:
  /// - `appName`: The new name to be set for the application.
  /// Returns: Future<String?>, a success message indicating the change in application name.
  Future<String?> setAppName({required String appName}) async {
    var old = await getAppName();
    return 'rename has successfuly changed appname for ${platform.name.toUpperCase()}\n$old -> $appName';
  }

  /// Reads a file line by line.
  /// Parameters:
  /// - `filePath`: The path of the file to be read.
  /// Returns: Future<List<String?>>, a list of lines in the file.
  /// Throws [FileReadException] if there is an error reading the file.
  Future<List<String?>> readFileAsLineByline({
    required String filePath,
  }) async {
    try {
      var fileAsString = await File(filePath).readAsString();
      var fileContent = fileAsString.split('\n');
      _checkFileExists(
        fileContent: fileContent,
        filePath: filePath,
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
  static String convertPath(List<String> paths) {
    return joinAll(paths);
  }
}
