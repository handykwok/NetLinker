//
//  Router.swift
//
//
//  Created by Handy Handy on 22/03/24.
//

import Foundation

/// `Router` is a generic class that handles network requests for endpoints conforming to `EndPointType`.
/// It manages the creation and configuration of `URLRequest` objects based on the provided API server and route information,
/// facilitating the execution of network tasks.
///
/// The class supports the cancellation of ongoing tasks, allowing for flexible management of network operations.
public class Router<EndPoint: EndPointType>: NetworkRouter {
    /// The current network task associated with this router instance.
    /// Allows for task management, such as cancellation or observation.
    private var task: URLSessionTask?

    /// Initializes a new router instance, optionally with a pre-existing network task.
    /// - Parameter task: An optional `URLSessionTask` to be managed by the router. Default is `nil`.
    public init(task: URLSessionTask? = nil) {
        self.task = task
    }

    /// Constructs and returns a `URLRequest` for a given API server and route.
    /// - Parameters:
    ///   - apiServer: An instance of `ApiServer` providing base URL and API version for constructing the request URL.
    ///   - route: An endpoint conforming to `EndPointType` specifying the path, HTTP method, task, and headers for the request.
    /// - Returns: A configured `URLRequest` for the specified API server and route, or `nil` if the request could not be created.
    public func request(_ apiServer: ApiServer, _ route: EndPoint) -> URLRequest? {
        do {
            return try self.buildRequest(apiServer, from: route)
        } catch {
            return nil
        }
    }
    
    /// Constructs a `URLRequest` based on the specified `ApiServer` and endpoint.
    /// This method is responsible for assembling the URL, setting HTTP methods, and encoding parameters and headers as required by the endpoint.
    /// - Parameters:
    ///   - apiServer: The `ApiServer` instance providing the base URL and API version.
    ///   - route: The endpoint from which to construct the request.
    /// - Throws: An error if the request could not be constructed, typically due to encoding failures.
    /// - Returns: A `URLRequest` configured for the specified endpoint, or `nil` if the base URL is invalid.
    fileprivate func buildRequest(_ apiServer: ApiServer, from route: EndPoint) throws -> URLRequest? {
        guard let baseUrl = URL(string: apiServer.baseUrl) else {return nil}
        var url = baseUrl
        url = baseUrl.appendingPathComponent(apiServer.version)
        var request = URLRequest(url: url.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 30.0)
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(bodyParameters: let bodyParameters,
                                    urlParameters: let urlParameters):
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             request: &request)
            case .requestParametersAndHeaders(bodyParameters: let bodyParameters,
                                              urlParameters: let urlParameters,
                                              additionalHeaders: let additionalHeaders):
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    /// Encodes and sets the body and URL parameters for the request.
    /// - Parameters:
    ///   - bodyParameters: Parameters to be encoded and set as the request's body.
    ///   - urlParameters: Parameters to be encoded into the request's URL.
    ///   - request: The `URLRequest` to be modified.
    /// - Throws: An error if encoding fails.
    fileprivate func configureParameters(bodyParameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws {
        if let bodyParameters = bodyParameters {
            try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
        }
        if let urlParameters = urlParameters {
            try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
        }
    }
    
    /// Adds additional headers to the request.
    /// - Parameters:
    ///   - additionalHeaders: A dictionary containing the headers to add to the request.
    ///   - request: The `URLRequest` to be modified.
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
    }
}

