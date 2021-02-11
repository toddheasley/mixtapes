// swift-tools-version:5.3

import PackageDescription

let package = Package(name: "mixtapes", platforms: [
        .macOS(.v11),
        .iOS(.v14)
    ], products: [
        .executable(name: "mixtapes-cli", targets: [
            "MixtapesCLI"
        ]),
        .library(name: "Mixtapes", targets: [
            "Mixtapes"
        ])
    ], dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.0")
    ], targets: [
        .target(name: "MixtapesCLI", dependencies: [
            .product(name: "ArgumentParser", package: "swift-argument-parser"),
            "Mixtapes"
        ]),
        .target(name: "Mixtapes"),
        .testTarget(name: "MixtapesTests", dependencies: [
            "Mixtapes"
        ])
    ]
)
