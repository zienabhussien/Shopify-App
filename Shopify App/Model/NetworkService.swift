//
//  NetworkService.swift
//  Shopify App
//
//  Created by Zienab on 04/03/2023.
//

import Foundation

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
            
//            let jsonData = try? JSONDecoder().decode(Customer.self, from: data!)
//            print(jsonData?.id)
//            debugPrint(jsonData!)
            
            if(data != nil && data?.count != 0){
//                let jsonData : CustomerResponse = try! JSONDecoder().decode(CustomerResponse.self, from: data!) as! CustomerResponse
//                print(jsonData.customer.id)
//                debugPrint(jsonData)
                let result = String(data: data!, encoding: .utf8)
                debugPrint(result!)
            }
            
        }.resume()
        
    }
    
    static func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = try! JSONEncoder().encode(body)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let responseObject = try decoder.decode(ResponseType.self, from: data)
                    DispatchQueue.main.async {
                        completion(responseObject, nil)
                    }
                } catch {
                    print(error)
                }
            }
            task.resume()
        }

}
