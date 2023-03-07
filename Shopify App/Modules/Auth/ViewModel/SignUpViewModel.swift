//
//  SignUpViewModel.swift
//  Shopify App
//
//  Created by Zienab on 04/03/2023.
//

import Foundation

class SignupViewModel{
    
    var bindResToSignUp: (() -> ()) = {}
    
    var statusCode : Int! {
        didSet{
            
            bindResToSignUp()
        }
    }
    
//    func createCustomer(name: String, email: String, password: String){
//        NetworkService.postCustomer(name: name, email: email, password: password)
//    }
    
    
    func postCustomer(params: [String: Any]){
        NetworkService.postData(endPoint: EndPoints.Customers, params: params) { [weak self] (data: (CustomerResponse?),error, status) in
            print("status : \(status)")
            self?.statusCode = status
            
            
            
        }
    }
    
    
    
}
