import 'dart:io';

const androidManifestPath = ".\\android\\app\\src\\main\\AndroidManifest.xml";
const iosInfoPlistPath = ".\\ios\\Runner\\Info.plist";

class FileRepository {
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

  Future<List<String>> readFileAsLineByline({String filePath}) async {
    String fileAsString = await File(filePath).readAsString();
    return fileAsString.split("\n");
  }

  Future<File> writeFile({String filePath, String content}) {
    return File(filePath).writeAsString(content);
  }
}
