/// File: rename_command_runner.dart
/// Project: rename
/// Author: Onat Cipli
/// Created Date: 24.09.2023
/// Description: This file defines RenameCommandRunner for the rename project and its commands, options etc.

import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:rename/enums.dart';
import 'package:rename/rename.dart';

/// [RenameCommandRunner] is responsible for running the rename command in the CLI tool.
/// It extends the CommandRunner class and overrides some of its methods.
class RenameCommandRunner extends CommandRunner<void> {
  /// Constructor for [RenameCommandRunner].
  /// It initializes the super class with the name of the command and its description.
  RenameCommandRunner()
      : super(
          'rename',
          'A CLI tool that helps for renaming in Flutter projects.',
        ) {
    argParser.addFlag(
      'version',
      abbr: 'v',
      negatable: false,
    );

    addCommand(GetAppNameCommand());
    addCommand(SetAppNameCommand());
    addCommand(GetBundleIdCommand());
    addCommand(SetBunleIdCommand());
  }
}

/// [PlatformFileEditorCommand] is an abstract class that extends the Command class.
/// It provides a base for all platform file editor commands.
abstract class PlatformFileEditorCommand extends Command {
  /// Constructor for [PlatformFileEditorCommand].
  /// It initializes the command with its name and description.
  PlatformFileEditorCommand(
    String executableName,
    String description,
  ) {
    argParser.addMultiOption(
      RenameOption.targets.name,
      help: 'Set which platforms to target.',
      abbr: RenameOption.targets.abbr,
      allowed: [
        RenamePlatform.ios.name,
        RenamePlatform.android.name,
        RenamePlatform.macOS.name,
        RenamePlatform.linux.name,
        RenamePlatform.web.name,
        RenamePlatform.windows.name,
      ],
      defaultsTo: [
        RenamePlatform.ios.name,
        RenamePlatform.android.name,
      ],
    );
  }
}

/// [SetPlatformFileEditorCommand] is an abstract class that extends the [PlatformFileEditorCommand] class.
/// It provides a base for all set platform file editor commands.
abstract class SetPlatformFileEditorCommand extends PlatformFileEditorCommand {
  /// Constructor for [SetPlatformFileEditorCommand].
  /// It initializes the command with its name and description.
  SetPlatformFileEditorCommand(
    String executableName,
    String description,
  ) : super(
          executableName,
          description,
        ) {
    argParser.addOption(
      RenameOption.value.name,
      abbr: RenameOption.value.abbr,
      help: 'Set value of the given command',
      mandatory: true,
    );
  }
}

/// [SetAppNameCommand] is a class that extends the [SetPlatformFileEditorCommand] class.
/// It is responsible for setting the app name for the targeted platforms.
class SetAppNameCommand extends SetPlatformFileEditorCommand {
  /// Constructor for [SetAppNameCommand].
  /// It initializes the command with its name and description.
  SetAppNameCommand()
      : super(
          RenameCommand.setAppName.name,
          'Set app name for the targeted platforms',
        );

  @override
  String get description => 'Set app name for the targeted platforms';

  @override
  String get name => RenameCommand.setAppName.name;

  @override
  FutureOr? run() {
    final targets = argResults?[RenameOption.targets.name];
    final value = argResults?[RenameOption.value.name];
    if (targets == null || targets.isEmpty) {
      print('No targets specified.');
      return null;
    }
    if (value == null || value.isEmpty) {
      print('value required for $name command.');
      return null;
    }

    print('Targets: $targets');
    print('Value: $value');
    final rename = Rename.fromPlatformNames(
      platformNames: targets,
    );
    return rename.applyWithCommandName(
      commandName: name,
      value: value,
    );
  }
}

/// [SetBunleIdCommand] is a class that extends the [SetPlatformFileEditorCommand] class.
/// It is responsible for setting the bundleId identifier for the targeted platforms.
class SetBunleIdCommand extends SetPlatformFileEditorCommand {
  /// Constructor for [SetBunleIdCommand].
  /// It initializes the command with its name and description.
  SetBunleIdCommand()
      : super(
          RenameCommand.setBundleId.name,
          'Set bundleId identifier for the targeted platforms',
        );

  @override
  String get description =>
      'Set bundleId identifier for the targeted platforms';

  @override
  String get name => RenameCommand.setBundleId.name;

  @override
  FutureOr? run() {
    final targets = argResults?[RenameOption.targets.name];
    final value = argResults?[RenameOption.value.name];
    if (targets == null || targets.isEmpty) {
      print('No targets specified.');
      return null;
    }
    if (value == null || value.isEmpty) {
      print('value required for $name command.');
      return null;
    }

    print('Targets: $targets');
    print('Value: $value');
    final rename = Rename.fromPlatformNames(
      platformNames: targets,
    );
    return rename.applyWithCommandName(
      commandName: name,
      value: value,
    );
  }
}

/// [GetAppNameCommand] is a class that extends the [PlatformFileEditorCommand] class.
/// It is responsible for getting the app names for the targeted platforms.
class GetAppNameCommand extends PlatformFileEditorCommand {
  /// Constructor for [GetAppNameCommand].
  /// It initializes the command with its name and description.
  GetAppNameCommand()
      : super(
          RenameCommand.getAppName.name,
          'Get app names for the targeted platforms',
        );

  @override
  String get description => 'Get app names for the targeted platforms';

  @override
  String get name => RenameCommand.getAppName.name;

  @override
  FutureOr? run() {
    final targets = argResults?[RenameOption.targets.name];
    if (targets == null || targets.isEmpty) {
      print('No targets specified.');
      return null;
    }

    print('Targets: $targets');
    final rename = Rename.fromPlatformNames(
      platformNames: targets,
    );
    return rename.applyWithCommandName(
      commandName: name,
    );
  }
}

/// [GetBundleIdCommand] is a class that extends the [PlatformFileEditorCommand] class.
/// It is responsible for getting the bundleId identifiers for the targeted platforms.
class GetBundleIdCommand extends PlatformFileEditorCommand {
  /// Constructor for [GetBundleIdCommand].
  /// It initializes the command with its name and description.
  GetBundleIdCommand()
      : super(
          RenameCommand.getBundleId.name,
          'Get bundleId identifiers for the targeted platforms',
        );

  @override
  String get description =>
      'Get bundleId identifiers for the targeted platforms';

  @override
  String get name => RenameCommand.getBundleId.name;

  @override
  FutureOr? run() {
    final targets = argResults?[RenameOption.targets.name];
    if (targets == null || targets.isEmpty) {
      print('No targets specified.');
      return null;
    }

    print('Targets: $targets');
    final rename = Rename.fromPlatformNames(
      platformNames: targets,
    );
    return rename.applyWithCommandName(
      commandName: name,
    );
  }
}
