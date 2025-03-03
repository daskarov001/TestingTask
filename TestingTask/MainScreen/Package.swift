// swift-tools-version: 5.7

// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MainScreen",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MainScreen",
            targets: ["MainScreen"]),
    ],
    dependencies: [
        .package(path: "~/Module"),
        .package(path: "~/Networking"),
        .package(path: "~/Persistency")
    ],
    targets: [
        .target(
            name: "MainScreen",
            dependencies: ["Module", "Networking", "Persistency"]
        ),
    ]
)
