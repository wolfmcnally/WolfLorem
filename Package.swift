// swift-tools-version:6.0

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
