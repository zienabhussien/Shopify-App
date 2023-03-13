//
//  AddressViewModel.swift
//  Shopify
//
//  Created by Ali Moustafa on 01/03/2023.
//

import Foundation

class AddressViewModel{
    
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
