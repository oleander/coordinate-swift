# Coordinate

[![Build Status](https://travis-ci.org/oleander/coordinate-swift.svg?branch=master)](https://travis-ci.org/oleander/coordinate-swift)

A Swift library for handling coordinates.

## Example

``` swift
let origin = Coordinate(
  long: 100.561371,
  lat: 13.822495
)

let target = Coordinate(
  long: 100.613660,
  lat: 13.749423
)

origin.distance(to: target) // 10.0km
```

## Install

``` swift
// swift-tools-version: 4.2
import PackageDescription

let package = Package(
  name: "YOUR_PROJECT_NAME",
  dependencies: [
    .package(
      url: "https://github.com/oleander/coordinate-swift.git", .branch("master")
    )
  ]
)
```
