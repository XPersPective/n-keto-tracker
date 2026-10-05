import java.util.Properties

// İmza anahtarı bu (açık kaynak) repoda DEĞİL, yayın kökünde durur:
// D:\AppPublishingpps
-keto-tracker\credentialsndroid (protokol:
// D:\AppPublishing\README.md). `fastlane build_release` NKETO_SIGNING'i o
// key.properties'e yöneltir; içindeki storeFile ona göredir. Tanımlı değilse
// release debug imzasıyla derlenir — Play bunu reddeder, yani yanlışlıkla
// yayınlanamaz (C-030).
val keystorePropertiesFile = System.getenv("NKETO_SIGNING")?.let { file(it) }
val keyProps = Properties().apply {
    if (keystorePropertiesFile?.exists() == true) {
        keystorePropertiesFile.inputStream().use { load(it) }
    }
}

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.crazypenguin.nketotracker"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.crazypenguin.nketotracker"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        // Uses the version code from pubspec.yaml. When using split APKs, 1000 * ABI_VERSION
        // is added automatically by Flutter. (https://developer.android.com/studio/build/configure-apk-splits#configure-APK-versions)
        // You can force using the value of versionCode by specifying the `-P force-version-code-ignoring-abi=true`
        // flag during build.
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        // Gerçek AdMob uygulama kimliği release'te yayın kökünden (app-ids.env)
        // gelir; yoksa Google'ın herkese açık test kimliği.
        manifestPlaceholders["admobAppId"] =
            System.getenv("ADMOB_APP_ID_ANDROID") ?: "ca-app-pub-3940256099942544~3347511713"
    }

    signingConfigs {
        if (keyProps.getProperty("storeFile") != null) {
            create("upload") {
                storeFile = keystorePropertiesFile!!.parentFile.resolve(keyProps.getProperty("storeFile"))
                storePassword = keyProps.getProperty("storePassword")
                keyAlias = keyProps.getProperty("keyAlias")
                keyPassword = keyProps.getProperty("keyPassword")
            }
        }
    }

    buildTypes {
        release {
            // C-030: imza anahtarı repoda değil; key.properties yoksa debug imzası
            // (yalnız yerel deneme — Play'e yüklenemez).
            signingConfig = signingConfigs.findByName("upload") ?: signingConfigs.getByName("debug")
            // ORTAK_UYGULAMA_STANDARDI.md §1.4: R8 küçültme + keep kuralları.
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro",
            )
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
