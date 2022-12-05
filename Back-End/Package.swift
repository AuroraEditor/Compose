// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Compose",
    platforms: [
       .macOS(.v12)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.67.4"),
        .package(url: "https://github.com/vapor/fluent-mongo-driver.git", from: "1.1.2"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.5.0"),
        .package(url: "https://github.com/vapor/jwt.git", from: "4.2.1"),
        .package(url: "https://github.com/mczachurski/Swiftgger.git", from: "1.4.0"),
        .package(url: "https://github.com/vapor/queues.git", from: "1.11.1"),
        .package(url: "https://github.com/vapor/queues-redis-driver.git", from: "1.0.0-rc.1"),
        .package(url: "https://github.com/vapor-community/google-cloud.git", from: "1.0.0-rc"),
        .package(url: "https://github.com/jpsim/Yams.git", from: "4.0.0"),
        .package(url: "https://github.com/mattpolzin/VaporOpenAPI.git", from: "0.0.17")
    ],
    targets: [
        .target(
            name: "Compose",
            dependencies: [
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentMongoDriver", package: "fluent-mongo-driver"),
                .product(name: "Vapor", package: "vapor"),
                .product(name: "JWT", package: "jwt"),
                .product(name: "Swiftgger", package: "swiftgger"),
                .product(name: "QueuesRedisDriver", package: "queues-redis-driver"),
                .product(name: "CloudStorage", package: "google-cloud"),
                .product(name: "Yams", package: "Yams"),
                .product(name: "VaporOpenAPI", package: "VaporOpenAPI"),
            ],
            swiftSettings: [
                // Enable better optimizations when building in Release configuration. Despite the use of
                // the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
                // builds. See <https://github.com/swift-server/guides/blob/main/docs/building.md#building-for-production> for details.
                .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
            ]
        ),
        .executableTarget(name: "Run", dependencies: [.target(name: "Compose")]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
            .product(name: "FluentMongoDriver", package: "fluent-mongo-driver"),
        ])
    ]
)
