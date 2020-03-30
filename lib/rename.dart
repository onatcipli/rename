import 'package:rename/file_repository.dart';
import 'dart:io';

/// You should call this function in your flutter project root directory
///
FileRepository fileRepository = FileRepository();

enum Platform {
  android,
  ios,
  macOS,
}

Future changeAppName({String appName, Iterable<Platform> platforms}) async {
  var oldName = await fileRepository.getCurrentPubSpecName(appName);
  if (platforms.isEmpty || platforms.contains(Platform.ios)) {
    await fileRepository.changeIosAppName(appName);
  }
  if (platforms.isEmpty || platforms.contains(Platform.macOS)) {
    await fileRepository.changeMacOsAppName(appName);
  }
  if (platforms.isEmpty || platforms.contains(Platform.android)) {
    await fileRepository.changeAndroidAppName(appName);
  }
  changeFilesImports(appName, oldName);
}

Future changePubspecName(String appName, Iterable<Platform> platforms) async {
  // await fileRepository.getCurrentPubSpecAppName();
  await fileRepository.changePubSpecName(appName);
}

Future changeBundleId(String bundleId, Iterable<Platform> platforms) async {
  if (platforms.isEmpty || platforms.contains(Platform.ios)) {
    await fileRepository.changeIosBundleId(bundleId: bundleId);
  }
  if (platforms.isEmpty || platforms.contains(Platform.macOS)) {
    await fileRepository.changeMacOsBundleId(bundleId: bundleId);
  }
  if (platforms.isEmpty || platforms.contains(Platform.android)) {
    await fileRepository.changeAndroidBundleId(bundleId: bundleId);
  }
}

Future changeLauncherIcon(String base64) async {
  await fileRepository.changeLauncherIcon(base64String: base64);
}

Future<String> getPubSpecName(String path) async {
  return fileRepository.getCurrentPubSpecName(path);
}

Future<String> getIosAppName() async {
  return fileRepository.getCurrentIosAppName();
}

Future<String> getAndroidAppName() async {
  return fileRepository.getCurrentAndroidAppName();
}

void changeFilesImports(String appName, String oldAppName) {
  var dir = Directory(appName);
  // List directory contents, recursing into sub-directories,
  // but not following symbolic links.
  dir
      .list(recursive: true, followLinks: false)
      .listen((FileSystemEntity entity) {
    if (entity.path.endsWith('dart') || entity.path.endsWith('.yaml')) {
      fileRepository.changeImportName(appName, entity.path, oldAppName);
    }
  });
}
