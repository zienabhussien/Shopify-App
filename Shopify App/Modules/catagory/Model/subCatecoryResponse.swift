//
//  subCatecoryResponse.swift
//  Shopify App
//
//  Created by Ali Moustafa on 03/03/2023.
//

import Foundation

// MARK: - subCatecoryResponse
struct subCatecoryResponse: Decodable {
    let customCollections: [CustomCollection]

    enum CodingKeys: String, CodingKey {
        case customCollections = "custom_collections"
    }
}

// MARK: - CustomCollection
struct CustomCollection: Decodable {
    let id: Int
    let handle, title: String

    enum CodingKeys: String, CodingKey {
        case id, handle, title
    }
}


