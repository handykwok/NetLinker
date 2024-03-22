//
//  EndPointType.swift
//
//
//  Created by Handy Handy on 22/03/24.
//

import Foundation

/**
 `EndPointType` is a protocol that defines the essential information needed to configure network request endpoints.
 It specifies the path, HTTP method, task type, and optional headers that should be used when making a request to a specific endpoint.
 Implementing this protocol allows for a structured and consistent way to define different endpoints throughout an application.

 Properties:
 - `path`: A `String` representing the relative path of the endpoint. This path will be appended to the base URL of the
   network service to construct the full URL for the request.
 - `httpMethod`: An instance of `HTTPMethod` enum specifying the HTTP method (e.g., GET, POST, PUT) to be used for the request.
   This indicates the action to be performed on the resource identified by the URL.
 - `task`: An instance of `HTTPTask` enum that specifies the task for the request. It defines whether the request should
   include parameters (body and/or URL parameters) and/or additional headers. This allows for flexible configuration
   of requests based on the endpoint's requirements.
 - `headers`: An optional `HTTPHeaders` dictionary specifying any additional headers that should be included in the request.
   Headers can include authentication tokens, content-type specifications, and other metadata relevant to the HTTP request.

 Usage:
 Implementing the `EndPointType` protocol involves defining these properties to suit the specific requirements of an endpoint.
 For instance, an endpoint for fetching user data might specify a GET method, a path of `/users`, and include an authentication
 token in the headers. Another endpoint for posting new user data might use a POST method, include URL and/or body parameters
 to send the data, and specify content-type among its headers.

 Implementing this protocol in your networking layer helps in organizing and managing network request configurations, making
 your code cleaner and more maintainable.
*/
public protocol EndPointType {
    /// The endpoint's relative path.
    var path: String { get }
    
    /// The HTTP method used for the request.
    var httpMethod: HTTPMethod { get }
    
    /// The task for the request, including any parameters and additional headers.
    var task: HTTPTask { get }
    
    /// Any additional headers required for the request.
    var headers: HTTPHeaders? { get }
}
