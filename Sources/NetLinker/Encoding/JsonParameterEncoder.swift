//
//  JsonParameterEncoder.swift
//  
//
//  Created by Handy Handy on 22/03/24.
//

import Foundation

/// `JSONParameterEncoder` is a struct that conforms to the `ParameterEncoder` protocol.
/// It provides functionality to encode parameters as JSON and then sets the encoded JSON data as the HTTP body of a URLRequest.
/// Additionally, it ensures that the "Content-Type" header of the URLRequest is set to "application/json" if not already specified.
///
/// This encoder is typically used when making HTTP POST, PUT, or PATCH requests that require the request body to be in JSON format.
public struct JSONParameterEncoder: ParameterEncoder {
    
    /// Encodes the given parameters as JSON and sets the encoded data as the HTTP body of the provided URLRequest.
    /// It also checks if the URLRequest's "Content-Type" header is set to "application/json", and sets it if not.
    ///
    /// - Parameters:
    ///   - urlRequest: The URLRequest object to be modified by setting its HTTP body with the encoded JSON data. This parameter is inout, meaning it is modified directly.
    ///   - parameters: A dictionary of parameters that will be encoded as JSON. The dictionary should conform to JSONSerialization's requirements (i.e., it must be a valid JSON object).
    ///
    /// - Throws: `NetworkError.encodingFailed` if encoding the parameters as JSON fails. This could occur if the parameters are not a valid JSON object.
    ///
    /// Usage:
    /// This function is intended to be used internally by the networking layer when preparing a URLRequest that needs to send data in JSON format. It abstracts the details of converting parameters into JSON and updating the URLRequest accordingly.
    ///
    /// Example:
    /// ```
    /// var request = URLRequest(url: URL(string: "https://example.com/api/data")!)
    /// let parameters: Parameters = ["key": "value", "anotherKey": 123]
    ///
    /// try JSONParameterEncoder.encode(urlRequest: &request, with: parameters)
    ///
    /// // The request is now configured with a JSON-encoded HTTP body and "Content-Type: application/json"
    /// ```
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
}

