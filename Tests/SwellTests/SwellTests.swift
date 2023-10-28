import XCTest
@testable import Swell

final class SwellTests: XCTestCase {

    func testEcho() async throws {
        let echo = try await Swell.run("echo", "How swell!")
        XCTAssertEqual(echo, "How swell!\n")
    }

    func testError() async throws {
        do {
            _ = try await Swell.run("not-a-command")
            XCTFail("Expected an error")
        } catch {
            XCTAssertEqual(error.localizedDescription, "Command not found: not-a-command")
        }
    }

}
