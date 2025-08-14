// android/settings.gradle.kts

pluginManagement {
    // Read Flutter SDK path from local.properties
    val flutterSdkPath: String = run {
        val props = java.util.Properties()
        file("local.properties").inputStream().use { props.load(it) }
        val path = props.getProperty("flutter.sdk")
        require(path != null) { "flutter.sdk not set in local.properties" }
        path
    }

    // Include Flutter's Gradle build logic
    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    // Plugin repositories
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

// IMPORTANT: `plugins {}` must come AFTER pluginManagement {}
plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0" // must be applied in settings

    // Define versions here so module/build scripts can apply without versions
    id("com.android.application") version "8.7.3" apply false
    id("org.jetbrains.kotlin.android") version "2.1.0" apply false

    // If you use these, uncomment and set versions here (not in build.gradle):
    // id("com.google.gms.google-services") version "4.4.2" apply false
    // id("com.google.firebase.crashlytics") version "2.9.9" apply false
}

include(":app")
