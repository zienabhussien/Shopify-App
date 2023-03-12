//
//  MeViewModel.swift
//  Shopify App
//
//  Created by Ali Moustafa on 11/03/2023.
//

import Alamofire
import Foundation




class MeViewModel {
    let userID = Helper.shared.getUserID()!
    var reponseOrsers : OrdersFromAPI!{
        didSet{
            didFetchData()
        }
    }

    
    func viewDidLoad(){
        fetchOrders()
    }
    
    var didFetchData: (()->()) = {
        
    }
    
    func fetchOrders(){

        guard let url = URL(string: "https://b24cfe7f0d5cba8ddb793790aaefa12a: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@mad-ios-2.myshopify.com/admin/api/2023-01/customers/\(userID)/orders.json") else {return}
       // print(url)
    
        AF.request(url).response {[weak self] response in
            guard let self = self  else {return}
            if let data = response.data {
                do{
                    
                    let result = try JSONDecoder().decode(OrdersFromAPI.self, from: data)
                    
                    self.reponseOrsers = result
                    
                }
                catch let error{
                    print(error.localizedDescription)
                }
            } else {
            }
        }
    }
    
    
    
    
}


