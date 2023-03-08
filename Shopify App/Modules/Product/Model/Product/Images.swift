//
//  BrandProductResponse.swift
//  Shopify App
//
//  Created by Ali Moustafa on 03/03/2023.
//

import Foundation
struct ProductImages : Codable {
	let id : Int?
	let product_id : Int?
	let position : Int?
	let created_at : String?
	let updated_at : String?
	let alt : String?
	let width : Int?
	let height : Int?
	let src : String?
	let variant_ids : [String]?
	let admin_graphql_api_id : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case product_id = "product_id"
		case position = "position"
		case created_at = "created_at"
		case updated_at = "updated_at"
		case alt = "alt"
		case width = "width"
		case height = "height"
		case src = "src"
		case variant_ids = "variant_ids"
		case admin_graphql_api_id = "admin_graphql_api_id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		product_id = try values.decodeIfPresent(Int.self, forKey: .product_id)
		position = try values.decodeIfPresent(Int.self, forKey: .position)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		alt = try values.decodeIfPresent(String.self, forKey: .alt)
		width = try values.decodeIfPresent(Int.self, forKey: .width)
		height = try values.decodeIfPresent(Int.self, forKey: .height)
		src = try values.decodeIfPresent(String.self, forKey: .src)
		variant_ids = try values.decodeIfPresent([String].self, forKey: .variant_ids)
		admin_graphql_api_id = try values.decodeIfPresent(String.self, forKey: .admin_graphql_api_id)
	}

}
