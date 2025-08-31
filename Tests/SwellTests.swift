import Testing

@testable import Swell

@Test("Echo")
func echo() async throws {
    let echo = try await Swell.run("echo", "How swell!")
    #expect(echo.output == "How swell!\n")
}

@Test("Multiple lines")
func multipleLines() async throws {
    let echo = try await Swell.run("echo", "How swell!\nHow are you?")
    #expect(echo.output == "How swell!\nHow are you?\n")
}

 @Test("Command not found error")
 func commandNotFoundError() async throws {
     await #expect(throws: SwellError.commandNotFound("not-a-command")) {
         try await Swell.run("not-a-command")
     }
 }

 @Test("Non-zero exit error")
 func testNonZeroExitError() async throws {
     await #expect(throws: SwellError.nonZeroExit(code: 1, output: "", error: "")) {
         try await Swell.run("false")
     }
 }
