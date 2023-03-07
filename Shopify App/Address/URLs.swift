//
//  URLs.swift
//  Shopify
//
//  Created by Ali Moustafa on 01/03/2023.
//

import Foundation

struct URLs{
    
    static let shared = URLs()

    let baseURL = "https://b24cfe7f0d5cba8ddb793790aaefa12a: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@mad-ios-2.myshopify.com/admin/api/2023-01/"
    
    func getAllBrandsURl()-> URL?{
        return URL(string: baseURL + "smart_collections.json")
    }
    
    func getAllProductsInCategories()-> URL?{
        return URL(string: baseURL + "products.json")
    }
    
    func getAllCustomCollections()-> URL?{
        return URL(string: baseURL + "custom_collections.json")
    }
    
    func filterProductsByMainCategory(collectionId : Int)-> URL?{
        return URL(string: baseURL + "products.json?collection_id=\(collectionId)")
    }
    
    func customersURl()-> URL?{
        return URL(string: baseURL + "customers.json")
    }
    func ordersURL()->URL?{
        return URL(string: baseURL + "orders.json")
    }
    
    func allProducts()-> URL?{
        return URL(string: baseURL + "products.json")
    }
// MARK: - addAddressToCustomer API
    func addAddressToCustomer(id: String) -> URL? {
        return URL(string: baseURL + "customers/\(id).json")
    }
    
    func getAddressForCustomer(customerID: String) -> URL? {
        return URL(string: baseURL + "customers/\(customerID)/addresses.json")
    }
    
    func getOrdersUser(customerId:Int)->URL?{
        return URL(string: baseURL + "customers/\(customerId)/orders.json")
    }
    
    func setDefaultAddress (customerID: Int, addressID: Int) -> URL?{
        return URL(string: baseURL + "customers/\(customerID)/addresses/\(addressID)/default.json")
    }
}
