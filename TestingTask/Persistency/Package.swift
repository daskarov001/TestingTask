// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Persistency",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "Persistency",
            targets: ["Persistency"]),
    ],
    dependencies: [
        .package(path: "~/Module")
    ],
    targets: [
        .target(
            name: "Persistency",
            dependencies: ["Module"]
        ),
    ]
)
