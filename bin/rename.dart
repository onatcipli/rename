import 'package:args/args.dart';
import 'package:rename/rename.dart' as rename;

const android = 'android';
const macOS = 'macOS';
const ios = 'ios';
const linux = 'linux';
const web = 'web';

const target = 'target';
const appname = 'appname';
const bundleId = 'bundleId';
const launcherIcon = 'launcherIcon';
const help = 'help';

final argParser = ArgParser()
  ..addMultiOption(target,
      abbr: 't',
      allowed: [android, macOS, ios, linux, web],
      help: 'Set which platforms to target.')
  ..addOption(appname, abbr: 'a', help: 'Sets the name of the app.')
  ..addOption(bundleId, abbr: 'b', help: 'Sets the bundle id.')
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
      if (targets.contains(linux)) rename.Platform.linux,
      if (targets.contains(web)) rename.Platform.web,
    };

    if (results[appname] != null) {
      await rename.changeAppName(results[appname], platforms);
    }
    if (results[bundleId] != null) {
      await rename.changeBundleId(results[bundleId], platforms);
    }
  } on FormatException catch (e) {
    print(e.message);
    print('');
    print(argParser.usage);
  }
}
