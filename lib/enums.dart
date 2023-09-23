/// File: enums.dart
/// Project: rename
/// Author: Onat Cipli
/// Created Date: 24.09.2023
/// Description: This file defines enums and their extensions for the rename project.

/// [RenamePlatform] is an enum representing different platforms.
enum RenamePlatform {
  android,
  macOS,
  ios,
  linux,
  web,
  windows,
}

/// [RenameOption] is an enum representing different renaming options.
enum RenameOption {
  targets,
  value,
}

/// [RenameCommand] is an enum representing different commands for renaming.
enum RenameCommand {
  setAppName,
  setBundleId,
  getAppName,
  getBundleId,
  help,
}

/// Extension on [RenameOption] to provide additional functionalities.
extension RenameOptionExtension on RenameOption {
  /// Returns the name of the rename option.
  String get name {
    switch (this) {
      case RenameOption.targets:
        return 'targets';
      case RenameOption.value:
        return 'value';
      default:
        return '';
    }
  }

  /// Returns the abbreviation of the rename option.
  String get abbr {
    switch (this) {
      case RenameOption.targets:
        return 't';
      case RenameOption.value:
        return 'v';
      default:
        return '';
    }
  }
}

/// Extension on [RenameCommand] to provide additional functionalities.
extension RenameCommandExtension on RenameCommand {
  /// Returns the name of the rename command.
  String get name {
    switch (this) {
      case RenameCommand.setAppName:
        return 'setAppName';
      case RenameCommand.setBundleId:
        return 'setBundleId';
      case RenameCommand.getAppName:
        return 'getAppName';
      case RenameCommand.getBundleId:
        return 'getBundleId';
      case RenameCommand.help:
        return 'help';
      default:
        return '';
    }
  }
}

/// Extension on [RenamePlatform] to provide additional functionalities.
extension RenamePlatformExtension on RenamePlatform {
  /// Returns the name of the platform.
  String get name {
    switch (this) {
      case RenamePlatform.android:
        return 'android';
      case RenamePlatform.macOS:
        return 'macos';
      case RenamePlatform.ios:
        return 'ios';
      case RenamePlatform.linux:
        return 'linux';
      case RenamePlatform.web:
        return 'web';
      case RenamePlatform.windows:
        return 'windows';
      default:
        return '';
    }
  }
}
