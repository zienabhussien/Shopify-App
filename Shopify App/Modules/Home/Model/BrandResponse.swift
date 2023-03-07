//
//  BrandResponse.swift
//  Shopify App
//
//  Created by Ali Moustafa on 03/03/2023.
//

import Foundation


// MARK: - BrandResponse
struct BrandResponse: Decodable {
    var smartCollections: [SmartCollection]

    enum CodingKeys: String, CodingKey {
        case smartCollections = "smart_collections"
    }

}

// MARK: - SmartCollection
struct SmartCollection: Decodable {
    var id: Int
    var handle, title: String
    var image: Image

    enum CodingKeys: String, CodingKey {
        case id, handle, title
        
        case image
    }

}

// MARK: - Image
struct Image: Decodable {
    var src: String

    enum CodingKeys: String, CodingKey {
        
        case src
    }
    
}


