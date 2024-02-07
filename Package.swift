//swift-tools-version: 5.5

import PackageDescription

let package = Package(
    name: "GLTFKit2",
    platforms: [
        .macOS("11.0"), .macCatalyst("14.0"), .iOS("12.1"), .tvOS("12.1")
        // Note: visionOS("1.0") is also supported, but we can't require Swift tools version 5.9 yet.
    ],
    products: [
        .library(name: "GLTFKit2",
                 targets: [ "GLTFKit2" ])
    ],
    targets: [
        .binaryTarget(name: "GLTFKit2",
                      url: "https://github.com/superbright/GLTFKit2/releases/download/v0.5.9/GLTFKit2.xcframework.zip",
                      checksum:"1c3bc8afeabfca930b91219448e800436d2338f4ed891178eb0239dbf4bbc51d")
    ]
)
