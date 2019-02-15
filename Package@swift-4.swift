// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "timing",
  products: [
    .library(name: "timing", type: .static, targets: ["timing"]),
  ],
  targets: [
    .target(name: "timing"),
    .testTarget(name: "timingTests", dependencies: ["timing"]),
  ],
  swiftLanguageVersions: [3,4]
)
