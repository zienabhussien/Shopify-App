//
//  ProductViewModel .swift
//  Shopify App
//
//  Created by Ali Moustafa on 10/03/2023.
//

import Foundation


import Alamofire
import Foundation

class ProductViewModel {
    var productOBbrandsModel : Products?     //variable to response data
    var filteredProducts : [Product]? = [Product]()
    var SmartCollectionID: String = ""

    
    func viewDidLoad(){
        fetchData()
    }
    
    var didFetchData: (()->())?
    
    func fetchData(){
   
        guard let url = URL(string: "https://b24cfe7f0d5cba8ddb793790aaefa12a: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@mad-ios-2.myshopify.com/admin/api/2023-01/products.json?collection_id=\(SmartCollectionID)") else {return}
        
        AF.request(url).response {[weak self] response in
            guard let self = self  else {return}
            if let data = response.data {
                do{
                    
                    let product = try JSONDecoder().decode(Products.self, from: data)
                    self.productOBbrandsModel = product
                    self.filteredProducts = product.products
                    self.didFetchData?()
                }
                catch let error{
                    print(error.localizedDescription)
                }
            } else {
            }
        }
    }
}


           




