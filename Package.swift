// swift-tools-version:4.2

import PackageDescription

#if swift(>=4.0)

let package = Package(
  name: "timing",
  products: [
    .library(name: "timing", targets: ["timing"]),
  ],
  targets: [
    .target(name: "timing"),
    .testTarget(name: "timingTests", dependencies: ["timing"]),
  ],
  swiftLanguageVersions: [.v3, .v4, .v4_2, .version("5")]
)

#else

let package = Package(
  name: "timing"
)

#endif
