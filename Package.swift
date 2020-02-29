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
        .executable(name: "mixtapes", targets: [
            "MixtapesCLI"
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
