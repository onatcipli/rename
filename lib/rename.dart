import 'package:rename/file_repository.dart';

/// You should call this function in your flutter project root directory
///
FileRepository fileRepository = FileRepository();

void changeAppName(String appName) async {
  await fileRepository.changeIosAppName(appName);
  await fileRepository.changeAndroidAppName(appName);
}

Future<String> getIosAppName() async {
  return fileRepository.getCurrentIosAppName();
}

Future<String> getAndroidAppName() async {
  return fileRepository.getCurrentAndroidAppName();
}