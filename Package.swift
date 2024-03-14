// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWSignInWith3rd_Facebook",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(name: "WWSignInWith3rd_Facebook", targets: ["WWSignInWith3rd_Facebook"]),
    ],
    dependencies: [
        .package(url: "https://github.com/William-Weng/WWSignInWith3rd_Apple", .upToNextMinor(from: "1.1.0")),
        .package(url: "https://github.com/facebook/facebook-ios-sdk", .upToNextMinor(from: "16.3.1")),
    ],
    targets: [
        .target(
            name: "WWSignInWith3rd_Facebook",
            dependencies: [
                .product(name: "FacebookLogin", package: "facebook-ios-sdk"),
                "WWSignInWith3rd_Apple",
            ],
            resources: [.copy("Privacy")]
        ),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
