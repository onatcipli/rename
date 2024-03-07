# Rename CLI Tool v3

![GitHub issues](https://img.shields.io/github/issues/onatcipli/rename)
![GitHub pull requests](https://img.shields.io/github/issues-pr/onatcipli/rename)
![GitHub contributors](https://img.shields.io/github/contributors/onatcipli/rename)
![GitHub](https://img.shields.io/github/license/onatcipli/rename)


## Warning

- This package may not be compatible with a flavor setup.
- The API has undergone significant changes; many elements have been deprecated. Please refer to the usage section for the updated functionalities.

## About

The Rename CLI Tool is a utility designed to modify your Flutter project's AppName and BundleId across various platforms. The supported platforms include:

- IOS
- Android
- MacOS
- Linux
- Web (only app name related functionality)
- Windows

## Installation

To install the Rename CLI Tool, execute the following command:

```sh
flutter pub global activate rename
```

### Running a Script

You can [run a script directly](https://dart.dev/tools/pub/cmd/pub-global#running-a-script-from-your-path) using `rename` from the activated package through the command line. If facing any issues, alternate commands are `dart pub global run rename` or `flutter pub global run rename`. For path variable issues, refer to [ensuring your path variables are set up correctly](https://dart.dev/tools/pub/glossary#system-cache).

## Usage

Please ensure you are in the Flutter project root directory before executing any commands. The tool supports various commands for retrieving and setting the AppName and BundleId:

### Help

Display general help or command-specific help using:

```sh
rename help
```

```plaintext
A CLI tool that helps for renaming in Flutter projects.

Usage: rename <command> [arguments]

Global options:
-h, --help       Print this usage information.
-v, --version    

Available commands:
  getAppName    Get app names for the targeted platforms
  getBundleId   Get bundleId identifiers for the targeted platforms
  setAppName    Set app name for the targeted platforms
  setBundleId   Set bundleId identifier for the targeted platforms

Run "rename help <command>" for more information about a command.
```

or for a specific command:

```sh
rename help <commandName>
```

```plaintext
Example output for 'rename help setAppName':
Set app name for the targeted platforms

Usage: rename setAppName [arguments]
-h, --help                 Print this usage information.
-t, --targets              Set which platforms to target.
                           [ios (default), android (default), macos, linux, web, windows]
-v, --value (mandatory)    Set value of the given command

Run "rename help" to see global options.
```

### Get AppName

To retrieve the current AppName for a specific platform:

```sh
rename getAppName --targets ios
```

```plaintext
This will output the current AppName for the iOS platform.
```

or for multiple targets:

```sh
rename getAppName --targets ios,android,macos,windows,linux
```

### Set AppName

To set the AppName for specific platforms:

```sh
rename setAppName --targets ios,android --value "YourAppName"
```

```plaintext
This will set the AppName for the iOS and Android platforms to "YourAppName".
```

### Get/Set BundleId

Similarly, use `getBundleId` and `setBundleId` to retrieve or set the BundleId for the specified platforms.

```sh
rename getBundleId --targets android
```

```plaintext
This will output the current BundleId for the Android platform.
```

```sh
rename setBundleId --targets android --value "com.example.bundleId"
```

```plaintext
This will set the BundleId for the Android platform to "com.example.bundleId".
```

## Parameters

### Commands

- `setAppName`: Change the App Name for the given `--targets`. The `--value` option is required.
- `setBundleId`: Change the bundle identifiers for the given `--targets`. The `--value` option is required.
- `getAppName`: Display the app names for the given `--targets`.
- `getBundleId`: Display the bundle identifiers for the given `--targets`.

### Options

- `-t, --targets`: Specify the target platforms. Options include `android`, `ios`, `web`, `windows`, `macos`, `linux`. This parameter is mandatory for all commands.
- `-v, --value`: Set the value for the specified command. Mandatory for `setAppName` and `setBundleId`.
- `-h, --help`: Display available instructions for the related command.

## Upcoming Features

- A Desktop application for easier usage.
- Integration with the [interact package](https://pub.dev/packages/interact) and [pub_updater package](https://pub.dev/packages/pub_updater).
- Enabling default platforms for the current Flutter project.

## License

This project is licensed under the MIT License. Refer to the LICENSE file for details.

## Contributing

Contributions are welcome! Please refer to our contributing guidelines to get started.

## Changelog

For all notable changes to this project, refer to the CHANGELOG.

## Support

For any issues or suggestions, please open an issue. Your feedback is highly appreciated.

## Author

This project is created and maintained by [Onat Çipli](https://github.com/onatcipli).


## Troubleshooting

#### Command Not Working on Windows

If you encounter issues running the `rename` command directly in Windows, especially from a non-administrator terminal, you might need to use an alternative command format. This issue can arise due to permission restrictions or path variable misconfigurations.

Try executing the command using one of the following formats:

- Using Flutter:
  ```sh
  flutter pub run rename <command> [arguments]
  ```
- Using Dart:
  ```sh
  dart run rename <command> [arguments]
  ```

These alternative commands explicitly invoke the `rename` tool through the Dart or Flutter toolchain, which can bypass some of the path or permission issues encountered in certain Windows configurations.
