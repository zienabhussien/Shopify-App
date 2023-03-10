//
//  HomeViewModel .swift
//  Shopify App
//
//  Created by Ali Moustafa on 10/03/2023.
//
import Alamofire
import Foundation

class HomeViewModel {
    var brandsModel : BrandModel?     //variable to response data
    var filteredBrands =  [SmartCollection]()
    
    func viewDidLoad(){
        fetchData()
        
    }
    
    var didFetchData: (()->())?
    
    
    
    
    
    
    func fetchData(){
   
        guard let url = URL(string: "https://b24cfe7f0d5cba8ddb793790aaefa12a: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@mad-ios-2.myshopify.com/admin/api/2023-01/smart_collections.json") else {return}
        
        AF.request(url).response {[weak self] response in
            guard let self = self  else {return}
            if let data = response.data {
                do{
                    
                    let Brand = try JSONDecoder().decode(BrandModel.self, from: data)
                    self.brandsModel = Brand
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


           
