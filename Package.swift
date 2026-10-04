// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "GeneralLoginPage",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "GeneralLoginPage",
            targets: ["GeneralLoginPage"]
        )
    ],
    targets: [
        .target(
            name: "GeneralLoginPage"
        ),
        .testTarget(
            name: "GeneralLoginPageTests",
            dependencies: ["GeneralLoginPage"]
        )
    ]
)
