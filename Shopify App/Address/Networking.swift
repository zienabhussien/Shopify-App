//
//  Networking.swift
//  Shopify
//
//  Created by Ali Moustafa on 01/03/2023.
//

import Foundation
import Alamofire
import SwiftUI

class Networking{
    
    static var shared = Networking()
}


extension Networking{
    func register(newCustomer:NewCustomer, completion:@escaping (Data?, URLResponse? , Error?)->()){
        guard let url = URLs.shared.customersURl() else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let session = URLSession.shared
        request.httpShouldHandleCookies = false
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: newCustomer.asDictionary(), options: .prettyPrinted)
            print(try! newCustomer.asDictionary())
        } catch let error {
            print(error.localizedDescription)
        }
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }.resume()
    }
}

extension Networking{
    func getAllCustomers(complition: @escaping (Customers?, Error?)->Void){
        guard let url = URLs.shared.customersURl() else {return}
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response { res in
            switch res.result{
            case .failure(let error):
                print("error")
                complition(nil, error)
            case .success(_):
                guard let data = res.data else { return }
                do{
                    let json = try JSONDecoder().decode(Customers.self, from: data)
                    complition(json, nil)
                    print("success to get customers")
                }catch let error{
                    print("error when get customers")
                    complition(nil, error)
                }
            }
        }
    }
    
    
}



extension Networking{
    func getAllAddresses(completion: @escaping ([Address]?, Error?)-> Void){
        guard let customerID = Helper.shared.getUserID() else {return}
        
        guard let url = URLs.shared.customersURl() else {return}
        AF.request(url, method: .get,parameters: nil,encoding: JSONEncoding.default,headers: nil).response { res in
            switch res.result{
            case.failure(let error):
                print(error.localizedDescription)
                completion(nil,error)
            case .success(_):
                guard let data = res.data else { return }
                do{
                    let json = try JSONDecoder().decode(Customers.self, from: data)
                    for selectedCustomer in json.customers{
                        if selectedCustomer.id == customerID {
                            completion(selectedCustomer.addresses, nil)
                        }
                    }
                    print("success to get address for a customers")
                }catch let error{
                    print("error when get address for a customers")
                    completion(nil, error)
                }
            }
        }
    }
}

extension Networking{
    
    func setDefaultAddress(customerId: Int, addressId: Int, address: Address, completion: @escaping(Data?, URLResponse?, Error?)->()){
        let customer = CustomerAddress(addresses: [address])
        let putObject = PutAddress(customer: customer)
        guard let url = URLs.shared.setDefaultAddress(customerID: customerId, addressID: addressId) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        let session = URLSession.shared
        request.httpShouldHandleCookies = false
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: putObject.asDictionary(), options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }.resume()
    }
}

extension Networking{
    
    
    func createAddress(customerId: Int, address: Address, completion: @escaping(Data?, URLResponse?, Error?)->()){
        let customer = CustomerAddress(addresses: [address])
        let putObject = PutAddress(customer: customer)
        guard let url = URLs.shared.addAddressToCustomer(id: "\(customerId)") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        let session = URLSession.shared
        request.httpShouldHandleCookies = false
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: putObject.asDictionary(), options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }.resume()
    }

}


//MARK: - POST an order
extension Networking{
    
    func SubmitOrder(order:OrderToAPI,completion: @escaping (Data?,URLResponse?,Error?)->Void){
        guard let url = URLs.shared.ordersURL() else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let session = URLSession.shared
        request.httpShouldHandleCookies = false
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: order.asDictionary(), options: .prettyPrinted)
            print(try! order.asDictionary())
        }catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        session.dataTask(with: request) { (data,response,error) in
            completion(data, response, error)
        }.resume()
    }
}
