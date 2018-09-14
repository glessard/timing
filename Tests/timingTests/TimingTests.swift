import XCTest

import struct Foundation.Date

#if os(Linux)
  import func Glibc.usleep
#endif

import timing

let iterations = 1_000_000

class TimingTests: XCTestCase
{
  func testToc()
  {
    let tic = Date()
    usleep(10000)
    let i = tic.toc
    XCTAssert(i.interval > 0)
  }

  func testPrint()
  {
    print(Interval(300))
    print(Interval(3002))
    print(Interval(seconds: 12.555e-6))
    print(Interval(seconds: 22.111e-3))
    print(Interval(seconds: 0.5555555))
    print(Interval(seconds: 1.2222222))
    print(Interval(seconds: 8.2222222))
    print(Interval(seconds: 1899.4444))
  }

  func testPrintDemo()
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
