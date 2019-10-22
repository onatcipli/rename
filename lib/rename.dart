import 'package:rename/file_repository.dart';

/// You should call this function in your flutter project root directory
///
FileRepository fileRepository = FileRepository();

Future changeAppName(String appName) async {
  await fileRepository.changeIosAppName(appName);
  await fileRepository.changeAndroidAppName(appName);
}

Future changeBundleId(String bundleId) async {
  await fileRepository.changeIosBundleId(bundleId: bundleId);
  await fileRepository.changeAndroidBundleId(bundleId: bundleId);
}

Future changeLauncherIcon() async {
  await fileRepository.changeLauncherIcon();
}

Future<String> getIosAppName() async {
  return fileRepository.getCurrentIosAppName();
}

Future<String> getAndroidAppName() async {
  return fileRepository.getCurrentAndroidAppName();
}
