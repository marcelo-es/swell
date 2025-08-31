// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "swell",
    platforms: [
        .macOS(.v15)
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
