//
//  CustomerExtension.swift
//  Shopify App
//
//  Created by Dragon on 12/03/2023.
//

import Foundation
extension Customer {
   
    func isValidFirstName() -> Bool{
        return first_name?.count ?? 0 > 1
    }
    
    func isValidLastName() -> Bool{
        return last_name?.count ?? 0 > 1
    }
    func isValidEmail() -> Bool{
        return email?.count ?? 0 > 1
    }
    func isValidPassword() -> Bool{
        return note?.count ?? 0 >= 5
    }
    
    func isDataValid() -> Bool{
        return  isValidFirstName() && isValidEmail() && isValidPassword()
    }
    
}
