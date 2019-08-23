# Android  Installation

You will have to install the plugin by manually downloading [a Release](https://github.com/transistorsoft/background-geolocation-firebase/releases) from this repository.  The plugin is not currently submitted to a package manager (eg: jCenter)

Create a folder in the root of your application project, eg: `/Libraries` and place the extracted **`background-geolocation-firebase`** folder into it:

eg: :open_file_folder: **`Libraries/background-geolocation-firebase`**

## Gradle Configuration

### :open_file_folder: **`settings.gradle`**

```diff
include ':background-geolocation'
project(':background-geolocation').projectDir = new File(rootProject.projectDir, './Libraries/background-geolocation-lt/android/background-geolocation')

+include ':background-geolocation-firebase'
+project(':background-geolocation-firebase').projectDir = new File(rootProject.projectDir, './Libraries/background-geolocation-firebase/android')

include ':app'

```

### :open_file_folder: **`android/build.gradle`**


```diff
buildscript {
    dependencies {
        classpath 'com.android.tools.build:gradle:3.1.4'
        // If you've already got firebase installed, the following line may already exist
+       classpath 'com.google.gms:google-services:4.3.0'  // Or latest
    }
    ext {
        buildToolsVersion = "28.0.3"
        minSdkVersion = 16
        compileSdkVersion = 28
        targetSdkVersion = 28

        googlePlayServicesLocationVersion = "17.0.0"
+       firebaseCoreVersion = "17.1.0"
+       firebaseFirestoreVersion = "21.0.0"
    }
}
```

### :open_file_folder: **`android/app/build.gradle`**

```diff

android {
+    compileSdkVersion rootProject.ext.compileSdkVersion
     defaultConfig {
+        targetSdkVersion rootProject.ext.targetSdkVersion
         .
         .
         .
     }
     .
     .
     .
}

dependencies {
    .
    .
    .
+   project(':background-geolocation-firebase')
}

// If you've already got firebase installed, the following line may already exist
+ apply plugin: 'com.google.gms.google-services'
```

### :open_file_folder: **`google-services.json`**

Download your `google-services.json` from the *Firebase Console*.  Copy the file to your `android/app` folder.

## AndroidManifest.xml

:open_file_folder: **`android/app/src/main/AndroidManifest.xml`**

```diff
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.transistorsoft.backgroundgeolocation.react">

  <application
    android:name=".MainApplication"
    android:allowBackup="true"
    android:label="@string/app_name"
    android:icon="@mipmap/ic_launcher"
    android:theme="@style/AppTheme">

    <!-- react-native-background-geolocation licence -->
+   <meta-data android:name="com.transistorsoft.firebaseproxy.license" android:value="YOUR_LICENCE_KEY_HERE" />
    .
    .
    .
  </application>
</manifest>

```

:information_source: [Purchase a License](http://www.transistorsoft.com/shop/products/background-geolocation-firebase)

