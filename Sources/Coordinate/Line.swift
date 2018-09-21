import Foundation
import Distance

public struct Line: CustomStringConvertible, Comparable {
  public let value: Double

  public init(_ value: Double) {
    self.value = value
  }

  public var radian: Double {
    return value * (.pi / 180.0)
  }

  public static func + (lhs: Line, rhs: Line) -> Line {
    return Line(lhs.value + rhs.value)
  }

  public static func + (lhs: Line, rhs: Double) -> Line {
    return Line(lhs.value + rhs)
  }

  public static func + (lhs: Line, rhs: Distance) -> Line {
    return Line(lhs.value + rhs.km)
  }

  public static func - (lhs: Line, rhs: Distance) -> Line {
    return Line(lhs.value - rhs.km)
  }

  public static func - (lhs: Line, rhs: Double) -> Line {
    return Line(lhs.value - rhs)
  }

  public static func - (lhs: Line, rhs: Line) -> Line {
    return Line(lhs.value - rhs.value)
  }

  public static func == (lhs: Line, rhs: Line) -> Bool {
    return lhs.value == rhs.value
  }

  public static func < (lhs: Line, rhs: Line) -> Bool {
    return lhs.value < rhs.value
  }

  public var description: String {
    return String(value)
  }
}
