//
//  Customer.swift
//  Shopify App
//
//  Created by Ali Moustafa on 06/03/2023.
//
//MARK: - use in addresses
import Foundation

struct NewCustomer: Codable {
    let customer: Customer
}

struct Customers: Codable {
    let customers: [Customer]
}

struct Customer: Codable {
    let first_name, last_name, email, phone, tags: String?
    let id: Int?
    let note: String?
    let verified_email: Bool?
    let addresses: [Address]?
}

struct LoginResponse: Codable {
    let customers: [Customer]
}

// MARK: - address i fill it from Text Filed
struct Address: Codable {
    var address1, city, province, phone: String?
    var zip, last_name, first_name, country: String?
    let id: Int?
}
// MARK: - Araay of address
struct CustomerAddress: Codable {
    var addresses: [Address]?
}
// MARK: - the object i will send to server
struct PutAddress: Codable {
    let customer: CustomerAddress?
}


struct UpdateAddress: Codable {
    var address: Address
}

