// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "swift-shell",
    products: [
        .library(
            name: "swift-shell",
            targets: ["SwiftShell"]
        ),
    ],
    targets: [
        .target(
            name: "SwiftShell"
        ),
        .testTarget(
            name: "SwiftShellTests",
            dependencies: ["SwiftShell"]
        ),
    ]
)
