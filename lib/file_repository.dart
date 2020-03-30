import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;

class FileRepository {
  String androidManifestPath =
      ".\\android\\app\\src\\main\\AndroidManifest.xml";
  String iosInfoPlistPath = ".\\ios\\Runner\\Info.plist";
  String androidAppBuildGradlePath = ".\\android\\app\\build.gradle";
  String iosProjectPbxprojPath = ".\\ios\\Runner.xcodeproj\\project.pbxproj";
  String macosAppInfoxprojPath = ".\\macos\\Runner\\Configs\\AppInfo.xcconfig";
  String launcherIconPath = ".\\assets\\images\\launcherIcon.png";
  String pubspecPath = "pubspec.yaml";

  FileRepository() {
    if (Platform.isMacOS || Platform.isLinux) {
      androidManifestPath = "android/app/src/main/AndroidManifest.xml";
      iosInfoPlistPath = "ios/Runner/Info.plist";
      androidAppBuildGradlePath = "android/app/build.gradle";
      iosProjectPbxprojPath = "ios/Runner.xcodeproj/project.pbxproj";
      macosAppInfoxprojPath = "macos/Runner/Configs/AppInfo.xcconfig";
      launcherIconPath = "assets/images/launcherIcon.png";
      pubspecPath = "pubspec.yaml";
    }
  }

  Future<File> changeLauncherIcon({String base64String}) async {
    File file = File(launcherIconPath);
    if (base64String != null) {
      List<int> _bytes = Base64Decoder().convert(base64String);
      await file.writeAsBytes(_bytes);
      return file;
    }
  }

  Future<List<String>> readFileAsLineByline({String filePath}) async {
    String fileAsString = await File(filePath).readAsString();
    return fileAsString.split("\n");
  }

  Future<File> writeFile({String filePath, String content}) {
    return File(filePath).writeAsString(content);
  }

  Future<File> changeIosBundleId({String bundleId}) async {
    List contentLineByLine = await readFileAsLineByline(
      filePath: iosProjectPbxprojPath,
    );
    for (int i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i].contains("PRODUCT_BUNDLE_IDENTIFIER")) {
        contentLineByLine[i] = "				PRODUCT_BUNDLE_IDENTIFIER = $bundleId;";
      }
    }
    File writtenFile = await writeFile(
      filePath: iosProjectPbxprojPath,
      content: contentLineByLine.join('\n'),
    );
    print("IOS BundleIdentifier changed successfully to : $bundleId");
    return writtenFile;
  }

  Future<File> changeMacOsBundleId({String bundleId}) async {
    List contentLineByLine = await readFileAsLineByline(
      filePath: macosAppInfoxprojPath,
    );
    for (int i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i].contains("PRODUCT_BUNDLE_IDENTIFIER")) {
        contentLineByLine[i] = "PRODUCT_BUNDLE_IDENTIFIER = $bundleId;";
      }
    }
    File writtenFile = await writeFile(
      filePath: macosAppInfoxprojPath,
      content: contentLineByLine.join('\n'),
    );
    print("MacOS BundleIdentifier changed successfully to : $bundleId");
    return writtenFile;
  }

  Future<File> changeAndroidBundleId({String bundleId}) async {
    List contentLineByLine = await readFileAsLineByline(
      filePath: androidAppBuildGradlePath,
    );
    for (int i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i].contains("applicationId")) {
        contentLineByLine[i] = "        applicationId \"${bundleId}\"";
        break;
      }
    }
    File writtenFile = await writeFile(
      filePath: androidAppBuildGradlePath,
      content: contentLineByLine.join('\n'),
    );
    print("Android bundleId changed successfully to : $bundleId");
    return writtenFile;
  }

  Future<File> changeIosAppName(String appName) async {
    List contentLineByLine = await readFileAsLineByline(
        filePath: p.join(
      appName,
      iosInfoPlistPath,
    ));
    for (int i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i].contains("<key>CFBundleName</key>")) {
        contentLineByLine[i + 1] = "\t<string>${appName}</string>\r";
        break;
      }
    }
    File writtenFile = await writeFile(
      filePath: p.join(
        appName,
        iosInfoPlistPath,
      ),
      content: contentLineByLine.join('\n'),
    );
    print("IOS appname changed successfully to : $appName");
    return writtenFile;
  }

  Future<File> changeMacOsAppName(String appName) async {
    List contentLineByLine = await readFileAsLineByline(
        filePath: p.join(
      appName,
      macosAppInfoxprojPath,
    ));
    for (int i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i].contains("PRODUCT_NAME")) {
        contentLineByLine[i] = "PRODUCT_NAME = $appName;";
        break;
      }
    }
    File writtenFile = await writeFile(
      filePath: p.join(
        appName,
        macosAppInfoxprojPath,
      ),
      content: contentLineByLine.join('\n'),
    );
    print("MacOS appname changed successfully to : $appName");
    return writtenFile;
  }

  Future<File> changeAndroidAppName(String appName) async {
    List contentLineByLine = await readFileAsLineByline(
      filePath: p.join(
        appName,
        androidManifestPath,
      ),
    );
    for (int i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i].contains("android:label")) {
        contentLineByLine[i] = "        android:label=\"${appName}\"";
        break;
      }
    }
    File writtenFile = await writeFile(
      filePath: p.join(
        appName,
        androidManifestPath,
      ),
      content: contentLineByLine.join('\n'),
    );
    print("Android appname changed successfully to : $appName");
    return writtenFile;
  }

  Future<File> changePubSpecName(String appName) async {
    List contentLineByLine = await readFileAsLineByline(
      filePath: pubspecPath,
    );
    for (var i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i].contains('name:')) {
        contentLineByLine[i] = 'name: $appName';
        break;
      }
    }
    var writtenFile = await writeFile(
      filePath: pubspecPath,
      content: contentLineByLine.join('\n'),
    );
    print('Pubspec appname changed successfully to : $appName');
    return writtenFile;
  }

  Future<File> changeImportName(
      String appName, String filePath, String oldAppName) async {
    List contentLineByLine = await readFileAsLineByline(
      filePath: filePath,
    );
    var oldApp = oldAppName.trim();
    var newApp = appName.trim();
    for (var i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i].indexOf(oldApp) > 0) {
        contentLineByLine[i] =
            contentLineByLine[i].replaceFirst(oldApp, '$newApp');
      }
    }
    var writtenFile = await writeFile(
      filePath: filePath,
      content: contentLineByLine.join('\n'),
    );
    print('Import $oldApp changed successfully to : $newApp');
    return writtenFile;
  }

  // ignore: missing_return
  Future<String> getCurrentIosAppName() async {
    List contentLineByLine = await readFileAsLineByline(
      filePath: iosInfoPlistPath,
    );
    for (var i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i].contains('<key>CFBundleName</key>')) {
        return (contentLineByLine[i + 1] as String).trim().substring(5, 5);
      }
    }
  }

  // ignore: missing_return
  Future<String> getCurrentAndroidAppName() async {
    List contentLineByLine = await readFileAsLineByline(
      filePath: androidManifestPath,
    );
    for (var i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i].contains('android:label')) {
        return (contentLineByLine[i] as String).split('"')[1];
      }
    }
  }

  // ignore: missing_return
  Future<String> getCurrentPubSpecName(String dirPath) async {
    List contentLineByLine = await readFileAsLineByline(
      filePath: p.join(dirPath, pubspecPath),
    );

    for (int i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i].contains('name:')) {
        return (contentLineByLine[i] as String).split(':')[1];
      }
    }
  }
}
