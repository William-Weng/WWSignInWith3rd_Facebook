// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWSignInWith3rd+Facebook",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(name: "WWSignInWith3rd+Facebook", targets: ["WWSignInWith3rd+Facebook"]),
    ],
    dependencies: [
        .package(name: "WWSignInWith3rd+Apple", url: "https://github.com/William-Weng/WWSignInWith3rd_Apple", .upToNextMinor(from: "1.0.1")),
        .package(url: "https://github.com/facebook/facebook-ios-sdk", .upToNextMinor(from: "16.1.0")),
    ],
    targets: [
        .target(name: "WWSignInWith3rd+Facebook", dependencies: [
            .product(name: "FacebookLogin", package: "facebook-ios-sdk"),
            "WWSignInWith3rd+Apple",
        ]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
