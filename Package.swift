// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Videos",
    platforms: [
            .iOS(.v16)
        ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Videos",
            targets: ["Videos"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Hugo-Coutinho/Network-Layer-Framework", from: "1.0.5"),
        .package(url: "https://github.com/Hugo-Coutinho/HGUIComponents", from: "1.0.3")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Videos",
            dependencies: [
                .product(name: "HGNetworkLayer", package: "Network-Layer-Framework"),
                .product(name: "HGUIComponent", package: "HGUIComponents")
            ]),
        .testTarget(
            name: "VideosTests",
            dependencies: [
                "Videos",
                .product(name: "HGNetworkLayer", package: "Network-Layer-Framework"),
                .product(name: "HGUIComponent", package: "HGUIComponents")
            ],
            resources: [.copy("Fixture/videos_data.json")]
        ),
    ]
)
