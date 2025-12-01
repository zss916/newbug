plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.newbug.newbug"
    compileSdk = flutter.compileSdkVersion
   // ndkVersion =  "28.2.13676358"
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        //rckit
         //启用desugaring以支持较新的Java API
        isCoreLibraryDesugaringEnabled = true
        //sourceCompatibility = JavaVersion.VERSION_1_8
        //targetCompatibility = JavaVersion.VERSION_1_8
    }

    /*kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
        //rckit
        //jvmTarget = JavaVersion.VERSION_1_8.toString()
    }*/

    kotlin{
        compilerOptions {
            jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_11)
        }
    }


    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        //applicationId = "com.chillvibe.chillvibeapp"
        applicationId = "com.newbug.newbug"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }


}

flutter {
    source = "../.."
}

dependencies {
    implementation(fileTree(mapOf("include" to listOf("*.jar", "*.aar"), "dir" to "libs")))
     ///rclib
    implementation("cn.rongcloud.sdk:im_libcore:5.12.1")
    implementation("cn.rongcloud.sdk:im_chatroom:5.12.1")
    implementation("com.google.code.gson:gson:2.10.1")
    ///rckit
    // 添加desugaring支持库(flutter_local_notifications 需要)
    add("coreLibraryDesugaring", "com.android.tools:desugar_jdk_libs:2.1.4")
    // 添加窗口管理相关依赖
    //implementation("androidx.window:window:1.0.0")
    //implementation("androidx.window:window-java:1.0.0")
}
