

import Foundation
struct Variants : Codable {
	let id : Int?
	let product_id : Int?
	let title : String?
	let price : String?


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
