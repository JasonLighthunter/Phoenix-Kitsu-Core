// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "PhoenixKitsuCore",
  products: [
    .library(name: "PhoenixKitsuCore", targets: ["PhoenixKitsuCore"])
  ],
  dependencies: [
    .package(url: "https://gitlab.com/JasonLighthunter/Requestable.git", from: "1.0.2")
  ],
  targets: [
    .target(name: "PhoenixKitsuCore", dependencies: ["Requestable"]),
    .testTarget(name: "PhoenixKitsuCoreTests", dependencies: ["PhoenixKitsuCore"])
  ]
)
