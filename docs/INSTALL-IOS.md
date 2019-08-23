# iOS Setup with Cocoapods

You will have to install the plugin by manually downloading [a Release](https://github.com/transistorsoft/background-geolocation-lt/releases) from this repository.  The plugin is not currently submitted to a package manager (eg: jCenter)

### `Podfile`

Add the following `pod` to your `Podfile`, providing the path to where you installed the `background-geolocation-firebase` SDK:

```ruby
pod 'BackgroundGeolocationFirebase', :path => '../Libraries/background-geolocation-firebase/ios/BackgroundGeolocationFirebase.podspec'
```

```bash
$ pod install
```

### :open_file_folder: **`AppDelegate.m`**

```diff
#import "AppDelegate.h"
.
.
.
+#import <Firebase/Firebase.h>

@implementation AppDelegate

 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  .
  .
  .
+ [FIRApp configure];
  return YES;
}

```

### **`Google-Services-Info.plist`**

From your **Firebase Console**, copy your downloaded `Google-Services-Info.plist` file into your application:

![](https://dl.dropboxusercontent.com/s/4s7kfa6quusqk7i/Google-Services.plist.png?dl=1)

### :x: **`Issues?`**

```shell
Undefined symbols for architecture armv7: “_OBJC_CLASS_$_FIRApp”
```
During pod installation, you may see warnings related to `OTHER_LDFLAGS` or other flags. To fix the issue, select the target of your project and add `$(inherited)` flag in `Build Settings`. You can reference this [Stack Overflow issue](https://stackoverflow.com/questions/37344676/undefined-symbols-for-architecture-armv7-objc-class-firapp) for more details.