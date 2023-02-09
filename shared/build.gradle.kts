import org.apache.tools.ant.taskdefs.condition.Os

plugins {
    id("com.android.library")
    id("com.squareup.sqldelight") version "1.5.4"
    id("com.chromaticnoise.multiplatform-swiftpackage") version "2.0.3"
    kotlin("multiplatform")
    kotlin("plugin.serialization") version "1.7.20"
}

version = "0.0.1"

kotlin {
    android()
    
    listOf(
        iosX64(),
        iosArm64(),
        iosSimulatorArm64()
    ).forEach {
        it.binaries.framework {
            baseName = "shared"
        }
    }

    multiplatformSwiftPackage {
        packageName("Kurrency")
        swiftToolsVersion("5.3")
        outputDirectory(File(rootDir, "/"))
        targetPlatforms {
            iOS { v("13") }
        }
    }

    sourceSets {
        val ktorVersion = "2.2.2"
        val sqlDelightVersion = "1.5.4"
        val commonMain by getting {
            dependencies {
                // Sqldelight
                implementation("com.squareup.sqldelight:runtime:$sqlDelightVersion")

                // ktor
                implementation("io.ktor:ktor-client-content-negotiation:$ktorVersion")
                implementation("io.ktor:ktor-serialization-kotlinx-json:$ktorVersion")
                implementation("io.ktor:ktor-client-core:$ktorVersion")
                implementation("io.ktor:ktor-client-logging:$ktorVersion")

                implementation("io.github.aakira:napier:2.4.0")
                api("io.insert-koin:koin-core:3.2.0")
            }
        }
        val commonTest by getting {
            dependencies {
                implementation(kotlin("test"))
            }
        }
        val androidMain by getting {
            dependencies {
                implementation("com.squareup.sqldelight:android-driver:$sqlDelightVersion")
                implementation("io.ktor:ktor-client-android:2.2.2")
            }
        }
        val androidTest by getting
        val iosX64Main by getting
        val iosArm64Main by getting
        val iosSimulatorArm64Main by getting
        val iosMain by creating {
            dependsOn(commonMain)
            iosX64Main.dependsOn(this)
            iosArm64Main.dependsOn(this)
            iosSimulatorArm64Main.dependsOn(this)
            dependencies {
                implementation("com.squareup.sqldelight:native-driver:$sqlDelightVersion")
                implementation("io.ktor:ktor-client-ios:2.2.2")
            }
        }
        val iosX64Test by getting
        val iosArm64Test by getting
        val iosSimulatorArm64Test by getting
        val iosTest by creating {
            dependsOn(commonTest)
            iosX64Test.dependsOn(this)
            iosArm64Test.dependsOn(this)
            iosSimulatorArm64Test.dependsOn(this)
        }
    }
}

android {
    namespace = "com.kurrency"
    compileSdk = 33
    defaultConfig {
        minSdk = 23
        targetSdk = 33
    }
}

sqldelight {
    database("AppDatabase") {
        packageName = "com.kurrency.data.local.database"
    }
}

task("installGitHook", type = Copy::class) {
    var suffix = "macos"
    if (Os.isFamily(Os.FAMILY_WINDOWS)) {
        suffix = "windows"
    }
    from(File(rootProject.rootDir, "pre-push"))
    into(File(rootProject.rootDir, ".git/hooks"))
    fileMode = 775
//    from(file(rootProject.rootDir.path + "/scripts/pre-commit-$suffix"))
//    into(file(".git/hooks"))
//    rename("pre-commit-$suffix", "pre-commit")
//    fileMode = 775
}

tasks.register("verifyLibraryVersion") {
    doLast {
        val libraryVersion = properties["library.version"]
        val iosPackage = "Kurrency-$libraryVersion.zip"
        if (File(rootProject.rootDir, iosPackage).isFile.not()) {
            throw IllegalStateException("$iosPackage not found. Please, generate new swift package.")
        }
        println("$iosPackage package has the updated version")
    }
}
