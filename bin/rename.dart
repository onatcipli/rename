import 'package:args/args.dart';

import 'package:rename/rename.dart' as rename;

main(List<String> arguments) {
  final argParser = ArgParser();

  argParser.addOption(
    "appname",
    abbr: "a",
  );

  ArgResults results = argParser.parse(arguments);

  if (results.arguments.contains("--appname") && (results['appname'] != null)) {
    try {
      rename.changeAppName(results.command['appname']);
      print("App name changed succesfully to : ${results.command['appname']}");
    } catch (e) {
      //TODO: Add filepath exception later.
      print(e);
    }
  } else {
    print("Command couldn't finded");

    print("try to run : ``rename --appname yourappname``");
    print("or :         ``pub global run rename --appname yourappname``");
    print("******************");
  }
}
