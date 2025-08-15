// android/app/build.gradle.kts

plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
}

import java.util.Properties

// Correctly loads the .env file from the project's root directory
val envProperties = Properties().apply {
    val envFile = rootProject.file("../.env") // Navigates up from /android to the root
    if (envFile.exists()) {
        envFile.inputStream().use { load(it) }
    }
}

android {
    namespace = "com.example.favorite_places"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973" // Or your specific NDK version

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    // This can remain, it's harmless and might be used by other plugins.
    buildFeatures {
        buildConfig = true
    }

    defaultConfig {
        applicationId = "com.example.favorite_places"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // This is the only part needed. It securely provides the key
        // as a placeholder for the AndroidManifest.xml.
        manifestPlaceholders["MAPS_API_KEY"] = envProperties.getProperty("MAPS_API_KEY", "")
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Your dependencies
}