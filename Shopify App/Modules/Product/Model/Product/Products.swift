//
//  BrandProductResponse.swift
//  Shopify App
//
//  Created by Ali Moustafa on 03/03/2023.
//

import Foundation
struct Products : Codable {
	let products : [Product]?

	enum CodingKeys: String, CodingKey {

		case products = "products"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		products = try values.decodeIfPresent([Product].self, forKey: .products)
	}

}
