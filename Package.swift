// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "Coordinate",
    products: [
      .library(
        name: "Coordinate",
        targets: ["Coordinate"]
      )
    ],
    dependencies: [
      .package(url: "https://github.com/oleander/distance-swift.git", .branch("master")),
      .package(url: "https://github.com/Quick/Nimble.git", from: "7.0.2"),
      .package(url: "https://github.com/Quick/Quick.git", from: "1.2.0")
    ],
    targets: [
      .target(
        name: "Coordinate",
        dependencies: [
          "Distance"
        ]
      ),
      .testTarget(
        name: "CoordinateTests",
        dependencies: [
          "Coordinate",
          "Nimble",
          "Distance",
          "Quick"
        ]
      )
    ]
)
