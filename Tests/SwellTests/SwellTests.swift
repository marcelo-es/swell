import XCTest

@testable import Swell

final class SwellTests: XCTestCase {

    func testEcho() async throws {
        let echo = try await Swell.run("echo", "How swell!")
        XCTAssertEqual(echo.output, "How swell!\n")
    }

    func testMultipleLines() async throws {
        let echo = try await Swell.run("echo", "How swell!\nHow are you?")
        XCTAssertEqual(echo.output, "How swell!\nHow are you?\n")
    }

    func testCommandNotFoundError() async throws {
        do {
            _ = try await Swell.run("not-a-command")
            XCTFail("Expected an error")
        } catch {
            XCTAssertEqual(error.localizedDescription, "Command not found: not-a-command")
        }
    }

    func testNonZeroExitError() async throws {
        do {
            _ = try await Swell.run("false")
            XCTFail("Expected an error")
        } catch {
            XCTAssertEqual(error.localizedDescription, "Command exited with non-zero exit code: 1")
        }
    }

}
