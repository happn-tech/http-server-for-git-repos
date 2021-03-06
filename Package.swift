// swift-tools-version:5.2
import PackageDescription


let package = Package(
	name: "http-server-for-git-repos",
	platforms: [
		.macOS(.v10_15)
	],
	dependencies: [
		.package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
		.package(url: "https://github.com/MrLotU/SwiftPrometheus.git", from: "1.0.0-alpha"),
		.package(url: "https://github.com/kareman/SwiftShell", from: "5.1.0")
	],
	targets: [
		.target(
			name: "App",
			dependencies: [
				.product(name: "SwiftPrometheus", package: "SwiftPrometheus"),
				.product(name: "SwiftShell", package: "SwiftShell"),
				.product(name: "Vapor", package: "vapor")
			],
			swiftSettings: [
				/* Enable better optimizations when building in Release
				 * configuration. Despite the use of the `.unsafeFlags` construct
				 * required by SwiftPM, this flag is recommended for Release builds.
				 * See <https://github.com/swift-server/guides#building-for-production>
				 * for details. */
				.unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
			]
		),
		.target(name: "http-server-for-git-repos", dependencies: [.target(name: "App")]),
		.testTarget(name: "AppTests", dependencies: [
			.target(name: "App"),
			.product(name: "XCTVapor", package: "vapor"),
		])
	]
)
