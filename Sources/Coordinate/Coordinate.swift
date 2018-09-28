import Foundation
import Distance

public struct Coordinate: CustomStringConvertible, Equatable {
  private static let radiusEarth = 6371.0

  public let lon: Double
  public let lat: Double

  public init(long: Double, lat: Double) {
    self.lon = long
    self.lat = lat
  }

  public static func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
    return lhs.lon == rhs.lon && lhs.lat == rhs.lat
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

  private func deg2rad(_ deg: Double) -> Double {
    return deg * (.pi / 180.0)
  }
}
