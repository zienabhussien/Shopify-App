//
//  ProductViewModel .swift
//  Shopify App
//
//  Created by Ali Moustafa on 10/03/2023.
//

import Alamofire
import Foundation

class CategoryViewModel {
    var subCategoriesNamesModel : subCatecoryResponse?     //variable .to response data
    var productOfbrandsCategoryModel : Products?     //variable to response data
    var FilterdArr: [Product]? = [Product]()
    
    func viewDidLoad(){
        fetchCollections()
        fetchProduct()
    }
    
    var didFetchData: (()->())?
    var didFetchDatapro: (()->())?
    
    
    func fetchCollections() {
        
        guard let url = URL(string: "https://b24cfe7f0d5cba8ddb793790aaefa12a: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@mad-ios-2.myshopify.com/admin/api/2023-01/custom_collections.json") else {return}
        
        AF.request(url).response {[weak self] response in
            guard let self = self  else {return}
            if let data = response.data {
                do{
                    
                    let category = try JSONDecoder().decode(subCatecoryResponse.self, from: data)
                    self.subCategoriesNamesModel = category
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



extension CategoryViewModel{
    func fetchProduct(id: String = ""){
        let path = "?collection_id=\(id)"
        var url = URL(string: "https://b24cfe7f0d5cba8ddb793790aaefa12a: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@mad-ios-2.myshopify.com/admin/api/2023-01/products.json\(path)")
        if id == "" {
            url = URL(string: "https://b24cfe7f0d5cba8ddb793790aaefa12a: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@mad-ios-2.myshopify.com/admin/api/2023-01/products.json")
        }
        
        AF.request(url!).response
        { response in
            if let data = response.data {
                do{
                    
                    let product = try JSONDecoder().decode(Products.self, from: data)
                    self.productOfbrandsCategoryModel = product
                    self.didFetchDatapro?()
                }
                catch let error{
                    print(error.localizedDescription)
                }
            } else {
            }
        }
    }
    
}





