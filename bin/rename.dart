import 'package:args/args.dart';
import 'package:rename/rename.dart' as rename;

const android = 'android';
const macOS = 'macOS';
const ios = 'ios';

const target = 'target';
const appname = 'appname';
const pubspec = 'pubspec';
const bundleId = 'bundleId';
const launcherIcon = 'launcherIcon';
const help = 'help';

final argParser = ArgParser()
  ..addMultiOption(target,
      abbr: 't',
      allowed: [android, macOS, ios],
      help: 'Set which platforms to target.')
  ..addOption(appname, abbr: 'a', help: 'Sets the name of the app.')
  ..addOption(pubspec, abbr: 'p', help: 'Sets the Pubspec name')
  ..addOption(bundleId, abbr: 'b', help: 'Sets the bundle id.')
  ..addOption(launcherIcon, abbr: 'l', help: 'Sets the launcher icon.')
  ..addFlag(help, abbr: 'h', help: 'Shows help.', negatable: false);

void main(List<String> arguments) async {
  try {
    final results = argParser.parse(arguments);
    if (results[help] || results.arguments.isEmpty) {
      print(argParser.usage);
      return;
    }

    final targets = results['target'];
    final platforms = <rename.Platform>{
      if (targets.contains(macOS)) rename.Platform.macOS,
      if (targets.contains(android)) rename.Platform.android,
      if (targets.contains(ios)) rename.Platform.ios,
    };

    if (results[appname] != null) {
      await rename.changeAppName(
          appName: results[appname], platforms: platforms);
    }
    if (results[pubspec] != null) {
      await rename.changePubspecName(results[pubspec], platforms);
    }
    if (results[bundleId] != null) {
      await rename.changeBundleId(results[bundleId], platforms);
    }
    if (results[launcherIcon] != null) {
      await rename.changeLauncherIcon(results[launcherIcon]);
    }
  } on FormatException catch (e) {
    print(e.message);
    print('');
    print(argParser.usage);
  }
}
