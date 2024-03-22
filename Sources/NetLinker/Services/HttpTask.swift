//
//  HttpTask.swift
//  
//
//  Created by Handy Handy on 22/03/24.
//

import Foundation

/// Type alias for HTTP headers, represented as a dictionary where keys and values are both `String` types.
/// This is used to specify headers for an HTTP request, such as `Content-Type` and `Authorization`.
public typealias HTTPHeaders = [String: String]

/// Type alias for parameters of an HTTP request, represented as a dictionary where keys are `String` types
/// and values are `Any` type, allowing for various types of data (e.g., `String`, `Int`, `Bool`) to be included.
/// This is used for specifying both URL parameters (e.g., query strings) and body parameters (e.g., JSON body).
public typealias Parameters = [String: Any]

/**
 `HTTPTask` is an enum that defines the different types of tasks that can be performed by the networking layer.
 It allows for flexible configuration of HTTP requests, including the ability to add parameters to the body or URL,
 as well as the capability to include additional HTTP headers.

 - Cases:
   - `request`: Represents a simple request without any parameters or headers. Suitable for simple GET requests.
   - `requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)`: Represents a request that includes
     optional body parameters and/or URL parameters. This is useful for requests that need to send data to the server,
     such as POST or PUT requests with a JSON body or URL query parameters.
   - `requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionalHeaders: HTTPHeaders?)`:
     Represents a request that includes optional body parameters, URL parameters, and additional HTTP headers.
     This allows for the most flexibility, accommodating complex requests that require specific headers beyond
     the standard ones automatically managed by the networking layer (e.g., custom authentication tokens).
 */
public enum HTTPTask {
    /// A simple request without any parameters or additional headers.
    case request
    
    /// A request that may include optional body parameters and/or URL parameters.
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    
    /// A request that may include optional body parameters, URL parameters, and additional HTTP headers.
    case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionalHeaders: HTTPHeaders?)
}
