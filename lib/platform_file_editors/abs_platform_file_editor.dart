import 'package:logger/logger.dart';
import 'package:rename/enums.dart';

final Logger logger = Logger(
  filter: ProductionFilter(),
);

/// [AbstractPlatformFileEditor] is an abstract class that provides a blueprint for platform-specific file editors.
/// It defines the common methods that all platform file editors should implement.
/// Attributes:
/// - [platform]: Specifies the platform for which the file editor is defined.
abstract class AbstractPlatformFileEditor {
  final RenamePlatform platform;

  AbstractPlatformFileEditor({required this.platform});

  /// Fetches the Bundle ID of the application.
  /// Returns: Future<String?>, the Bundle ID of the application.
  Future<String?> getBundleId();

  /// Changes the Bundle ID of the application to the provided [bundleId].
  /// Parameters:
  /// - `bundleId`: The new Bundle ID to be set for the application.
  /// Returns: Future<String?>, a success message indicating the change in Bundle ID.
  Future<String?> setBundleId({required String bundleId}) async {
    var old = await getBundleId();
    return 'rename has successfully changed bundleId for ${platform.name.toUpperCase()}\n$old -> $bundleId';
  }

  /// Fetches the name of the application.
  /// Returns: Future<String?>, the name of the application.
  Future<String?> getAppName();

  /// Changes the name of the application to the provided [appName].
  /// Parameters:
  /// - `appName`: The new name to be set for the application.
  /// Returns: Future<String?>, a success message indicating the change in application name.
  Future<String?> setAppName({required String appName}) async {
    var old = await getAppName();
    return 'rename has successfully changed appName for ${platform.name.toUpperCase()}\n$old -> $appName';
  }
}
