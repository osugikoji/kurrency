// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Kurrency",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "Kurrency",
            targets: ["Kurrency"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "Kurrency",
            path: "./Kurrency.xcframework"
        ),
    ]
)
