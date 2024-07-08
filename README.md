# Swell 🌊

A nimble **Sw**ift Sh**ell** library.

## Usage

Just add Swell to your package dependencies:

```swift
dependencies: [
    // ...
    .package(url: "https://github.com/marcelo-es/swell", from: "0.0.1"),
]
```

And add Swell to your target's dependencies:

```swift
targets: [
    .target(name: "MyTarget", dependencies: [
        // ...
        .product(name: "Swell", package: "swell"),
    ])
]
```

Then execute shell commands and receive the standard output and error:

```swift
let (output, error) = try await Swell.run("echo", "Hello world")
```

Or, if you are only interested in the standard output:

```swift
let output = try = try await Swell.run("echo", "Hello world").output
```

Swell looks for the executable in your `$PATH` for you.
