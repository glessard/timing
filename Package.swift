// swift-tools-version:4.0

import PackageDescription

let name = "timing"

#if swift(>=4.0)

let package = Package(
  name: name,
  products: [
    .library(name: name, type: .static, targets: [name]),
  ],
  targets: [
    .target(name: name),
    .testTarget(
      name: name+"Tests",
      dependencies: [Target.Dependency(stringLiteral: name)]),
  ],
  swiftLanguageVersions: [3,4]
)

#else

let package = Package(
  name: name
)

#endif
