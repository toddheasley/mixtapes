// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Mixtapes",
    platforms: [
        .macOS(.v10_14)
    ],
    products: [
        .executable(name: "mixtapes-cli", targets: [
            "MixtapesCLI"
        ]),
        .library(name: "Mixtapes", targets: [
            "Mixtapes"
        ])
    ],
    targets: [
        .target(name: "Mixtapes"),
        .target(name: "MixtapesCLI", dependencies: [
            "Mixtapes"
        ]),
        .testTarget(name: "MixtapesTests", dependencies: [
            "Mixtapes"
        ])
    ]
)
