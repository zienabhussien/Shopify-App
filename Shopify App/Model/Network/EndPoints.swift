//
//  EndPoints.swift
//  Shopify App
//
//  Created by Zienab on 06/03/2023.
//

import Foundation

enum EndPoints{
    case Customers
    case SingleProduct(id: Int)
    
    var path:String{
        switch self {
            
        case .Customers :
            return "customers.json"
        case .SingleProduct(id: let  productId) :
            return "products/\(productId).json"
        }
    }
}
