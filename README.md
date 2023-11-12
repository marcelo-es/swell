# Swell 🌊

Swell is a nimble Swift API for executing shell commands using Swift Concurrency.

## Usage

Execute a shell command and receive the standard output and error:

```swift
let (output, error) = try await Swell.run("echo", "Hello world")
```
