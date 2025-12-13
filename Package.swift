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
            name: "MissedSwiftSQLite",
            linkerSettings: [
                .linkedLibrary("sqlite3")
            ]
        ),
        .testTarget(
            name: "LSQLiteTests",
            dependencies: ["LSQLite"]
        ),
    ]
)
