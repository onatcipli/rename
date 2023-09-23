/// File: android_platform_file_editor.dart
/// Project: rename
/// Author: Onat Cipli
/// Created Date: 24.09.2023
/// Description: This file defines the AndroidPlatformFileEditor class which is responsible for editing Android platform files.

// ignore_for_file: unused_local_variable

import 'package:rename/enums.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

/// [AndroidPlatformFileEditor] is a class that extends [AbstractPlatformFileEditor] and provides methods to edit Android platform files.
/// Attributes:
/// - [androidManifestPath]: Specifies the path to the Android Manifest file.
/// - [androidAppBuildGradlePath]: Specifies the path to the Android App Build Gradle file.
class AndroidPlatformFileEditor extends AbstractPlatformFileEditor {
  final String androidManifestPath = AbstractPlatformFileEditor.convertPath(
    ['android', 'app', 'src', 'main', 'AndroidManifest.xml'],
  );
  final String androidAppBuildGradlePath =
      AbstractPlatformFileEditor.convertPath(
    ['android', 'app', 'build.gradle'],
  );

  /// Creates an instance of [AndroidPlatformFileEditor].
  /// Parameters:
  /// - `platform`: Specifies the platform for which the file editor is defined. Default is [RenamePlatform.android].
  AndroidPlatformFileEditor({
    RenamePlatform platform = RenamePlatform.android,
  }) : super(platform: platform);

  /// Fetches the app name from the Android Manifest file.
  /// Returns: Future<String?>, the name of the application.
  @override
  Future<String?> getAppName() async {
    final filePath = androidManifestPath;
    var contentLineByLine = await readFileAsLineByline(
      filePath: filePath,
    );
    for (var i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i]?.contains('android:label=') ?? false) {
        return (contentLineByLine[i] as String).split('"')[1].trim();
      }
    }
    return null;
  }

  /// Fetches the bundle ID from the Android App Build Gradle file.
  /// Returns: Future<String?>, the Bundle ID of the application.
  @override
  Future<String?> getBundleId() async {
    final filePath = androidAppBuildGradlePath;
    var contentLineByLine = await readFileAsLineByline(
      filePath: filePath,
    );
    for (var i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i]?.contains('applicationId') ?? false) {
        return (contentLineByLine[i] as String).split('"')[1].trim();
      }
    }
    return null;
  }

  /// Changes the app name in the Android Manifest file to the provided [appName].
  /// Parameters:
  /// - `appName`: The new name to be set for the application.
  /// Returns: Future<String?>, a success message indicating the change in application name.
  @override
  Future<String?> setAppName({required String appName}) async {
    final filePath = androidManifestPath;
    List? contentLineByLine = await readFileAsLineByline(
      filePath: filePath,
    );
    for (var i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i].contains('android:label=')) {
        contentLineByLine[i] = '        android:label=\"$appName\"';
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

  /// Changes the Bundle ID in the Android App Build Gradle file to the provided [bundleId].
  /// Parameters:
  /// - `bundleId`: The new Bundle ID to be set for the application.
  /// Returns: Future<String?>, a success message indicating the change in Bundle ID.
  @override
  Future<String?> setBundleId({required String bundleId}) async {
    final filePath = androidAppBuildGradlePath;
    List? contentLineByLine = await readFileAsLineByline(
      filePath: filePath,
    );
    for (var i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i].contains('applicationId')) {
        contentLineByLine[i] = '        applicationId \"$bundleId\"';
        break;
      }
    }
    final message = await super.setBundleId(bundleId: bundleId);
    var writtenFile = await writeFile(
      filePath: filePath,
      content: contentLineByLine.join('\n'),
    );
    return message;
  }
}
