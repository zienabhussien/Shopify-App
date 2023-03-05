//
//  NetworkService.swift
//  Shopify App
//
//  Created by Zienab on 04/03/2023.
//

import Foundation
import Alamofire
protocol Service{
    static func postCustomer(name: String,email: String , password: String)
}

class NetworkService : Service{
    
    static  func postCustomer(name: String,email: String , password: String){
        let params: [String : Any] = [
            "customer":[
                "first_name": name,
                "email" :email,
                "password": password,
                "password_confirmation":password ]]
        
        
        
        let url = URL(string: "https://a546963db1d86b6cdc7f01928132e7f7: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@mad-4-ism2023.myshopify.com/admin/api/2023-01/customers.json" )
        
        var urlRequst = URLRequest(url: url!)
        urlRequst.httpMethod = "post"
        urlRequst.httpShouldHandleCookies = false
        
        do{
            let requestBody = try JSONSerialization.data(withJSONObject: params,options: .prettyPrinted)
            urlRequst.httpBody = requestBody
            urlRequst.addValue("application/Json", forHTTPHeaderField: "content-type")
            
        }catch let error{
            debugPrint(error.localizedDescription)
        }
        
        URLSession.shared.dataTask(with: urlRequst){ (data,response, error)  in
            
            if let data = data {
                do {
                    // Try decoding your data to your model
                    let jsonData = try JSONDecoder().decode(CustomerResponse.self, from: data)
                    print(jsonData)
                   
                }
                catch {
                    print(error)
                }
            }
     
            
        }.resume()
        
    }
    
    static func fetchFromApi<T: Decodable>( API_URL: String, complition: @escaping (T? ) -> Void)  {
        AF.request(API_URL).responseJSON { response in
            do
            {
                
                guard let responseData = response.data else {return}
                let result = try JSONDecoder().decode(T.self, from: responseData)
                print(result)
                complition(result)
                
            }catch let error {
                complition(nil )
                print(error.localizedDescription)
                
            }
        }
    }

}
