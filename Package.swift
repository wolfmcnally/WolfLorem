// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "WolfLorem",
    products: [
        .library(
            name: "WolfLorem",
            targets: ["WolfLorem"]),
        ],
    dependencies: [
        .package(url: "https://github.com/wolfmcnally/WolfNumerics", from: "3.0.1"),
    ],
    targets: [
        .target(
            name: "WolfLorem",
            dependencies: ["WolfNumerics"])
        ]
)
