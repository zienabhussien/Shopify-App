//
//  EndPoints.swift
//  Shopify App
//
//  Created by Zienab on 06/03/2023.
//

import Foundation

enum EndPoints{
    case Customers
    
    var path:String{
        switch self {
        case .Customers :
            return "customers.json"
        }
    }
}
