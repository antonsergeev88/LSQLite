// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "LSQLite",
    products: [
        .library(
            name: "LSQLite",
            targets: ["LSQLite"]
        ),
        .library(
            name: "LSQLiteExtensions",
            targets: ["LSQLiteExtensions"]
        )
    ],
    targets: [
        .target(
            name: "LSQLite",
            dependencies: ["MissedSwiftSQLite"]
        ),
        .target(
            name: "LSQLiteExtensions",
            dependencies: ["LSQLite"]
        ),
        .target(
            name: "MissedSwiftSQLite"
        ),
        .testTarget(
            name: "LSQLiteTests",
            dependencies: ["LSQLite", "MissedSwiftSQLite"]
        ),
        .testTarget(
            name: "LSQLiteExtensionsTests",
            dependencies: ["LSQLiteExtensions"]
        ),
    ]
)
