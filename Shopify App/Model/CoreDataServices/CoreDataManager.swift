//
//  CoreDataManager.swift
//  Shopify App
//
//  Created by Zienab on 08/03/2023.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager
{
    static var context : NSManagedObjectContext?
    static var appDelegate : AppDelegate?
    
    
    static func saveProductToCoreData(productName : String , productPrice : String, productImage: String , productId : Int)
    {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        context = appDelegate?.persistentContainer.viewContext
        
        guard let myContext = context else{return}
        
        let entity = NSEntityDescription.entity(forEntityName: "WishListModel", in: myContext)
        
        guard let myEntity = entity else{return}
        
        do{
            
            
            let favProduct = NSManagedObject(entity: myEntity, insertInto: myContext)
               
            favProduct.setValue(productId, forKey: "productID")
            favProduct.setValue(productName, forKey: "productName")
            favProduct.setValue(productPrice, forKey: "productPrice")
            favProduct.setValue(productImage, forKey: "productImage")
            
            print("Saved Successfully")
            
            
            try myContext.save()
            
        }catch let error{
            
            print(error.localizedDescription)
        }
    }
    
    
    static func deleteFromCoreData( productName :String)
    {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        context = appDelegate?.persistentContainer.viewContext
        
        do{
            let fetch = NSFetchRequest<NSManagedObject>(entityName: "WishListModel")
            let predictt = NSPredicate(format: "productName == %@",productName)
            fetch.predicate = predictt
            
            let favProducts = try context?.fetch(fetch)
            
            guard let item = favProducts else {return}
            guard let itemFirst = item.first else {return}
            
             context?.delete(itemFirst)
            
            try context?.save()
            
            print("Deleted Succussfully")
            
        }catch let error
        {
            print(error.localizedDescription)
        }
    }
    
    static func fetchFromCoreData() ->[FavoriteProduct]
    {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        context = appDelegate?.persistentContainer.viewContext
        
        
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "WishListModel")
        
        var arrayOfFavProduct : [FavoriteProduct] = []
        
        do{
            
            
            
            let favProducts = try context?.fetch(fetch)
            
            guard let favItems = favProducts else{return []}
            
            for item in favItems
            {
                var productName = item.value(forKey: "productName")
                var productPrice = item.value(forKey: "productPrice")
                var productImage = item.value(forKey: "productImage")
                var productId = item.value(forKey: "productID")

                var product = FavoriteProduct(productId: productId as? Int, productImage: productImage as? String, productName: productName as? String, productPrice: productPrice as? String)
            
                arrayOfFavProduct.append(product)
            }
            
        }catch let error
        {
            print(error.localizedDescription)
        }
        return arrayOfFavProduct
    }
    
}
