import 'package:rename/rename.dart' as rename;

main(List<String> arguments) {
  if (arguments.first.toLowerCase() == "changeappname" &&
      (arguments.last != null || arguments.last != "")) {
    rename.changeAppName(arguments.last);
  }
}
