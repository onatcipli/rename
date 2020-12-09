import 'dart:convert';
import 'dart:io';

import 'package:logger/logger.dart';

class FileRepository {
  Logger logger;
  String androidManifestPath =
      '.\\android\\app\\src\\main\\AndroidManifest.xml';
  String iosInfoPlistPath = '.\\ios\\Runner\\Info.plist';
  String androidAppBuildGradlePath = '.\\android\\app\\build.gradle';
  String iosProjectPbxprojPath = '.\\ios\\Runner.xcodeproj\\project.pbxproj';
  String macosAppInfoxprojPath = '.\\macos\\Runner\\Configs\\AppInfo.xcconfig';
  String launcherIconPath = '.\\assets\\images\\launcherIcon.png';

  FileRepository({required this.logger}) {
    if (Platform.isMacOS || Platform.isLinux) {
      androidManifestPath = 'android/app/src/main/AndroidManifest.xml';
      iosInfoPlistPath = 'ios/Runner/Info.plist';
      androidAppBuildGradlePath = 'android/app/build.gradle';
      iosProjectPbxprojPath = 'ios/Runner.xcodeproj/project.pbxproj';
      macosAppInfoxprojPath = 'macos/Runner/Configs/AppInfo.xcconfig';
      launcherIconPath = 'assets/images/launcherIcon.png';
    }
  }

  Future<File?> changeLauncherIcon({required String base64String}) async {
    var file = File(launcherIconPath);
    List<int> _bytes = Base64Decoder().convert(base64String);
    await file.writeAsBytes(_bytes);
    return file;
  }

  Future<List<String>?> readFileAsLineByline({required String filePath}) async {
    try {
      var fileAsString = await File(filePath).readAsString();
      return fileAsString.split('\n');
    } catch (e) {
      return null;
    }
  }

  Future<File> writeFile({required String filePath, required String content}) {
    return File(filePath).writeAsString(content);
  }

  Future<File?> changeIosBundleId({required String bundleId}) async {
    var contentLineByLine = await readFileAsLineByline(
      filePath: iosProjectPbxprojPath,
    );
    if (checkFileExists(contentLineByLine)) {
      logger.w('''
      Ios BundleId could not be changed because,
      The related file could not be found in that path:  ${iosProjectPbxprojPath}
      ''');
      return null;
    }
    if (contentLineByLine != null) {
      for (var i = 0; i < contentLineByLine.length; i++) {
        if (contentLineByLine[i].contains('PRODUCT_BUNDLE_IDENTIFIER')) {
          contentLineByLine[i] = '				PRODUCT_BUNDLE_IDENTIFIER = $bundleId;';
        }
      }
      var writtenFile = await writeFile(
        filePath: iosProjectPbxprojPath,
        content: contentLineByLine.join('\n'),
      );
      logger.i('IOS BundleIdentifier changed successfully to : $bundleId');
      return writtenFile;
    }
  }

  Future<File?> changeMacOsBundleId({required String bundleId}) async {
    var contentLineByLine = await readFileAsLineByline(
      filePath: macosAppInfoxprojPath,
    );
    if (checkFileExists(contentLineByLine)) {
      logger.w('''
      macOS BundleId could not be changed because,
      The related file could not be found in that path:  ${macosAppInfoxprojPath}
      ''');
      return null;
    }
    if (contentLineByLine != null) {
      for (var i = 0; i < contentLineByLine.length; i++) {
        if (contentLineByLine[i].contains('PRODUCT_BUNDLE_IDENTIFIER')) {
          contentLineByLine[i] = 'PRODUCT_BUNDLE_IDENTIFIER = $bundleId;';
        }
      }
      var writtenFile = await writeFile(
        filePath: macosAppInfoxprojPath,
        content: contentLineByLine.join('\n'),
      );
      logger.i('MacOS BundleIdentifier changed successfully to : $bundleId');
      return writtenFile;
    }
  }

  Future<File?> changeAndroidBundleId({required String bundleId}) async {
    var contentLineByLine = await readFileAsLineByline(
      filePath: androidAppBuildGradlePath,
    );
    if (checkFileExists(contentLineByLine)) {
      logger.w('''
      Android BundleId could not be changed because,
      The related file could not be found in that path:  ${androidAppBuildGradlePath}
      ''');
      return null;
    }
    if (contentLineByLine != null) {
      for (var i = 0; i < contentLineByLine.length; i++) {
        if (contentLineByLine[i].contains('applicationId')) {
          contentLineByLine[i] = '        applicationId \"${bundleId}\"';
          break;
        }
      }
      var writtenFile = await writeFile(
        filePath: androidAppBuildGradlePath,
        content: contentLineByLine.join('\n'),
      );
      logger.i('Android bundleId changed successfully to : $bundleId');
      return writtenFile;
    }
  }

  Future<File?> changeIosAppName(String appName) async {
    var contentLineByLine = await readFileAsLineByline(
      filePath: iosInfoPlistPath,
    );
    if (checkFileExists(contentLineByLine)) {
      logger.w('''
      Ios AppName could not be changed because,
      The related file could not be found in that path:  ${iosInfoPlistPath}
      ''');
      return null;
    }
    if (contentLineByLine != null) {
      for (var i = 0; i < contentLineByLine.length; i++) {
        if (contentLineByLine[i].contains('<key>CFBundleName</key>')) {
          contentLineByLine[i + 1] = '\t<string>${appName}</string>\r';
          break;
        }
      }
      var writtenFile = await writeFile(
        filePath: iosInfoPlistPath,
        content: contentLineByLine.join('\n'),
      );
      logger.i('IOS appname changed successfully to : $appName');
      return writtenFile;
    }
  }

  Future<File?> changeMacOsAppName(String appName) async {
    var contentLineByLine = await readFileAsLineByline(
      filePath: macosAppInfoxprojPath,
    );
    if (checkFileExists(contentLineByLine)) {
      logger.w('''
      macOS AppName could not be changed because,
      The related file could not be found in that path:  ${macosAppInfoxprojPath}
      ''');
      return null;
    }
    if (contentLineByLine != null) {
      for (var i = 0; i < contentLineByLine.length; i++) {
        if (contentLineByLine[i].contains('PRODUCT_NAME')) {
          contentLineByLine[i] = 'PRODUCT_NAME = $appName;';
          break;
        }
      }
      var writtenFile = await writeFile(
        filePath: macosAppInfoxprojPath,
        content: contentLineByLine.join('\n'),
      );
      logger.i('MacOS appname changed successfully to : $appName');
      return writtenFile;
    }
  }

  Future<File?> changeAndroidAppName(String appName) async {
    var contentLineByLine = await readFileAsLineByline(
      filePath: androidManifestPath,
    );
    if (checkFileExists(contentLineByLine)) {
      logger.w('''
      Android AppName could not be changed because,
      The related file could not be found in that path:  ${androidManifestPath}
      ''');
      return null;
    }
    if (contentLineByLine != null) {
      for (var i = 0; i < contentLineByLine.length; i++) {
        if (contentLineByLine[i].contains('android:label')) {
          contentLineByLine[i] = '        android:label=\"${appName}\"';
          break;
        }
      }
      var writtenFile = await writeFile(
        filePath: androidManifestPath,
        content: contentLineByLine.join('\n'),
      );
      logger.i('Android appname changed successfully to : $appName');
      return writtenFile;
    }
  }

  Future<String?> getCurrentIosAppName() async {
    var contentLineByLine = await readFileAsLineByline(
      filePath: iosInfoPlistPath,
    );
    if (contentLineByLine != null) {
      for (var i = 0; i < contentLineByLine.length; i++) {
        if (contentLineByLine[i].contains('<key>CFBundleName</key>')) {
          return (contentLineByLine[i + 1]).trim().substring(5, 5);
        }
      }
    }
  }

  Future<String?> getCurrentAndroidAppName() async {
    var contentLineByLine = await readFileAsLineByline(
      filePath: androidManifestPath,
    );
    if (contentLineByLine != null) {
      for (var i = 0; i < contentLineByLine.length; i++) {
        if (contentLineByLine[i].contains('android:label')) {
          return (contentLineByLine[i]).split('"')[1];
        }
      }
    }
  }

  bool checkFileExists(List? fileContent) {
    return fileContent == null || fileContent.isEmpty;
  }
}
