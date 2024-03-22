//
//  HttpMethod.swift
//
//
//  Created by Handy Handy on 22/03/24.
//

import Foundation

/**
 An enumeration that defines the available HTTP methods for network requests.

 HTTP methods indicate the desired action to be performed on a given resource. Each method has specific semantics in the context of RESTful APIs, guiding how requests and responses should be handled.

 - Cases:
   - `get`: Represents an HTTP GET request, used for retrieving data from a resource. It is a read-only operation and does not modify the resource.
   - `post`: Represents an HTTP POST request, used for submitting data to a resource. It often results in a change of state or side effects on the server.
*/
public enum HTTPMethod: String {
    case get = "GET"    // Used for retrieving data.
    case post = "POST"  // Used for submitting data to a resource.
}
