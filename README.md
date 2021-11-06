## About (Null-Safety)

It helps you to change your flutter project's AppName and BundleId for different platforms, **currently only available
for IOS, Android, macOS and Web**

## Supported Platforms

You can change the bundleId and appName in following folders

- IOS
- Android
- MacOS
- Linux
- Web

## Installation

```
pub global activate rename
```

## Default Usage

if you dont pass **-t or --target** parameter it will try to rename all available platform project folders inside
flutter project.

_**Run this command inside your flutter project root.**_

        pub global run rename --bundleId com.onatcipli.networkUpp
        pub global run rename --appname "Network Upp"

## Custom Usage

if you want to run commands directly (without using `pub global run`)
ensure
you [add system cache bin directory to your path](https://dart.dev/tools/pub/cmd/pub-global#running-a-script-from-your-path)

        rename --appname yourappname -t ios

or

        pub global run rename --appname yourappname --target macOS

To target a specific platform use the "--target" option. e.g.

        pub global run rename --bundleId com.example.android.app --target android

## Parameters

        -t, --target          Set which platforms to target.
                              [android, ios, macOS, linux]
        
        -a, --appname         Sets the name of the app.
        -b, --bundleId        Sets the bundle id.
        -l, --launcherIcon    Sets the launcher icon. (deprecated currently)
        -h, --help            Shows help.

## Next Coming

* Getting the current app names and bundleIds
* Changing launcherIcon fix
* Null safety
