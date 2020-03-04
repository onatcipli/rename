## Usage

In your console navigate to flutter project root type following to change your application name : 

````
rename --appname yourappname

or

pub global run rename --appname yourappname

To target a specific platform use the "--target" option. e.g.

pub global run rename --bundleId com.example.android.app --target android

-----------------------------------------------

-t, --target          Set which platforms to target.
                      [android, macOS, ios]

-a, --appname         Sets the name of the app.
-b, --bundleId        Sets the bundle id.
-l, --launcherIcon    Sets the launcher icon.
-h, --help            Shows help.
````


A sample command-line application.

Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).
