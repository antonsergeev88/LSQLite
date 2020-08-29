// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "LSQLite",
    products: [
        .library(
            name: "LSQLite",
            targets: ["LSQLite"]
        ),
        .library(
            name: "MissedSwiftSQLite",
            targets: ["MissedSwiftSQLite"]
        ),
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
            dependencies: ["LSQLite"]
        ),
    ]
)
