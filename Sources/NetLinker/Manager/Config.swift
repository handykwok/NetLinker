//
//  Config.swift
//
//
//  Created by Handy Handy on 22/03/24.
//

import Foundation

/// Enum representing the running environment of the application.
/// It differentiates between development and production settings,
/// allowing for environment-specific configurations such as API endpoints.
public enum Environment {
    /// Indicates the application is running in a production environment with live settings.
    case production
    /// Indicates the application is running in a development environment with settings suited for testing and development.
    case development
}

/// Protocol defining the requirements for an API server's configuration.
/// It mandates a base URL and a version string to standardize the API requests across the application.
public protocol ApiServer {
    /// The base URL of the API server. This is the root URL to which API requests are directed.
    var baseUrl: String { get set }
    
    /// The version of the API, used to access version-specific endpoints.
    var version: String { get set }
}

/// Protocol for a factory that creates instances of `ApiServer`.
/// This factory pattern is useful for encapsulating the creation logic,
/// allowing for different implementations based on the environment or configuration.
public protocol ApiServerFactoryProtocol {
    /// Creates and returns an instance of `ApiServer`.
    /// This method should encapsulate the logic for configuring the API server based on the application's needs.
    /// - Returns: A configured instance of `ApiServer`.
    func create() -> ApiServer
}

/// Protocol intended to produce `ApiServer` instances,
/// seemingly similar to `ApiServerFactoryProtocol` but might be tailored for different contexts or environments.
/// It's important to clarify or differentiate its use case from `ApiServerFactoryProtocol`.
public protocol EnvironmentFactoryProtocol {
    /// Creates and returns an `ApiServer` instance.
    /// The implementation should consider the current environment to configure the API server appropriately.
    /// - Returns: An `ApiServer` instance, configured for the current environment.
    func create() -> ApiServer
}
