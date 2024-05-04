// swift-tools-version:5.10

import PackageDescription

let package = Package(name: "Mixtapes", platforms: [
        .macOS(.v14)
    ], products: [
        .library(name: "Mixtapes", targets: [
            "Mixtapes"
        ])
    ], targets: [
        .target(name: "Mixtapes", resources: [
            .process("Resources")
        ]),
        .testTarget(name: "MixtapesTests", dependencies: [
            "Mixtapes"
        ], resources: [
            .process("Resources")
        ])
    ])
