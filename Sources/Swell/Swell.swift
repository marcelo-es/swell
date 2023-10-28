import Foundation
import System

public struct Swell {

    private init() {
    }

    /// Run a command found in the path and return its output.
    @discardableResult
    public static func run(_ commandName: String, _ arguments: String...) async throws -> String {
        guard let commandPath = findFilePath(for: commandName) else {
            throw SwellError.commandNotFound(commandName)
        }
        
        let process = Process()
        process.executableURL = URL(filePath: commandPath)
        process.arguments = arguments

        let outputPipe = Pipe()
        process.standardOutput = outputPipe

        async let output = outputPipe.fileHandleForReading.bytes.reduce(into: Data(), { $0.append($1) })

        try process.run()
        process.waitUntilExit()

        let data = try await output
        return String(data: data, encoding: .utf8) ?? ""
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

public enum SwellError: Error {

    case commandNotFound(String)

}

extension SwellError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .commandNotFound(let commandName):
            return "Command not found: \(commandName)"
        }
    }

}
