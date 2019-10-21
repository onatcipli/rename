import 'package:args/args.dart';

import 'package:rename/rename.dart' as rename;

main(List<String> arguments) {
  final argParser = ArgParser();

  argParser.addCommand("appname");

  ArgResults results = argParser.parse(arguments);

  if (results.command.name == "appname" &&
      (results.command['appname'] != null ||
          (results.command['appname'] as String).isNotEmpty)) {
    try {
      rename.changeAppName(results.command['appname']);
      print("App name changed succesfully to : ${results.command['appname']}");
    } catch (e) {
      //TODO: Add filepath exception later.
      print(e);
    }
  } else {
    print("Command couldn't finded");
  }
}
