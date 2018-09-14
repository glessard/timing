// swift-tools-version:4.2

import PackageDescription

#if !swift(>=4.2)
let versions = [3,4]
#else
let versions = [SwiftVersion.v3, .v4, .v4_2]
#endif

#if swift(>=4.0)

let package = Package(
  name: "timing",
  products: [
    .library(name: "timing", type: .static, targets: ["timing"]),
  ],
  targets: [
    .target(name: "timing"),
    .testTarget(name: "timingTests", dependencies: ["timing"]),
  ],
  swiftLanguageVersions: versions
)

#else

let package = Package(
  name: "timing"
)

#endif
