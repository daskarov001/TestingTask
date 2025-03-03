// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Networking",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "Networking",
            targets: ["Networking"]),
    ],
    dependencies: [
        .package(path: "~/Module")
    ],
    targets: [
        .target(
            name: "Networking",
            dependencies: ["Module"]
        ),
    ]
)
