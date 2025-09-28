// swift-tools-version:6.2

import PackageDescription

let package = Package(name: "Mixtapes", platforms: [
        .macOS(.v15)
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
