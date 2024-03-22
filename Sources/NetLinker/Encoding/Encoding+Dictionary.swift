//
//  Encoding+Dictionary.swift
//
//
//  Created by Handy Handy on 22/03/24.
//

import Foundation

/**
 `Encodable` protocol extension to add a method for converting `Encodable` instances to a dictionary representation.

 This extension provides a convenient way to convert any object that conforms to the `Encodable` protocol into a `[String: Any]` dictionary. This can be useful for debugging purposes, when you need to inspect the encoded state of an object, or when you need to use an object as a parameter in a network request and require a dictionary representation.

 - Returns: A dictionary representation of the `Encodable` object if successful, or an empty dictionary if the encoding or conversion to a dictionary fails.

 Usage:
 Implement this method when you need to convert an `Encodable` instance into a dictionary. For instance, this can be particularly handy when working with network layer code that requires parameters to be passed as a dictionary. Instead of manually constructing the dictionary, you can define your parameters as a struct that conforms to `Encodable`, and then use `asDictionary()` to get the dictionary representation.

 Example:
 ```
 struct User: Encodable {
    var id: Int
    var name: String
 }
 let user = User(id: 1, name: "John Doe")
 let userDictionary = user.asDictionary()
 // Now userDictionary can be used wherever a [String: Any] dictionary is required.
 ```
 Note:
 - This method uses `JSONEncoder` to encode the object into `Data`, and then attempts to convert this data into a dictionary using `JSONSerialization`.
 - If encoding fails or the resulting object is not a dictionary, the method catches the error, prints a failure message, and returns an empty dictionary.
 - It is important to handle the returned empty dictionary appropriately in your code to avoid unintended consequences.
 */
 public extension Encodable {
    func asDictionary() -> [String: Any] {
        do {
            let data = try JSONEncoder().encode(self)
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                throw NSError()
            }
            return dictionary
        } catch {
            print("Failed to convert codable object to dictionary")
            return [:]
        }
    }
 }
