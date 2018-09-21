import Foundation
import Regex
import Distance

// TODO: Move
extension String: LocalizedError {}

precedencegroup LonLatSubAdd {
  associativity: right
  higherThan: MultiplicationPrecedence
}

infix operator |-: LonLatSubAdd
infix operator |+: LonLatSubAdd
infix operator -+: LonLatSubAdd
infix operator --: LonLatSubAdd

public struct Coordinate: CustomStringConvertible, Equatable {
  private static let radiusEarth = 6371.0

  public let lon: Line
  public let lat: Line

  public init(fromString string: String) throws {
    let regex = "(\\d+\\.\\d+),\\s*(\\d+\\.\\d+)".r!

    guard let match = regex.findFirst(in: string) else {
      throw "Could not match \(string) as coordinates"
    }

    guard let latStr = match.group(at: 1) else {
      throw "Latitude not found in \(string)"
    }

    guard let lonStr = match.group(at: 2) else {
      throw "longitude not found in \(string)"
    }

    guard let lon = Double(lonStr) else {
      throw "Could not convert \(lonStr) to double"
    }

    guard let lat = Double(latStr) else {
      throw "Could not convert \(latStr) to double"
    }

    self.init(long: lon, lat: lat)
  }

  public init(long: Double, lat: Double) {
    lon = Line(long)
    self.lat = Line(lat)
  }

  public init(lon: Double, lat: Double) {
    self.lon = Line(lon)
    self.lat = Line(lat)
  }

  public init(lon: Line, lat: Line) {
    self.lon = lon
    self.lat = lat
  }

  public init(lat: Line, lon: Line) {
    self.lon = lon
    self.lat = lat
  }

  public var string: String {
    return String(describing: self)
  }

  public static func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
    return lhs.lon == rhs.lon && lhs.lat == rhs.lat
  }

  public static func |- (point: Coordinate, distance: Distance) -> Coordinate {
    return Coordinate(
      lat: point.lat,
      lon: point.lon - ((distance / .earthRadius) * (180.0 / .pi) / cos(point.lat.radian))
    )
  }

  public static func |+ (point: Coordinate, distance: Distance) -> Coordinate {
    return Coordinate(
      lat: point.lat,
      lon: point.lon + ((distance / .earthRadius) * (180.0 / .pi) / cos(point.lat.radian))
    )
  }

  public static func -- (point: Coordinate, distance: Distance) -> Coordinate {
    return Coordinate(
      lat: point.lat - ((distance / .earthRadius) * (180.0 / .pi)),
      lon: point.lon
    )
  }

  public static func -+ (point: Coordinate, distance: Distance) -> Coordinate {
    return Coordinate(
      lat: point.lat + ((distance / .earthRadius) * (180.0 / .pi)),
      lon: point.lon
    )
  }

  public var description: String {
    return "\(lat),\(lon)"
  }

  public func within(_ distance: Distance, of other: Coordinate) -> Bool {
    return self.distance(to: other) <= distance
  }

  public func distance(to other: Coordinate) -> Distance {
    let dLat = deg2rad(other.lat - lat)
    let dLon = deg2rad(other.lon - lon)
    let a =
      sin(dLat / 2) * sin(dLat / 2) +
      cos(deg2rad(lat)) * cos(deg2rad(other.lat)) *
      sin(dLon / 2) * sin(dLon / 2)
    let c = 2 * atan2(sqrt(a), sqrt(1 - a))
    return Distance(km: Coordinate.radiusEarth * c)
  }

  private func deg2rad(_ deg: Line) -> Double {
    return deg.value * (.pi / 180.0)
  }
}
