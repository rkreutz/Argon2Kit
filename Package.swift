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
    dependencies: [],
    targets: [
        .target(
            name: "Argon2Kit",
            dependencies: ["argon2"]),
        .target(
            name: "argon2",
            exclude: [
                "kats",
                "vs2015",
                "latex",
                "libargon2.pc.in",
                "export.sh",
                "appveyor.yml",
                "Argon2.sln",
                "argon2-specs.pdf",
                "CHANGELOG.md",
                "LICENSE",
                "Makefile",
                "man",
                "README.md",
                "src/bench.c",
                "src/genkat.c",
                "src/opt.c",
                "src/run.c",
                "src/test.c",
            ],
            sources: [
                "src/blake2/blake2b.c",
                "src/argon2.c",
                "src/core.c",
                "src/encoding.c",
                "src/ref.c",
                "src/thread.c"
            ]
        ),
        .testTarget(
            name: "Argon2KitTests",
            dependencies: ["Argon2Kit"]),
    ]
)
