//
//  AddressViewModel.swift
//  Shopify
//
//  Created by Ali Moustafa on 01/03/2023.
//

import Foundation

class AddressViewModel{
    var userID = Helper.shared.getUserID()!
    let networking = Networking()
    let coreDataServices = CoreDataServices()
    
    var bindSuccessToView: (()->()) = {}
    var address: [Address]! {
        didSet{
            self.bindSuccessToView()
        }
    }
    
    var bindFailedToView: (()->()) = {}
    var error: Error!{
        didSet{
            self.bindFailedToView()
        }
    }
    
    init(){
    }
    
    func getAllAddressForCustomer(){
        networking.getAllAddresses { arrOfAdderess, error in
            guard let arrOfAdderess = arrOfAdderess, error == nil else {
                self.error = error
                return
            }
            self.address = arrOfAdderess
        }
    }
    
      func deleteFromApi(addressId : Int){
        if let path = URLs.shared.deleteAddress(customerID: userID, addressID: addressId){
            print(path)
            var urlRequst = URLRequest(url: path)
            urlRequst.httpMethod = "DELETE"
            urlRequst.httpShouldHandleCookies = false
            URLSession.shared.dataTask(with: urlRequst){ (data,response, error)  in
                if let data = data {
                    let result = String(data: data, encoding: .utf8)
                    debugPrint(result!)
                }
           }.resume()
         }
        }
    
    func saveSelectedAddress(){
        coreDataServices.saveToCoreData { saveSuccess in
            if saveSuccess{
                //print("success to save address")
            }else{
               // print("failed to save address")
            }
        }
    }
}
