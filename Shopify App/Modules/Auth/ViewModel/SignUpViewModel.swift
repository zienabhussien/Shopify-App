//
//  SignUpViewModel.swift
//  Shopify App
//
//  Created by Zienab on 04/03/2023.
//

import Foundation

class SignupViewModel{
    
    
    func createCustomer(name: String, email: String, password: String){
        NetworkService.postCustomer(name: name, email: email, password: password)
    }
    
    
    
    
}
