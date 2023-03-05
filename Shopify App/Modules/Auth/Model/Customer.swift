//
//  Customer.swift
//  Shopify App
//
//  Created by Zienab on 04/03/2023.
//

import Foundation

class AllCustomers : Decodable{
    
    let customers : [CustomerLogin]
}

struct CustomerLogin: Decodable {
    let id: Int
    let email: String
    let note: String?
   // let password: String?
    
}


