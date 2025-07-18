// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NeoBrutalism",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "NeoBrutalism",
            targets: ["NeoBrutalism"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/adammcarter/swift-snapshot-testing-macros.git", .upToNextMajor(from: "0.1.6")),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "NeoBrutalism"),
        .testTarget(
            name: "NeoBrutalismTests",
            dependencies: ["NeoBrutalism", .product(name: "SnapshotTestingMacros", package: "swift-snapshot-testing-macros")]
        ),
    ]
)
