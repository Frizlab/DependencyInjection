// swift-tools-version:5.8
import PackageDescription


//let swiftSettings: [SwiftSetting] = []
let swiftSettings: [SwiftSetting] = [.enableExperimentalFeature("StrictConcurrency")]

let package = Package(
	name: "DependencyInjection",
	platforms: [
		.macOS(.v10_15),
		.tvOS(.v13),
		.iOS(.v13),
		.watchOS(.v6)
	],
	products: [
		.library(name: "DependencyInjection", targets: ["DependencyInjection"])
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-service-context.git", from: "1.0.0"),
		.package(url: "https://github.com/Frizlab/SafeGlobal.git",          from: "0.2.0")
	],
	targets: [
		.target(name: "DependencyInjection", dependencies: [
			.product(name: "SafeGlobal",           package: "SafeGlobal"),
			.product(name: "ServiceContextModule", package: "swift-service-context"),
		], path: "Sources", swiftSettings: swiftSettings),
		.testTarget(name: "DependencyInjectionTests", dependencies: [
			"DependencyInjection"
		], path: "Tests", swiftSettings: swiftSettings)
	]
)
