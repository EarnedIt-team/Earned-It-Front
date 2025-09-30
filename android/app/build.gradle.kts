import java.util.Properties
import java.io.File
import java.io.FileInputStream
import java.io.FileNotFoundException

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Properties 객체 생성
val dotenv = Properties()

// .env 파일 경로 설정
val envFile = file("${rootProject.projectDir}/../assets/.env")

// .env 파일이 존재하면 로드
if (envFile.exists()) {
    FileInputStream(envFile).use { dotenv.load(it) }
} else {
    throw FileNotFoundException("Could not find .env file at: ${envFile.path}")
}

android {
    namespace = "com.example.earned_it"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.earned_it"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // .env에서 KAKAO_API_KEY 가져오기
        val kakaoKey = dotenv.getProperty("KAKAO_API_KEY")
        if (kakaoKey.isNullOrBlank()) {
            throw FileNotFoundException("KAKAO_NATIVE_APP_KEY not found in .env file")
        }

        manifestPlaceholders["YOUR_NATIVE_APP_KEY"] = kakaoKey
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
