//
//  NetworkRouter.swift
//
//
//  Created by Handy Handy on 22/03/24.
//

import Foundation

/// Typealias for a completion handler used by network routing operations.
/// This completion handler is invoked when a network request is completed, providing the data received,
/// the URL response, and any error that occurred during the request.
///
/// - Parameters:
///   - data: The data returned by the server, if any. This parameter is nil if no data was returned or if an error occurred.
///   - response: The URL response received from the server. This provides details about the response, such as the HTTP status code.
///   - error: An error that occurred during the request. This parameter is nil if the request was successful.
public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

/// A protocol defining the requirements for a network router capable of making network requests.
/// Network routers are responsible for constructing and initiating network requests based on the provided `ApiServer` configuration
/// and an endpoint that conforms to the `EndPointType` protocol. The goal is to abstract the details of making network requests,
/// allowing for easier testing and modification.
///
/// Implementers of this protocol should handle the creation of `URLRequest` objects based on the provided `apiServer` and `route`
/// parameters, properly configuring the request with the necessary HTTP method, headers, body, and so on.
protocol NetworkRouter: AnyObject {
    /// The type of endpoint the router works with. This associated type must conform to the `EndPointType` protocol.
    associatedtype EndPoint: EndPointType

    /// Constructs a `URLRequest` for a given API server and route.
    ///
    /// This method takes an `ApiServer` instance and an endpoint of the associated `EndPoint` type,
    /// constructing a `URLRequest` configured for the specific API call represented by the endpoint.
    /// The method should apply the endpoint's path, HTTP method, task, and headers to the request.
    ///
    /// - Parameters:
    ///   - apiServer: An `ApiServer` instance providing the base URL and version for the request.
    ///   - route: An endpoint conforming to `EndPointType` that specifies the path, HTTP method, task, and headers for the request.
    /// - Returns: A `URLRequest` configured for the specified `apiServer` and `route`, or nil if the request could not be created.
    func request(_ apiServer: ApiServer, _ route: EndPoint) -> URLRequest?
}
