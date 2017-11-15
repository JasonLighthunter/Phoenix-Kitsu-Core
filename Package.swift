// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PhoenixKitsuCore",
    products: [
        .library(name: "PhoenixKitsuCore", targets: ["PhoenixKitsuCore"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(name: "PhoenixKitsuCore", dependencies: []),
        .testTarget(name: "PhoenixKitsuCoreTests", dependencies: ["PhoenixKitsuCore"]),
    ]
)
