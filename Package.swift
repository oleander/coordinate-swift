// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Coordinate",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Coordinate",
            targets: ["Coordinate"]),
    ],
    dependencies: [
        .package(url: "../Distance", .branch("master")),
        .package(url: "https://github.com/crossroadlabs/Regex.git", from: "1.1.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Coordinate",
            dependencies: [
            "Regex",
            "Distance"
          ]),
        .testTarget(
            name: "CoordinateTests",
            dependencies: ["Coordinate"]),
    ]
)
