// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Argon2Kit",
    products: [
        .library(
            name: "Argon2Kit",
            targets: ["Argon2Kit"]),
    ],
    dependencies: [
        .package(name: "argon2", url: "https://github.com/P-H-C/phc-winner-argon2", revision: "f57e61e19229e23c4445b85494dbf7c07de721cb")
    ],
    targets: [
        .target(
            name: "Argon2Kit",
            dependencies: ["argon2"]),
        .testTarget(
            name: "Argon2KitTests",
            dependencies: ["Argon2Kit"]),
    ]
)
