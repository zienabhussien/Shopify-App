
//  CoreDataServices.swift
//  Shopify App
//
//  Created by Ali Moustafa on 06/03/2023.


import Foundation
import CoreData

class CoreDataServices{
    func saveToCoreData(completion: @escaping (Bool)-> Void){
        do{
            try context.save()
            completion(true)
        }catch{
            print("Error in saveProductToWishList", error.localizedDescription)
            completion(false)
        }
    }
}

extension CoreDataServices{
    func getCartProductForSelectedCustomer(customerID: Int, completion: @escaping ([OrderItemModel]?, Error?)-> Void){
        do{
//            fetch all OrderItemModel objects using the context property
            let productCart = try context.fetch(OrderItemModel.fetchRequest())
            var selectedCart: [OrderItemModel] = [] // to get one object from core data
            for selectedCustomer in productCart{
                if selectedCustomer.userID == customerID{
                    selectedCart.append(selectedCustomer)
                }
            }
            completion(selectedCart, nil)
       }catch{
           completion(nil, error)
            print("Error in getAllCartProduct function: ", error.localizedDescription)
        }
    }
}

