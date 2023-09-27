/// File: custom_exceptions.dart
/// Project: rename
/// Author: Onat Cipli
/// Created Date: 24.09.2023
/// Description: This file defines custom exceptions for the rename project.

import 'package:rename/enums.dart';

/// [CustomException] is a base class for exceptions in the platform file editors.
/// Attributes:
/// - `message`: The error message associated with the exception.
class CustomException implements Exception {
  final String message;

  CustomException(this.message);

  @override
  String toString() => 'CustomException: $message';
}

/// [FileReadException] is a custom exception thrown when there is an error reading a file.
/// Attributes:
/// - `filePath`: The path of the file where the error occurred.
/// - `platform`: The platform where the error occurred.
/// - `details`: Additional details about the error.
class FileReadException extends CustomException {
  final RenamePlatform platform;

  FileReadException({
    required String filePath,
    required this.platform,
    required String details,
  }) : super(
          'Oops! We encountered an issue while reading the file at path: '
          '$filePath for platform: ${platform.toString()}. '
          'Details: $details',
        );
}

/// [FileWriteException] is a custom exception thrown when there is an error writing to a file.
/// Attributes:
/// - `filePath`: The path of the file where the error occurred.
/// - `platform`: The platform where the error occurred.
/// - `details`: Additional details about the error.
class FileWriteException extends CustomException {
  final RenamePlatform platform;

  FileWriteException({
    required String filePath,
    required this.platform,
    required String details,
  }) : super(
          'Oops! We encountered an issue while writing to the file at path: '
          '$filePath for platform: ${platform.toString()}. '
          'Details: $details',
        );
}

/// [FileNotExistException] is a custom exception thrown when a file does not exist at the expected path.
/// Attributes:
/// - `filePath`: The path of the file where the error occurred.
/// - `platform`: The platform where the error occurred.
/// - `details`: Additional details about the error.
class FileNotExistException extends CustomException {
  final RenamePlatform platform;

  FileNotExistException({
    required String filePath,
    required this.platform,
    required String details,
  }) : super(
          'Oops! The file does not exist at path: '
          '$filePath for platform: ${platform.toString()}. '
          'Details: $details',
        );
}
