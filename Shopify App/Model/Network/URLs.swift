//
//  URLs.swift
//  Shopify App
//
//  Created by Ali Moustafa on 03/03/2023.
//

import Foundation

struct URLs{
    
    static let shared = URLs()

    let baseURL = "https://b24cfe7f0d5cba8ddb793790aaefa12a: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@mad-ios-2.myshopify.com/admin/api/2023-01/"
    
    func customersURl()-> URL?{
        return URL(string: baseURL + "customers.json")
    }
    func ordersURL()->URL?{
        return URL(string: baseURL + "orders.json")
    }
    

// MARK: - addAddressToCustomer API
    func addAddressToCustomer(id: String) -> URL? {
        return URL(string: baseURL + "customers/\(id).json")
    }
    
    func setDefaultAddress (customerID: Int, addressID: Int) -> URL?{
        return URL(string: baseURL + "customers/\(customerID)/addresses/\(addressID)/default.json")
    }
    func deleteAddress (customerID: Int, addressID: Int) -> URL?{
        return URL(string: baseURL + "customers/\(customerID)/addresses/\(addressID).json")
    }
    
}
