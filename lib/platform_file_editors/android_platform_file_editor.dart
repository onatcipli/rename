/// File: android_platform_file_editor.dart
/// Project: rename
/// Author: Onat Cipli
/// Created Date: 24.09.2023
/// Description: This file defines the AndroidPlatformFileEditor class which is responsible for editing Android platform files.
/// Contributors:
/// - Gabriele, 2025-04-30: Updated Gradle compatibility.

// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:rename/custom_exceptions.dart';
import 'package:rename/enums.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import 'package:rename/utils/files.dart';

abstract class BundleStrategy {
  Future<String?> setBundleId({required String bundleId});
  Future<String?> getBundleId();
}

/// [GroovyStrategy] implements [BundleStrategy] for handling Gradle build files.
class GroovyStrategy implements BundleStrategy {
  final String filePath;

  GroovyStrategy(this.filePath);

  @override
  Future<String?> getBundleId() async {
    var contentLineByLine = await readFileAsLineByline(
      filePath: filePath,
      platform: RenamePlatform.android,
    );
    for (var i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i]?.contains('applicationId') ?? false) {
        return (contentLineByLine[i] as String).split('"')[1].trim();
      }
    }
    return null;
  }

  @override
  Future<String?> setBundleId({required String bundleId}) async {
    List? contentLineByLine = await readFileAsLineByline(
      filePath: filePath,
      platform: RenamePlatform.android,
    );
    for (var i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i].contains('applicationId')) {
        contentLineByLine[i] = '        applicationId \"$bundleId\"';
        break;
      }
    }
    await writeFile(
      filePath: filePath,
      content: contentLineByLine.join('\n'),
      platform: RenamePlatform.android,
    );
    return 'Bundle ID set to $bundleId';
  }
}

/// [KotlinDSLStrategy] implements [BundleStrategy] for handling Gradle KTS build files.
class KotlinDSLStrategy implements BundleStrategy {
  final String filePath;

  KotlinDSLStrategy(this.filePath);

  @override
  Future<String?> getBundleId() async {
    var contentLineByLine = await readFileAsLineByline(
      filePath: filePath,
      platform: RenamePlatform.android,
    );
    for (var i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i]?.contains('applicationId') ?? false) {
        return (contentLineByLine[i] as String).split('=')[1].trim();
      }
    }
    return null;
  }

  @override
  Future<String?> setBundleId({required String bundleId}) async {
    List? contentLineByLine = await readFileAsLineByline(
      filePath: filePath,
      platform: RenamePlatform.android,
    );
    for (var i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i].contains('applicationId')) {
        contentLineByLine[i] = '        applicationId = \"$bundleId\"';
        break;
      }
    }
    await writeFile(
      filePath: filePath,
      content: contentLineByLine.join('\n'),
      platform: RenamePlatform.android,
    );
    return 'Bundle ID set to $bundleId';
  }
}

class BundleStrategyFactory {
  static final String _androidAppBuildGradlePath = convertPath(
    ['android', 'app', 'build.gradle'],
  );
  static final String _androidAppBuildGradleKtsPath = convertPath(
    ['android', 'app', 'build.gradle.kts'],
  );

  BundleStrategyFactory._();

  static BundleStrategy create() {
    final existLegacyBuildGradleFile =
        File(_androidAppBuildGradlePath).existsSync();
    final existBuildGradleKtsFile =
        File(_androidAppBuildGradleKtsPath).existsSync();

    if (existLegacyBuildGradleFile && existBuildGradleKtsFile) {
      throw CustomException(
        "Detected both 'build.gradle' (Groovy) and 'build.gradle.kts' (Kotlin DSL). Please remove one of the files to prevent build script ambiguities.",
      );
    } else if (existLegacyBuildGradleFile) {
      return GroovyStrategy(_androidAppBuildGradlePath);
    } else if (existBuildGradleKtsFile) {
      return KotlinDSLStrategy(_androidAppBuildGradleKtsPath);
    } else {
      throw CustomException(
        "Missing build script: Could not find 'build.gradle' (Groovy) or 'build.gradle.kts' (Kotlin DSL) in the android/app directory.",
      );
    }
  }
}

/// [AndroidPlatformFileEditor] is a class that extends [AbstractPlatformFileEditor] and provides methods to edit Android platform files.
/// Attributes:
/// - [androidManifestPath]: Specifies the path to the Android Manifest file.
/// - [androidAppBuildGradlePath]: Specifies the path to the Android App Build Gradle file.
class AndroidPlatformFileEditor extends AbstractPlatformFileEditor {
  final String androidManifestPath = convertPath(
    ['android', 'app', 'src', 'main', 'AndroidManifest.xml'],
  );

  final BundleStrategy _bundleStrategy = BundleStrategyFactory.create();

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
      platform: platform,
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
    return _bundleStrategy.getBundleId();
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
      platform: platform,
    );
    for (var i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i].contains('android:label=')) {
        contentLineByLine[i] = contentLineByLine[i].toString().replaceFirst(
            RegExp(r'android:label="(.*?)"'), 'android:label="$appName"');
        break;
      }
    }
    final message = await super.setAppName(appName: appName);
    var writtenFile = await writeFile(
      filePath: filePath,
      content: contentLineByLine.join('\n'),
      platform: platform,
    );
    return message;
  }

  /// Changes the Bundle ID in the Android App Build Gradle file to the provided [bundleId].
  /// Parameters:
  /// - `bundleId`: The new Bundle ID to be set for the application.
  /// Returns: Future<String?>, a success message indicating the change in Bundle ID.
  @override
  Future<String?> setBundleId({required String bundleId}) async {
    final message = await _bundleStrategy.setBundleId(bundleId: bundleId);
    return await super.setBundleId(bundleId: bundleId);
  }
}
