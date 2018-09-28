// https://goo.gl/maps/jQVwrzqCp8u
@testable import Coordinate

import Quick
import Distance
import Nimble

class CoordinateTests: QuickSpec {
  override func spec() {
    it("can compare objects") {
      let x = Coordinate(long: 10.0, lat: 20.0)
      let y = Coordinate(long: 10.0, lat: 20.0)
      expect(y).to(equal(x))
    }

    it("converts to string") {
      let x = Coordinate(
        long: 100.561371,
        lat: 13.822495
      )

      expect(x.description).to(equal("13.822495,100.561371"))
    }

    it("calculates distances") {
      let x = Coordinate(
        long: 100.561371,
        lat: 13.822495
      )

      let y = Coordinate(
        long: 100.613660,
        lat: 13.749423
      )

      expect(Int(x.distance(to: y).meter)).to(equal(9894))
    }

    it("calculates within") {
      let x = Coordinate(
        long: 100.561371,
        lat: 13.822495
      )

      let y = Coordinate(
        long: 100.613660,
        lat: 13.749423
      )

      expect(x.within(Distance(km: 10), of: y)).to(beTrue())
      expect(x.within(Distance(km: 5), of: y)).to(beFalse())

      expect(y.within(Distance(km: 10), of: x)).to(beTrue())
      expect(y.within(Distance(km: 5), of: x)).to(beFalse())
    }
  }
}
