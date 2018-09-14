import XCTest

import timingTests

var tests = [XCTestCaseEntry]()
tests += timingTests.__allTests()

XCTMain(tests)
