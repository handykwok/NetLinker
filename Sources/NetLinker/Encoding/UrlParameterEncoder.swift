//
//  UrlParameterEncoder.swift
//
//
//  Created by Handy Handy on 22/03/24.
//

import Foundation

/// `URLParameterEncoder` conforms to the `ParameterEncoder` protocol and provides functionality
/// to encode URL parameters for a URLRequest.
///
/// It encodes parameters as query strings and appends them to the URL of the URLRequest. This encoder
/// is particularly useful for GET requests where parameters need to be sent as part of the URL.
public struct URLParameterEncoder: ParameterEncoder {
    
    /// Encodes the given parameters as a query string and appends them to the URL of the URLRequest.
    /// If the request does not already have a "Content-Type" header, sets it to
    /// "application/x-www-form-urlencoded; charset=utf-8".
    ///
    /// - Parameters:
    ///   - urlRequest: The URLRequest to be modified with URL parameters. This parameter is inout, meaning it is modified directly.
    ///   - parameters: A dictionary of parameters to be encoded into the URL. The keys represent parameter names,
    ///                 and the values represent parameter values. Supports encoding of array values as repeated parameters.
    ///
    /// - Throws: `NetworkError.missingURL` if the URLRequest does not have a URL.
    ///
    /// Usage:
    /// Use this function when you need to encode parameters into the URL of a URLRequest, typically for GET requests.
    /// For example, to encode a query for a search API where parameters define the query terms and filters.
    ///
    /// Example:
    /// ```
    /// var request = URLRequest(url: URL(string: "https://example.com/search")!)
    /// let parameters: Parameters = ["query": "swift", "count": "10"]
    /// try URLParameterEncoder.encode(urlRequest: &request, with: parameters)
    /// // The request URL is now "https://example.com/search?query=swift&count=10"
    /// ```
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            
            for (var key, value) in parameters {
                // Handling array values by appending "[]" to the key and adding each value as a separate query item.
                if let arrayValue = value as? [Any] {
                    key += "[]"
                    arrayValue.forEach { data in
                        let queryItem = URLQueryItem(name: key, value: "\(data)")
                        urlComponents.queryItems?.append(queryItem)
                    }
                } else {
                    let queryItem = URLQueryItem(name: key, value: "\(value)")
                    urlComponents.queryItems?.append(queryItem)
                }
                urlRequest.url = urlComponents.url
            }
        }
        // Setting the "Content-Type" header if not already set.
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}

