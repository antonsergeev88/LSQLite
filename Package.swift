// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "LSQLite",
    products: [
        .library(
            name: "LSQLite",
            targets: ["LSQLite"]
        )
    ],
    targets: [
        .target(
            name: "LSQLite",
            dependencies: ["MissedSwiftSQLite"]
        ),
        .target(
            name: "MissedSwiftSQLite"
        ),
        .testTarget(
            name: "LSQLiteTests",
            dependencies: ["LSQLite", "MissedSwiftSQLite"]
        ),
    ]
)
