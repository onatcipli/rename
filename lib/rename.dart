/// File: rename.dart
/// Project: rename
/// Author: Onat Cipli
/// Created Date: 24.09.2023
/// Description: This file contains the Rename class which is responsible for renaming platform files.

import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import 'package:rename/platform_file_editors/android_platform_file_editor.dart';
import 'package:rename/platform_file_editors/ios_platform_file_editor.dart';
import 'package:rename/platform_file_editors/linux_platform_file_editor.dart';
import 'package:rename/platform_file_editors/macos_platform_file_editor.dart';
import 'package:rename/platform_file_editors/web_platform_file_editor.dart';
import 'package:rename/platform_file_editors/windows_platform_file_editor.dart';

import 'enums.dart';

/// [Rename] is responsible for renaming platform files.
/// Attributes:
/// - [platformFileEditors]: Map of platforms to their respective file editors.
class Rename {
  final Map<RenamePlatform, AbstractPlatformFileEditor> platformFileEditors;

  /// Creates a new instance of [Rename].
  ///
  /// Parameters:
  /// - `platformFileEditors`: Map of platforms to their respective file editors.
  Rename({required this.platformFileEditors});

  /// Creates a new instance of [Rename] from a list of targets.
  ///
  /// Parameters:
  /// - `targets`: List of platforms to generate file editors for.
  factory Rename.fromTargets({required List<RenamePlatform> targets}) {
    var platformFileEditors = _generatePlatformFileEditors(targets: targets);
    return Rename(platformFileEditors: platformFileEditors);
  }

  /// Creates a new instance of [Rename] from a list of platform names.
  ///
  /// Parameters:
  /// - `platformNames`: List of platform names to generate file editors for.
  factory Rename.fromPlatformNames({required List<String> platformNames}) {
    var targets = platformNames.map((name) {
      return RenamePlatform.values.firstWhere(
        (e) => e.name == name,
        orElse: () => throw ArgumentError('Invalid platform name: $name'),
      );
    }).toList();
    var platformFileEditors = _generatePlatformFileEditors(targets: targets);
    return Rename(platformFileEditors: platformFileEditors);
  }

  /// Generates a map of [RenamePlatform] to [AbstractPlatformFileEditor] based on the provided targets.
  ///
  /// Parameters:
  /// - `targets`: List of platforms to generate file editors for.
  ///
  /// Returns: Map of [RenamePlatform] to [AbstractPlatformFileEditor].
  static Map<RenamePlatform, AbstractPlatformFileEditor>
      _generatePlatformFileEditors({
    required List<RenamePlatform> targets,
  }) {
    var editors = <RenamePlatform, AbstractPlatformFileEditor>{};
    for (var target in targets) {
      switch (target) {
        case RenamePlatform.android:
          editors[target] = AndroidPlatformFileEditor();
          break;
        case RenamePlatform.ios:
          editors[target] = IosPlatformFileEditor();
          break;
        case RenamePlatform.macOS:
          editors[target] = MacosPlatformFileEditor();
          break;
        case RenamePlatform.linux:
          editors[target] = LinuxPlatformFileEditor();
          break;
        case RenamePlatform.web:
          editors[target] = WebPlatformFileEditor();
          break;
        case RenamePlatform.windows:
          editors[target] = WindowsPlatformFileEditor();
          break;
      }
    }
    return editors;
  }

  /// Applies the rename command to all platform file editors.
  ///
  /// Parameters:
  /// - `command`: The rename command to apply.
  /// - `value`: The value to set.
  Future<void> applyWithCommand({
    RenameCommand? command,
    String? value,
  }) async {
    if (command == null) {
      throw ArgumentError('Command cannot be null');
    }
    await _handleCommand(command, value);
  }

  /// Applies the rename command to all platform file editors.
  ///
  /// Parameters:
  /// - `commandName`: The name of the rename command to apply.
  /// - `value`: The value to set.
  Future<void> applyWithCommandName({
    String? commandName,
    String? value,
  }) async {
    if (commandName == null) {
      throw ArgumentError('Command name cannot be null');
    }
    var command = RenameCommand.values.firstWhere(
      (e) => e.name == commandName,
      orElse: () => throw ArgumentError('Invalid command name: $commandName'),
    );
    await _handleCommand(command, value);
  }

  /// Handles the rename command for all platform file editors.
  ///
  /// Parameters:
  /// - `command`: The rename command to handle.
  /// - `value`: The value to set.
  Future<void> _handleCommand(RenameCommand command, String? value) async {
    for (var platformFileEditor in platformFileEditors.values) {
      String? message;
      switch (command) {
        case RenameCommand.setAppName:
          message = await platformFileEditor.setAppName(appName: value!);
          break;
        case RenameCommand.getAppName:
          message = await platformFileEditor.getAppName();
          break;
        case RenameCommand.setBundleId:
          message = await platformFileEditor.setBundleId(bundleId: value!);
          break;
        case RenameCommand.getBundleId:
          message = await platformFileEditor.getBundleId();
          break;
        // Add other RenameCommand actions here
        // case RenameCommand.otherCommand:
        //   await platformFileEditor.otherMethod(value: value!);
        //   break;
        default:
          throw ArgumentError('Invalid command: $command');
      }
      if (command.index == RenameCommand.getAppName.index ||
          command.index == RenameCommand.getBundleId.index) {
        logger.i(
            '${platformFileEditor.platform.name.toUpperCase()} ${command.name} => $message');
      } else {
        logger.i(message);
      }
    }
  }
}
