/// File: linux_platform_file_editor.dart
/// Project: rename
/// Author: Onat Cipli
/// Created Date: 24.09.2023
/// Description: This file is responsible for editing Linux platform files.

import 'package:rename/enums.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

/// [LinuxPlatformFileEditor] is a class that extends [AbstractPlatformFileEditor].
/// It is responsible for editing Linux platform files.
///
/// Attributes:
/// - [linuxCMakeListsPath]: Represents the path to the Linux CMakeLists.txt file.
/// - [linuxAppCppPath]: Represents the path to the Linux my_application.cc file.
class LinuxPlatformFileEditor extends AbstractPlatformFileEditor {
  String linuxCMakeListsPath = AbstractPlatformFileEditor.convertPath(
    ['linux', 'CMakeLists.txt'],
  );
  String linuxAppCppPath = AbstractPlatformFileEditor.convertPath(
    ['linux', 'my_application.cc'],
  );

  /// Creates an instance of [LinuxPlatformFileEditor].
  ///
  /// Parameters:
  /// - `platform`: Specifies the platform for renaming. Default is [RenamePlatform.linux].
  LinuxPlatformFileEditor({
    RenamePlatform platform = RenamePlatform.linux,
  }) : super(platform: platform);

  /// Fetches the app name from the Linux CMakeLists.txt file.
  ///
  /// Returns: Future<String?>, the app name if found, null otherwise.
  @override
  Future<String?> getAppName() async {
    final filePath = linuxCMakeListsPath;
    var contentLineByLine = await readFileAsLineByline(
      filePath: filePath,
    );
    for (var i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i]?.contains('set(BINARY_NAME') ?? false) {
        var match = RegExp(r'set\(BINARY_NAME "(.*?)"\)')
            .firstMatch(contentLineByLine[i]!);
        return match?.group(1)?.trim();
      }
    }
    return null;
  }

  /// Fetches the bundle ID from the Linux my_application.cc file.
  ///
  /// Returns: Future<String?>, the bundle ID if found, null otherwise.
  @override
  Future<String?> getBundleId() async {
    final filePath = linuxAppCppPath;
    var contentLineByLine = await readFileAsLineByline(
      filePath: filePath,
    );
    for (var i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i]?.contains('kFlutterWindowTitle') ?? false) {
        var match = RegExp(r'kFlutterWindowTitle = "(.*?)"')
            .firstMatch(contentLineByLine[i]!);
        return match?.group(1)?.trim();
      }
    }
    return null;
  }

  /// Sets the app name in the Linux CMakeLists.txt file.
  ///
  /// Parameters:
  /// - `appName`: The new app name to be set for the application.
  ///
  /// Returns: Future<String?>, a success message indicating the change in app name.
  @override
  Future<String?> setAppName({required String appName}) async {
    final filePath = linuxCMakeListsPath;
    List? contentLineByLine = await readFileAsLineByline(
      filePath: filePath,
    );
    for (var i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i].contains('set(BINARY_NAME')) {
        contentLineByLine[i] = 'set(BINARY_NAME \"$appName\")';
        break;
      }
    }
    final message = await super.setAppName(appName: appName);
    await writeFile(
      filePath: filePath,
      content: contentLineByLine.join('\n'),
    );
    return message;
  }

  /// Sets the bundle ID in the Linux my_application.cc file.
  ///
  /// Parameters:
  /// - `bundleId`: The new bundle ID to be set for the application.
  ///
  /// Returns: Future<String?>, a success message indicating the change in bundle ID.
  @override
  Future<String?> setBundleId({required String bundleId}) async {
    final filePath = linuxAppCppPath;
    List? contentLineByLine = await readFileAsLineByline(
      filePath: filePath,
    );
    for (var i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i].contains('kFlutterWindowTitle')) {
        contentLineByLine[i] =
            'const char kFlutterWindowTitle[] = \"$bundleId\";';
      }
    }
    final message = await super.setBundleId(bundleId: bundleId);
    await writeFile(
      filePath: filePath,
      content: contentLineByLine.join('\n'),
    );
    return message;
  }
}
