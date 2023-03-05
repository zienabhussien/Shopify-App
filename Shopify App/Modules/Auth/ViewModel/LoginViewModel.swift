//
//  LoginViewModel.swift
//  Shopify App
//
//  Created by Zienab on 04/03/2023.
//

import Foundation

class LoginViewModel{
    

        
        var bindResultToLoginView: (( AllCustomers) -> Void)?
        
        var allCustomers : AllCustomers!{
            didSet{
                bindResultToLoginView?(allCustomers)
                
            }
        }
        
        func getAllCustomers(){
            let strUrl = "https://a546963db1d86b6cdc7f01928132e7f7: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@mad-4-ism2023.myshopify.com/admin/api/2023-01/customers.json"
            NetworkService.fetchFromApi(API_URL: strUrl) { [weak self] (data: AllCustomers?) in
                
                guard let data = data else{ return}
                self?.allCustomers = data
                
            }
            
        }
        
        func searchCustomer(currEmail:String , allCustomers: AllCustomers) -> Bool{
            
            for i in 0 ..< (allCustomers.customers.count){
                
                if currEmail == allCustomers.customers[i].email  {
                    return true
                }
                
            }
            return false
        }
        
    }

