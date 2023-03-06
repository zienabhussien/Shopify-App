//
//  BrandProductResponse.swift
//  Shopify App
//
//  Created by Ali Moustafa on 03/03/2023.
//

import Foundation

// MARK: - ProductOfBrand
struct ProductOfBrand: Decodable {
    var products: [ProductOfBrands]
}

// MARK: - Product
struct ProductOfBrands: Decodable {
    var id: Int
    var title, vendor, productType: String
    var tags: String
    var variants: [Variant]
    var images: [Image]
    var image: SingleImage

    enum CodingKeys: String, CodingKey {
        case id, title
        case productType = "product_type"
        case vendor
        case tags
        case variants, images, image
    }
}

// MARK: - Image
struct SingleImage: Decodable {
    var src: String

    enum CodingKeys: String, CodingKey {
        case src
       
    }
}


// MARK: - Variant
struct Variant: Decodable {
    var id, productID: Int
    var title, price: String //price
    

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case title, price
    }
}
