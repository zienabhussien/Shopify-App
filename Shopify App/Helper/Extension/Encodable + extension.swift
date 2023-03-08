//
//  Encodable + extension.swift
//  Shopify App
//
//  Created by Ali Moustafa on 01/03/2023.
//

import Foundation
// MARK: -  function takes the object, encodes it using JSONEncoder, and then uses JSONSerialization to convert the resulting Data object into a dictionary.
extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
/*
 The function starts by encoding the object using JSONEncoder. If encoding is successful, it then attempts to convert the resulting Data object into a dictionary using JSONSerialization. If the conversion is successful, it returns the resulting dictionary. If the conversion fails for any reason, it throws an NSError.

 This extension can be useful when you need to pass an object to an API that requires a dictionary instead of a JSON string. By converting the object to a dictionary, you can easily convert it to a JSON string using JSONSerialization and send it to the API.
 */
