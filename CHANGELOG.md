All notable changes to the "Rename CLI Tool" project will be documented in this file.

# 3.1.0
- Added support for the new `build.gradle.kts` *Kotlin DSL* format alongside the existing `build.gradle` *Groovy* configuration. The project now supports **both** formats, maintaining full backward compatibility with legacy build scripts.

# 3.0.2
- Troubleshooting updated in readme

# 3.0.1
- Windows app rename fix typo and more stable renaming logic

# 3.0.0

### Added
- Introduced `RenameCommandRunner` class which is responsible for running the rename command in the CLI tool, including several commands such as `SetAppNameCommand`, `SetBundleIdCommand`, `GetAppNameCommand`, and `GetBundleIdCommand`.
- Support for Linux platform.
- New command structure with `getAppName`, `getBundleId`, `setAppName`, and `setBundleId`.
- `--targets` option to specify which platforms to target.
- `--value` option for setting the value in `setAppName` and `setBundleId`.
- Detailed `help` command for global options and individual commands.
- Added warning section noting potential compatibility issues and changes in API.
- Included detailed explanations and examples for each command in the Usage section.
- Added section on Upcoming Features, detailing plans for a Desktop application, integration with other packages, and enabling default platforms for the current Flutter project.
- Contributing section, License section, Author section, and Support section.
- Links to the author's GitHub profile, interact package, and pub_updater package.

### Changed
- Significant updates to the `Rename` class to handle the rename command for all platform file editors, including a switch case to handle different commands such as `setAppName`, `getAppName`, `setBundleId`, and `getBundleId`.
- Improved clarity and professionalism in the language used throughout the documentation.
- Updated installation and usage instructions for better clarity and detail.
- Updated About section with more detail.
- Updated Supported Platforms section with additional platforms and clarifications.
- Clearer instructions for custom usage.

### Removed
- Deprecated the `--launcherIcon` option and removed it from the Parameters section.

### Other Changes
- Updated the `pubspec.yaml` file to include new dependencies.
- `AbstractPlatformFileEditor` class providing a blueprint for platform-specific file editors.
- Minor updates to the `README.md` file for new instructions and usage examples.

## 2.1.1

- readme fix

## 2.1.0

- Remaining PR merges
- fixed generic issues
- Windows support added by TonyHoyle

## 2.0.1

- Making null-safety version as default
- releasing pre-release

## 2.0.0-dev.2

- Readme info updates

## 2.0.0-dev.1

- Upgraded to null-safety
- launcherIcon removed
- get package name methods added
- Web support added (only title change)


## 1.3.1

- (issue #18) raise upper bound of dependencies

## 1.3.0

- linux support and some fixes
- launcherIcon deprecated

## 1.2.0

- (issue #4)fixing receiving FileSystemException for projects that does not have macOS folder.
- logger added to show users more friendly logs.
- README.md updated

## 1.1.9

- add macOS compat. add option to only target certain platforms by Alexander Wilde

## 1.1.8

- fix for AndroidManifest path

## 1.1.7

- update

## 1.1.6

- update

## 1.1.5

- changeLauncherIcon function added

## 1.1.4

- fix for ios BundleId

## 1.1.3

- fix

## 1.1.2

- renaming bundleId added

## 1.1.1

- Fix for Linux and macOS path 

## 1.1.0

- README.MD update 
- example 

## 1.0.9

- README.MD update 
- console prints improved

## 1.0.8

- typo fix

## 1.0.7

- fix for command (converted to option)

## 1.0.6

- add new command

## 1.0.5

- Add Arg package as a dependency

## 1.0.4

- ArgParser added
- `rename appname _yourappname_`

## 1.0.3

- update executables

## 1.0.2

- update executables

## 1.0.1

- License added

## 1.0.0

- Initial version, created by Stagehand
