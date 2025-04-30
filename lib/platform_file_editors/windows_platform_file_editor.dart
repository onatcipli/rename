/// File: windows_platform_file_editor.dart
/// Project: rename
/// Author: Onat Cipli
/// Created Date: 24.09.2023
/// Description: This file is responsible for editing Windows platform files.

import 'package:rename/enums.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import 'package:rename/utils/files.dart';

/// [WindowsPlatformFileEditor] is a class responsible for editing Windows platform files.
/// It extends the [AbstractPlatformFileEditor] class.
///
/// Attributes:
/// - `windowsAppPath`: Path to the Windows main.cpp file.
/// - `windowsAppRCPath`: Path to the Windows Runner.rc file.
class WindowsPlatformFileEditor extends AbstractPlatformFileEditor {
  String windowsAppPath = convertPath(
    ['windows', 'runner', 'main.cpp'],
  );
  String windowsAppRCPath = convertPath(
    ['windows', 'runner', 'Runner.rc'],
  );

  /// Creates an instance of [WindowsPlatformFileEditor].
  WindowsPlatformFileEditor({
    RenamePlatform platform = RenamePlatform.windows,
  }) : super(platform: platform);

  /// Fetches the app name from the Windows main.cpp file.
  ///
  /// Returns: Future<String?>, the app name if found, null otherwise.
  @override
  Future<String?> getAppName() async {
    final filePath = windowsAppPath;
    var contentLineByLine = await readFileAsLineByline(
      filePath: filePath,
      platform: platform,
    );
    for (var i = 0; i < contentLineByLine.length; i++) {
      final line = contentLineByLine[i];
      if (line?.contains('window.CreateAndShow') ?? false) {
        var match = RegExp(r'CreateAndShow\(L"(.*?)"').firstMatch(line!);
        return match?.group(1)?.trim();
      } else if (contentLineByLine[i]?.contains('window.Create') ?? false) {
        var match = RegExp(r'Create\(L"(.*?)"').firstMatch(line!);
        return match?.group(1)?.trim();
      }
    }
    return null;
  }

  /// Fetches the bundle ID from the Windows Runner.rc file.
  ///
  /// Returns: Future<String?>, the bundle ID if found, null otherwise.
  @override
  Future<String?> getBundleId() async {
    final filePath = windowsAppRCPath;
    var contentLineByLine = await readFileAsLineByline(
      filePath: filePath,
      platform: platform,
    );
    for (var i = 0; i < contentLineByLine.length; i++) {
      final line = contentLineByLine[i];
      if (line?.contains('VALUE "InternalName"') ?? false) {
        var match = RegExp(r'VALUE "InternalName", "(.*?)"').firstMatch(line!);
        return match?.group(1)?.trim();
      }
    }
    return null;
  }

  /// Sets the app name in the Windows main.cpp file.
  ///
  /// Parameters:
  /// - `appName`: The new app name to be set.
  ///
  /// Returns: Future<String?>, a success message indicating the change in app name.
  @override
  Future<String?> setAppName({required String appName}) async {
    final filePath = windowsAppPath;
    List? contentLineByLine = await readFileAsLineByline(
      filePath: filePath,
      platform: platform,
    );
    var currentAppName = await getAppName();
    if (currentAppName != null) {
      for (var i = 0; i < contentLineByLine.length; i++) {
        if (contentLineByLine[i]?.contains('window.CreateAndShow') ?? false) {
          contentLineByLine[i] = contentLineByLine[i]?.replaceFirst(
            currentAppName,
            appName,
          );
          break;
        } else if (contentLineByLine[i]?.contains('window.Create') ?? false) {
          contentLineByLine[i] = contentLineByLine[i]?.replaceFirst(
            currentAppName,
            appName,
          );
          break;
        }
      }
    }
    final message = await super.setAppName(appName: appName);
    await writeFile(
      filePath: filePath,
      content: contentLineByLine.join('\n'),
      platform: platform,
    );
    return 'App name set to $appName';
  }

  /// Sets the bundle ID in the Windows Runner.rc file.
  ///
  /// Parameters:
  /// - `bundleId`: The new bundle ID to be set.
  ///
  /// Returns: Future<String?>, a success message indicating the change in bundle ID.
  @override
  Future<String?> setBundleId({required String bundleId}) async {
    final filePath = windowsAppRCPath;
    List? contentLineByLine = await readFileAsLineByline(
      filePath: filePath,
      platform: platform,
    );
    for (var i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i].contains('VALUE "InternalName"')) {
        contentLineByLine[i] =
            '            VALUE "InternalName", "$bundleId" "\\0"';
      }
    }
    final message = await super.setBundleId(bundleId: bundleId);
    await writeFile(
      filePath: filePath,
      content: contentLineByLine.join('\n'),
      platform: platform,
    );
    return message;
  }
}
