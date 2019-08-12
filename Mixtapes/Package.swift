// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Mixtapes",
    platforms: [
        .macOS(.v10_14)
    ],
    products: [
        .library(name: "Mixtapes", targets: [
            "Mixtapes"
        ])
    ],
    targets: [
        .target(name: "Mixtapes", dependencies: []),
        .testTarget(name: "MixtapesTests", dependencies: [
            "Mixtapes"
        ])
    ]
)
