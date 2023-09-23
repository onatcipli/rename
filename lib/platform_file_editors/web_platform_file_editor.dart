/// File: web_platform_file_editor.dart
/// Project: rename
/// Author: Onat Cipli
/// Created Date: 24.09.2023
/// Description: This file is responsible for editing Web platform files.

// ignore_for_file: unused_local_variable

import 'package:rename/enums.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

/// [WebPlatformFileEditor] is a class responsible for editing Web platform files.
/// It extends the [AbstractPlatformFileEditor] class.
///
/// Attributes:
/// - `webIndexPath`: Path to the Web index.html file.
class WebPlatformFileEditor extends AbstractPlatformFileEditor {
  String webIndexPath = AbstractPlatformFileEditor.convertPath(
    ['web', 'index.html'],
  );

  /// Creates an instance of [WebPlatformFileEditor].
  ///
  /// Parameters:
  /// - `platform`: The platform to be renamed. Default is [RenamePlatform.web].
  WebPlatformFileEditor({
    RenamePlatform platform = RenamePlatform.web,
  }) : super(platform: platform);

  /// Fetches the app name from the Web index.html file.
  ///
  /// Returns: Future<String?>, the app name if found, null otherwise.
  @override
  Future<String?> getAppName() async {
    final filePath = webIndexPath;
    var contentLineByLine = await readFileAsLineByline(
      filePath: filePath,
    );
    for (var i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i]?.contains('<title>') ?? false) {
        var match =
            RegExp(r'<title>(.*?)</title>').firstMatch(contentLineByLine[i]!);
        return match?.group(1)?.trim();
      }
    }
    return null;
  }

  /// Sets the app name in the Web index.html file.
  ///
  /// Parameters:
  /// - `appName`: The new app name to be set.
  ///
  /// Returns: Future<String?>, a success message indicating the change in app name.
  @override
  Future<String?> setAppName({required String appName}) async {
    final filePath = webIndexPath;
    List? contentLineByLine = await readFileAsLineByline(
      filePath: filePath,
    );
    for (var i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i].contains('<title>') &&
          contentLineByLine[i].contains('</title>')) {
        contentLineByLine[i] = '  <title>$appName</title>';
        break;
      }
    }
    final message = await super.setAppName(appName: appName);
    var writtenFile = await writeFile(
      filePath: filePath,
      content: contentLineByLine.join('\n'),
    );
    return message;
  }

  /// Fetches the bundle ID from the Web platform.
  ///
  /// Returns: Future<String?>, a message indicating that Web platform doesn't have bundleIdentifier.
  @override
  Future<String?> getBundleId() async {
    return "$platform doesn't have bundleIdentifier.";
  }

  /// Sets the bundle ID for the Web platform.
  ///
  /// Parameters:
  /// - `bundleId`: The new bundle ID to be set.
  ///
  /// Returns: Future<String?>, a message indicating that Web platform doesn't have bundleIdentifier.
  @override
  Future<String?> setBundleId({required String bundleId}) async {
    return "$platform doesn't have bundleIdentifier.";
  }
}
