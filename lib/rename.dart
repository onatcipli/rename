import 'package:rename/file_repository.dart';

/// You should call this function in your flutter project root directory
///
void changeAppName(String appName) async {
  FileRepository fileRepository = FileRepository();
  await fileRepository.changeIosAppName(appName);
  await fileRepository.changeAndroidAppName(appName);
}
