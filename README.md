## About (Null-Safety)

It helps you to change your flutter project's AppName and BundleId for different platforms, **currently only available
for IOS, Android, macOS, Windows and Web**

## Supported Platforms

You can change the bundleId and appName in following folders

- IOS
- Android
- MacOS
- Linux
- Web
- Windows

## Installation

```
flutter pub global activate rename
```

## Default Usage

if you dont pass **-t or --target** parameter it will try to rename all available platform project folders inside
flutter project.

_**Run this command inside your flutter project root.**_

        flutter pub global run rename --bundleId com.onatcipli.networkUpp
        flutter pub global run rename --appname "Network Upp"



        flutter pub global run rename --appname YourAppName --target ios
        flutter pub global run rename --appname YourAppName --target android
        flutter pub global run rename --appname YourAppName --target web
        flutter pub global run rename --appname YourAppName --target macOS
        flutter pub global run rename --appname YourAppName --target windows

## Custom Usage

if you want to run commands directly (without using `pub global run`)
ensure
you [add system cache bin directory to your path](https://dart.dev/tools/pub/cmd/pub-global#running-a-script-from-your-path)

        rename --appname yourappname -t ios

or

        flutter pub global run rename --appname yourappname --target macOS

To target a specific platform use the "--target" option. e.g.

        flutter pub global run rename --bundleId com.example.android.app --target android

## Parameters

        -t, --target          Set which platforms to target.
                              [android, ios, web, windows, macOS, linux]
        
        -a, --appname         Sets the name of the app.
        -b, --bundleId        Sets the bundle id.
        -l, --launcherIcon    Sets the launcher icon. (deprecated currently)
        -h, --help            Shows help.

## Next Coming

* Getting the current app names and bundleIds
* UI to be able to easily use
* Changing launcherIcon fix
