//
//  BrandProductResponse.swift
//  Shopify App
//
//  Created by Ali Moustafa on 03/03/2023.
//

import Foundation
struct Variants : Codable {
	var id : Int?
	var product_id : Int?
	var title : String?
	var price : String?


	enum CodingKeys: String, CodingKey {

		case id = "id"
		case product_id = "product_id"
		case title = "title"
		case price = "price"
		
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		product_id = try values.decodeIfPresent(Int.self, forKey: .product_id)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		price = try values.decodeIfPresent(String.self, forKey: .price)

	}

}
