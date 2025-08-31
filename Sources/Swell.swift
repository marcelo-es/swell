import Foundation
import System

public struct Swell {

    private init() {
    }

    /// Run a command found in the path and return its output.
    @discardableResult
    public static func run(_ commandName: String, _ arguments: String...) async throws -> (output: String, error: String) {
        guard let commandPath = findFilePath(for: commandName) else {
            throw SwellError.commandNotFound(commandName)
        }

        let process = Process()
        process.executableURL = URL(filePath: commandPath)
        process.arguments = arguments

        let outputPipe = Pipe()
        process.standardOutput = outputPipe

        let errorPipe = Pipe()
        process.standardError = errorPipe

        async let outputLines = outputPipe.fileHandleForReading.bytes.characters.reduce(into: "") { $0.append($1) }
        async let errorLines = errorPipe.fileHandleForReading.bytes.characters.reduce(into: "") { $0.append($1) }

        try process.run()
        process.waitUntilExit()

        let terminationStatus = process.terminationStatus
        guard terminationStatus == 0 else {
            throw SwellError.nonZeroExit(
                code: Int(terminationStatus),
                output: try await outputLines,
                error: try await errorLines
            )
        }

        return try await (outputLines, errorLines)
    }

    static func findFilePath(for commandName: String) -> FilePath? {
        for path in searchPath {
            let executablePath = path.appending(commandName)
            if FileManager.default.fileExists(atPath: executablePath.string) {
                return executablePath
            }
        }
        return nil
    }

    static var searchPath: [FilePath] {
        let path = ProcessInfo.processInfo.environment["PATH"] ?? ""
        return path.split(separator: ":").map { FilePath(String($0)) }
    }

}

public enum SwellError: Error, Equatable {

    case commandNotFound(String)
    case nonZeroExit(code: Int, output: String, error: String)

}

extension SwellError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .commandNotFound(let commandName):
            return "Command not found: \(commandName)"
        case .nonZeroExit(let code, _, _):
            return "Command exited with non-zero exit code: \(code)"
        }
    }

}
