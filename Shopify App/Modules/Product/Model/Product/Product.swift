//
//  BrandProductResponse.swift
//  Shopify App
//
//  Created by Ali Moustafa on 03/03/2023.
//

import Foundation
struct Product : Codable {
	var id : Int?
	var title : String
    var body_html : String?
    var vendor : String?
    var product_type : String?
    var variants : [Variants]?
    var images : [ProductImages]?
    var image : ProductImage?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case title = "title"
		case body_html = "body_html"
		case vendor = "vendor"
		case product_type = "product_type"
		case variants = "variants"
		case images = "images"
		case image = "image"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
		body_html = try values.decodeIfPresent(String.self, forKey: .body_html)
		vendor = try values.decodeIfPresent(String.self, forKey: .vendor)
		product_type = try values.decodeIfPresent(String.self, forKey: .product_type)
		variants = try values.decodeIfPresent([Variants].self, forKey: .variants)
		images = try values.decodeIfPresent([ProductImages].self, forKey: .images)
		image = try values.decodeIfPresent(ProductImage.self, forKey: .image)
	}

}
