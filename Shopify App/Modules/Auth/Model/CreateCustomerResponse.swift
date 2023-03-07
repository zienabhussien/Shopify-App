//
//  CreateCustomer.swift
//  Shopify App
//
//  Created by Zienab on 03/03/2023.
//


import Foundation
struct CustomerResponse: Codable{
   let customer : Customerr?
}
// MARK: - Customer
struct Customerr: Codable {
    let firstName : String?
    let lastName : String?
    let email : String
    
    let id: Int?
    let verifiedEmail: Bool
    let addresses: [Addresss]
    let note: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case email, id, note
        case verifiedEmail = "verified_email"
        case addresses
    }
    
    
}

// MARK: - Address
struct Addresss: Codable {
    let address1, city, province, phone: String
    let zip, lastName, firstName, country: String

    enum CodingKeys: String, CodingKey {
        case address1, city, province, phone, zip
        case lastName = "last_name"
        case firstName = "first_name"
        case country
    }
}
