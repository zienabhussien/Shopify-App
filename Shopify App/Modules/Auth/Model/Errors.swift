//
//  Errors.swift
//  Shopify App
//
//  Created by Zienab on 05/03/2023.
//

import Foundation

struct ErrorResponse: Codable{
   let errors : ErrorMessage?
}

// MARK: - Customer
struct ErrorMessage: Codable {
    let email: [String]?
    let password: [String]?
    let password_confirmation: [String]?
}
