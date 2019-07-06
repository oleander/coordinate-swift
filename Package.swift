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
      .package(url: "git@github.com:oleander/distance-swift.git", .branch("master")),

      .package(url: "https://github.com/Quick/Nimble.git", from: "8.0.2"),
      .package(url: "https://github.com/Quick/Quick.git", from: "2.1.0")
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
