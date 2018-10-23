import XCTest

extension TimingTests {
    static let __allTests = [
        ("testCustomString", testCustomString),
        ("testPrintExample", testPrintExample),
        ("testSince", testSince),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(TimingTests.__allTests),
    ]
}
#endif
