// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

/// `NetworkManager` is a generic struct designed to manage network operations for a given endpoint type.
/// It utilizes a specified `ApiServer` instance to configure and execute requests to an API.
/// The generic type `E` allows for flexibility in working with different endpoint definitions,
/// ensuring that the network manager can handle a wide range of network tasks while adhering to the structure and requirements defined by the `EndPointType` protocol.
///
/// - Parameter E: A type that conforms to the `EndPointType` protocol. This type defines the various aspects of an API endpoint, such as path, HTTP method, task, and any additional headers, allowing `NetworkManager` to perform network operations accordingly.
public struct NetLinker<E: EndPointType> {
    
    /// An instance of `ApiServer` that provides the base configuration for making API requests.
    /// This includes the base URL and version of the API, which are crucial for constructing requests to the correct endpoints.
    public var apiServer: ApiServer
    
    /// Initializes a new instance of `NetworkManager` with the provided `ApiServer` configuration.
    /// This allows for the flexibility of configuring the network manager with different API server instances, potentially enabling it to switch between different environments (e.g., production vs. development) or API versions dynamically.
    ///
    /// - Parameter apiServer: An instance of `ApiServer` to be used for configuring and making API requests.
    public init(apiServer: ApiServer) {
        self.apiServer = apiServer
    }
}
