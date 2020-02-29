// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "Mixtapes",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "MixtapesKit", targets: [
            "MixtapesKit"
        ]),
        .executable(name: "mixtapes", targets: [
            "MixtapesCLI"
        ])
    ],
    targets: [
        .target(name: "MixtapesKit"),
        .target(name: "MixtapesCLI", dependencies: [
            "MixtapesKit"
        ]),
        .testTarget(name: "MixtapesTests", dependencies: [
            "MixtapesKit"
        ])
    ]
)
