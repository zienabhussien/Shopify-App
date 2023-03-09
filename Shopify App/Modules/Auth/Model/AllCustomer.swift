//
//  AllCustomer.swift
//  Shopify App
//
//  Created by Dragon on 07/03/2023.
//

import Foundation

class AllCustomers : Decodable{
    
    let customers : [CustomerLogin]
}

struct CustomerLogin: Decodable {
    let id: Int
    let email: String
    let note: String?
    
    
}
