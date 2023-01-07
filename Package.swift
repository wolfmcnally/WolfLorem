// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "WolfLorem",
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
