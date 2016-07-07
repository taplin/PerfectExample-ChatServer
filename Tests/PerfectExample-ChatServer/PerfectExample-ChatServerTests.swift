import XCTest
@testable import PerfectExample-ChatServer

class PerfectExample-ChatServerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(PerfectExample-ChatServer().text, "Hello, World!")
    }


    static var allTests : [(String, (PerfectExample-ChatServerTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
