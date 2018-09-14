import XCTest

extension TimingTests {
    static let __allTests = [
        ("testPrint", testPrint),
        ("testPrintDemo", testPrintDemo),
        ("testToc", testToc),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(TimingTests.__allTests),
    ]
}
#endif
