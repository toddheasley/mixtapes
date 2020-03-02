// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "Mixtapes",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "Mixtapes", targets: [
            "Mixtapes"
        ]),
        .executable(name: "mixtapes-cli", targets: [
            "MixtapesCLI"
        ])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.0.1")
    ],
    targets: [
        .target(name: "Mixtapes"),
        .target(name: "MixtapesCLI", dependencies: [
            .product(name: "ArgumentParser", package: "swift-argument-parser"),
            "Mixtapes"
        ]),
        .testTarget(name: "MixtapesTests", dependencies: [
            "Mixtapes"
        ])
    ]
)
