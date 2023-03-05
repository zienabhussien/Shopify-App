//
//  CreateCustomer.swift
//  Shopify App
//
//  Created by Zienab on 03/03/2023.
//


import Foundation
struct CustomerResponse: Codable{
   let customer : Customer
}
// MARK: - Customer
struct Customer: Codable {
    let firstName : String?
    let lastName : String?
    let email : String?
    
    let id: Int?
    let verifiedEmail: Bool
    let addresses: [Address]

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case email, id
        case verifiedEmail = "verified_email"
        case addresses
    }
    
   
}

// MARK: - Address
struct Address: Codable {
    let address1, city, province, phone: String
    let zip, lastName, firstName, country: String

    enum CodingKeys: String, CodingKey {
        case address1, city, province, phone, zip
        case lastName = "last_name"
        case firstName = "first_name"
        case country
    }
}
