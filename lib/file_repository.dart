import 'dart:io';

class FileRepository {
  String androidManifestPath =
      ".\\android\\app\\src\\main\\AndroidManifest.xml";
  String iosInfoPlistPath = ".\\ios\\Runner\\Info.plist";
  String androidAppBuildGradlePath = ".\\android\\app\\build.gradle";

  FileRepository() {
    if (Platform.isMacOS || Platform.isLinux) {
      androidManifestPath = "android/app/src/main/AndroidManifest.xml";
      iosInfoPlistPath = "ios/Runner/Info.plist";
      androidManifestPath = "android/app/build.gradle";
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
      filePath: iosInfoPlistPath,
    );
    for (int i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i].contains("<key>CFBundleIdentifier</key>")) {
        contentLineByLine[i + 1] = "\t<string>${bundleId}</string>\r";
        break;
      }
    }
    File writtenFile = await writeFile(
      filePath: iosInfoPlistPath,
      content: contentLineByLine.join('\n'),
    );
    print("IOS BundleIdentifier changed successfully to : $bundleId");
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
      filePath: androidManifestPath,
      content: contentLineByLine.join('\n'),
    );
    print("Android bundleId changed successfully to : $bundleId");
    return writtenFile;
  }

  Future<File> changeIosAppName(String appName) async {
    List contentLineByLine = await readFileAsLineByline(
      filePath: iosInfoPlistPath,
    );
    for (int i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i].contains("<key>CFBundleName</key>")) {
        contentLineByLine[i + 1] = "\t<string>${appName}</string>\r";
        break;
      }
    }
    File writtenFile = await writeFile(
      filePath: iosInfoPlistPath,
      content: contentLineByLine.join('\n'),
    );
    print("IOS appname changed successfully to : $appName");
    return writtenFile;
  }

  Future<File> changeAndroidAppName(String appName) async {
    List contentLineByLine = await readFileAsLineByline(
      filePath: androidManifestPath,
    );
    for (int i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i].contains("android:label")) {
        contentLineByLine[i] = "        android:label=\"${appName}\"";
        break;
      }
    }
    File writtenFile = await writeFile(
      filePath: androidManifestPath,
      content: contentLineByLine.join('\n'),
    );
    print("Android appname changed successfully to : $appName");
    return writtenFile;
  }

  // ignore: missing_return
  Future<String> getCurrentIosAppName() async {
    List contentLineByLine = await readFileAsLineByline(
      filePath: iosInfoPlistPath,
    );
    for (int i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i].contains("<key>CFBundleName</key>")) {
        return (contentLineByLine[i + 1] as String).trim().substring(5, 5);
      }
    }
  }

  // ignore: missing_return
  Future<String> getCurrentAndroidAppName() async {
    List contentLineByLine = await readFileAsLineByline(
      filePath: androidManifestPath,
    );
    for (int i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i].contains("android:label")) {
        return (contentLineByLine[i] as String).split('"')[1];
      }
    }
  }
}
