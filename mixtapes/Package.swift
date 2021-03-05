// swift-tools-version:5.3

import PackageDescription

let package = Package(name: "mixtapes", platforms: [
        .macOS(.v11)
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
    ]
)
