import XCTest

import struct Foundation.Date
import struct Foundation.TimeInterval

#if os(Linux)
  import func Glibc.usleep
#endif

import timing

let iterations = 1_000_000

class TimingTests: XCTestCase
{
  func testSince()
  {
    let t1 = Date()
    let i = Interval.since(t1)
    XCTAssertGreaterThanOrEqual(i.ns, 0)
    XCTAssertGreaterThanOrEqual(i.interval, TimeInterval())
  }

  func testCustomString()
  {
    var i = Interval(300)
    XCTAssertEqual(String(describing: i), "300 ns")

    i = Interval(Int64(3002))
    XCTAssertEqual(String(describing: i), "3.002 µs")

    i = Interval(seconds: 12.555e-6)
    XCTAssertEqual(String(describing: i), "12.55 µs")

    i = Interval(22.111e6)
    XCTAssertEqual(String(describing: i), "22.111 ms")

    i = Interval(seconds: 0.5555555) - Interval(1)
    XCTAssertEqual(String(describing: i), "555.555 ms")

    i = Interval(seconds: 10)/9
    XCTAssertEqual(String(describing: i), "1111.11 ms")

    i = Interval(seconds: 8.2222222)
    XCTAssertEqual(String(describing: i), "8.222 s")

    i = Interval(seconds: 1899.4444)
    XCTAssertEqual(String(describing: i), "1899.444 s")
  }

  func testPrintExample()
  {
    let tic = Date()
    usleep(1)
    let dt1 = tic.toc
    usleep(100)
    let dt2 = tic.toc
    print(dt1)
    print(dt2)
    usleep(1000)
    print(tic.toc)
    usleep(1_000_000)
    print(tic.toc)
  }
}
