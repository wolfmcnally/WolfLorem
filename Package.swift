// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "WolfLorem",
    platforms: [
        .iOS(.v9), .macOS(.v10_13), .tvOS(.v11)
    ],
    products: [
        .library(
            name: "WolfLorem",
            targets: ["WolfLorem"]),
        ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "WolfLorem"
          )
        ]
)
