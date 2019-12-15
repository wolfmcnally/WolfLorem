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
            type: .dynamic,
            targets: ["WolfLorem"]),
        ],
    dependencies: [
        .package(url: "https://github.com/wolfmcnally/WolfNumerics", from: "4.0.0"),
    ],
    targets: [
        .target(
            name: "WolfLorem",
            dependencies: ["WolfNumerics"])
        ]
)
