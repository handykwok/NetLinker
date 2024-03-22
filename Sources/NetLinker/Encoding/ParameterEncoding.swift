//
//  ParameterEncoding.swift
//  
//
//  Created by Handy Handy on 22/03/24.
//

import Foundation

/// Protocol defining the requirement for parameter encoders.
/// Encoders that conform to this protocol can encode parameters into a `URLRequest`.
public protocol ParameterEncoder {
    /// Encodes parameters into a given `URLRequest`.
    /// - Parameters:
    ///   - urlRequest: The `URLRequest` object to be modified by encoding parameters. It is an inout parameter, allowing it to be modified.
    ///   - parameters: The parameters to be encoded into the `URLRequest`.
    /// - Throws: Throws an error if encoding fails.
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

/// Enum representing the available parameter encoding strategies.
/// Allows for specifying how parameters should be encoded into a `URLRequest`.
public enum ParameterEncoding {
    /// Encodes parameters into the URL query string.
    case urlEncoding
    /// Encodes parameters into the HTTP body as JSON.
    case jsonEncoding
    /// Encodes parameters into both the URL query string and the HTTP body as JSON.
    case urlAndJsonEncoding

    /// Encodes parameters into a `URLRequest` according to the selected encoding strategy.
    /// - Parameters:
    ///   - urlRequest: The `URLRequest` to be modified by encoding parameters.
    ///   - bodyParameters: Parameters to be encoded into the HTTP body. Only used with `.jsonEncoding` and `.urlAndJsonEncoding`.
    ///   - urlParameters: Parameters to be encoded into the URL query. Only used with `.urlEncoding` and `.urlAndJsonEncoding`.
    /// - Throws: Throws an error if encoding fails.
    public func encode(urlRequest: inout URLRequest, bodyParameters: Parameters?, urlParameters: Parameters?) throws {
        switch self {
        case .urlEncoding:
            guard let urlParameters = urlParameters else { return }
            try URLParameterEncoder.encode(urlRequest: &urlRequest, with: urlParameters)
        case .jsonEncoding:
            guard let bodyParameters = bodyParameters else { return }
            try JSONParameterEncoder.encode(urlRequest: &urlRequest, with: bodyParameters)
        case .urlAndJsonEncoding:
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &urlRequest, with: urlParameters)
            }
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &urlRequest, with: bodyParameters)
            }
        }
    }
}

/// Enum representing possible errors that can occur during the parameter encoding process.
public enum NetworkError: String, Error {
    /// Indicates that parameters were nil when they were expected to be non-nil.
    case parameterNil = "Parameters are nil."
    /// Indicates that encoding of parameters failed.
    case encodingFailed = "Parameters encoding failed."
    /// Indicates that the URL of the `URLRequest` is nil.
    case missingURL = "URL is nil"
}

/// Enum to specify the type of parameters encoding.
/// This enum is similar to `ParameterEncoding` but provides a simplified view, potentially for cases where explicit distinction between URL and JSON encoding is needed without combining them.
public enum ParametersEncoding {
    /// Parameters will be encoded in the URL.
    case url
    /// Parameters will be encoded as JSON in the request body.
    case json
}
