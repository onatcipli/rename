import 'dart:io';

const androidManifestPath = ".\\android\\app\\src\\main\\AndroidManifest.xml";
const iosInfoPlistPath = ".\\ios\\Runner\\Info.plist";

class FileRepository {
  Future<File> changeIosAppName(String appName) async {
    List contentLineByLine = await readFileAsLineByline(
      filePath: iosInfoPlistPath,
    );
    for (int i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i].contains("<key>CFBundleName</key>")) {
        contentLineByLine[i + 1] = "\t<string>${appName}</string>\r";
        print(contentLineByLine[i + 1].toString());
      }
    }
    File writtenFile = await writeFile(
      filePath: iosInfoPlistPath,
      content: contentLineByLine.join('\n'),
    );
    print(await writtenFile.readAsString());
    return writtenFile;
  }

  Future<File> changeAndroidAppName(String appName) async {
    List contentLineByLine = await readFileAsLineByline(
      filePath: androidManifestPath,
    );
    for (int i = 0; i < contentLineByLine.length; i++) {
      if (contentLineByLine[i].contains("android:label")) {
        contentLineByLine[i] = "        android:label=\"${appName}\"";
        print(contentLineByLine[i].toString());
      }
    }
    File writtenFile = await writeFile(
      filePath: androidManifestPath,
      content: contentLineByLine.join('\n'),
    );
    print(await writtenFile.readAsString());
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
