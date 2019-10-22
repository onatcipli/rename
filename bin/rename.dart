import 'package:args/args.dart';
import 'package:rename/rename.dart' as rename;

main(List<String> arguments) async {
  final argParser = ArgParser();

  argParser.addOption(
    "appname",
    abbr: "a",
  );
  argParser.addOption(
    "bundleId",
    abbr: "b",
  );

  ArgResults results = argParser.parse(arguments);

  try {
    if (results.arguments.contains("--appname") &&
        (results['appname'] != null)) {
      await rename.changeAppName(results['appname']);
      print("App name changed succesfully to : ${results['appname']}");
    } else if (results.arguments.contains("--bundleId") &&
        (results['bundleId'] != null)) {
      await rename.changeBundleId(results['bundleId']);
      print("App name changed succesfully to : ${results['appname']}");
    } else {
      print("Command couldn't finded");

      print("try to run : ``rename --appname yourappname``");
      print("try to run : ``rename --bundleId your.bundle.id``");
      print("or :         ``pub global run rename --appname yourappname``");
      print("or :         ``pub global run rename --bundleId your.bundle.id``");
      print("******************");
    }
  } catch (e) {
    print(e);
  }
}
