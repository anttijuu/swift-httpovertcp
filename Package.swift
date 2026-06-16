// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "ManualHTTPoverTCP",
	platforms: [
		.macOS(.v26)
	],
	products: [
		.executable(name: "ManualHTTPoverTCP", targets: ["ManualHTTPoverTCP"])
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0")
	],
	targets: [
		.executableTarget(
			name: "ManualHTTPoverTCP",
			dependencies: [
				.product(name: "NIOCore", package: "swift-nio"),
				.product(name: "NIOPosix", package: "swift-nio")
			],
			path: "Sources/ManualHTTPoverTCP"
		),
	]
)
