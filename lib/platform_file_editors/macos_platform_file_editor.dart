/// File: macos_platform_file_editor.dart
/// Project: rename
/// Author: Onat Cipli
/// Created Date: 24.09.2023
/// Description: This file is responsible for editing macOS platform files.

import 'package:rename/enums.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

/// [MacosPlatformFileEditor] is a class that extends [AbstractPlatformFileEditor].
/// It is responsible for editing macOS platform files.
///
/// Attributes:
/// - [macosAppInfoxprojPath]: Path to the macOS AppInfo.xcconfig file.
class MacosPlatformFileEditor extends AbstractPlatformFileEditor {
  String macosAppInfoxprojPath = AbstractPlatformFileEditor.convertPath(
    ['macos', 'Runner', 'Configs', 'AppInfo.xcconfig'],
  );

  /// Creates an instance of [MacosPlatformFileEditor].
  ///
  /// Parameters:
  /// - `platform`: The platform to be renamed. Default is [RenamePlatform.macOS].
  MacosPlatformFileEditor({
    RenamePlatform platform = RenamePlatform.macOS,
  }) : super(platform: platform);

  /// Fetches the app name from the macOS AppInfo.xcconfig file.
  ///
  /// Returns: Future<String?>, the app name if found, null otherwise.
  @override
  Future<String?> getAppName() async {
    final filePath = macosAppInfoxprojPath;
    var contentLineByLine = await readFileAsLineByline(
      filePath: filePath,
    );
    for (var i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i]?.contains('PRODUCT_NAME') ?? false) {
        return (contentLineByLine[i] as String).split('=').last.trim();
      }
    }
    return null;
  }

  /// Fetches the bundle ID from the macOS AppInfo.xcconfig file.
  ///
  /// Returns: Future<String?>, the bundle ID if found, null otherwise.
  @override
  Future<String?> getBundleId() async {
    final filePath = macosAppInfoxprojPath;
    var contentLineByLine = await readFileAsLineByline(
      filePath: filePath,
    );
    for (var i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i]?.contains('PRODUCT_BUNDLE_IDENTIFIER') ??
          false) {
        return (contentLineByLine[i] as String).split('=').last.trim();
      }
    }
    return null;
  }

  /// Sets the app name in the macOS AppInfo.xcconfig file.
  ///
  /// Parameters:
  /// - `appName`: The new app name to be set for the application.
  ///
  /// Returns: Future<String?>, a success message indicating the change in app name.
  @override
  Future<String?> setAppName({required String appName}) async {
    final filePath = macosAppInfoxprojPath;
    List? contentLineByLine = await readFileAsLineByline(
      filePath: filePath,
    );
    for (var i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i].contains('PRODUCT_NAME')) {
        contentLineByLine[i] = 'PRODUCT_NAME = $appName';
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

  /// Sets the bundle ID in the macOS AppInfo.xcconfig file.
  ///
  /// Parameters:
  /// - `bundleId`: The new bundle ID to be set for the application.
  ///
  /// Returns: Future<String?>, a success message indicating the change in bundle ID.
  @override
  Future<String?> setBundleId({required String bundleId}) async {
    final filePath = macosAppInfoxprojPath;
    List? contentLineByLine = await readFileAsLineByline(
      filePath: filePath,
    );
    for (var i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i].contains('PRODUCT_BUNDLE_IDENTIFIER')) {
        contentLineByLine[i] = 'PRODUCT_BUNDLE_IDENTIFIER = $bundleId';
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
