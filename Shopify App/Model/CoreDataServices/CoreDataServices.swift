
//  CoreDataServices.swift
//  Shopify
//
//  Created by Ali Moustafa on 01/03/2023.


import Foundation
import CoreData
import UIKit
import CoreMedia

class CoreDataServices{
}

extension CoreDataServices{
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
    func getAllWishListProduct(completion: @escaping ([WishListModel]?, Error?)-> Void){
        do{
            let productWishList = try context.fetch(WishListModel.fetchRequest())
            print("fetching data.....")
            completion(productWishList, nil)
       }catch{
           completion(nil, error)
            print("Error in getAllWishListProduct function: ", error.localizedDescription)
        }
    }
}

extension CoreDataServices{
    func getAddress(completion: @escaping (AddressModel?, Error?)-> Void){
        do{
            let addressModel = try context.fetch(AddressModel.fetchRequest())
            print("fetching data.....")
            completion(addressModel[0], nil)
        }catch{
            completion(nil, error)
            print("Error in getAddress function: ", error.localizedDescription)
        }
    }
}


extension CoreDataServices{
    func getWishListProductForSelectedCustomer(customerID: Int, completion: @escaping ([WishListModel]?, Error?)-> Void){
        do{
            let productWishList = try context.fetch(WishListModel.fetchRequest())
            var selectedWishList: [WishListModel] = []
            for selectedCustomer in productWishList{
                if selectedCustomer.customerID == customerID{
                    selectedWishList.append(selectedCustomer)
                }
            }
            completion(selectedWishList, nil)
       }catch{
           completion(nil, error)
            print("Error in getAllWishListProduct function: ", error.localizedDescription)
        }
    }
}

extension CoreDataServices{
    func getCartProductForSelectedCustomer(customerID: Int, completion: @escaping ([OrderItemModel]?, Error?)-> Void){
        do{
            let productCart = try context.fetch(OrderItemModel.fetchRequest())
            var selectedCart: [OrderItemModel] = []
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


extension CoreDataServices{
    func deletedSelectedProductFromWishList(product: WishListModel, complition: @escaping (Bool) -> Void){
        context.delete(product)
        do{
            try context.save()
            complition(true)
        }catch{
            print("Error when delete product from wish list: ", error.localizedDescription)
            complition(false)
        }
    }
}
