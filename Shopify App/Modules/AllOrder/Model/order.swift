//
//  order.swift
//  Shopify App
//
//  Created by Ali Moustafa on 07/03/2023.
//

import Foundation

struct OrderItem : Codable{
    var variant_id : Int?
    var quantity:Int?
    var name:String?
    var price:String?
    var title:String?
}

struct Order : Codable{
    var id:Int?
    var customer:Customer?
    var line_items:[OrderItem]?
    var created_at:String?
    var financial_status: String = "paid"
    var current_total_price:String?

}

struct OrderToAPI : Codable{
    var order : Order
}

struct OrdersFromAPI : Codable {
    var orders : [Order]
}
