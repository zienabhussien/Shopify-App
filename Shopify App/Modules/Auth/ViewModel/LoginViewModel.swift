//
//  LoginViewModel.swift
//  Shopify App
//
//  Created by Zienab on 04/03/2023.
//

import Foundation

class LoginViewModel{
    
    
    
    var bindResultToLoginView: (( Customers) -> Void)?
    
    var allCustomers : Customers!{
        didSet{
            bindResultToLoginView?(allCustomers)
            
        }
    }
    
    func getAllCustomers(){
        let strUrl = "https://b24cfe7f0d5cba8ddb793790aaefa12a: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@mad-ios-2.myshopify.com/admin/api/2023-01/customers.json"
        NetworkService.fetchFromApi(endPoint: EndPoints.Customers ){ [weak self] (data: Customers?) in
            
            guard let data = data else{ return}
            
            self?.allCustomers = data
            
        }
        
    }
    
    func searchCustomer(currEmail:String ,password: String ,allCustomers: Customers) -> Bool{
        
        for i in 0 ..< (allCustomers.customers.count){
            
            if currEmail == allCustomers.customers[i].email
                && allCustomers.customers[i].note == password {

                UserDefaults.standard.set(allCustomers.customers[i].id, forKey: "loginId")
                let userDefultId =  UserDefaults.standard.integer(forKey: "loginId")
              //  print("Customer Id IS : \(userDefultId )")
                
                
                return true
            }
        }
        return false
    }
    
}

