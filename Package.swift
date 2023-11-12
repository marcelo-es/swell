// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "swell",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "Swell",
            targets: ["Swell"]
        )
    ],
    targets: [
        .target(
            name: "Swell"
        ),
        .testTarget(
            name: "SwellTests",
            dependencies: ["Swell"]
        ),
    ]
)
