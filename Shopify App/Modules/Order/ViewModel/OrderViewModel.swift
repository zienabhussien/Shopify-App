//
//  OrderViewModel.swift
//  Shopify App
//
//  Created by Ali Moustafa on 07/03/2023.
//

import Foundation
import CoreMedia
import Toast_Swift
class OrderViewModel{
    
    let coreDataServices = CoreDataServices()
    var bindingAlreadyInCartToView : (()->()) = {}
    var bindingDeleteCartToView : (()->()) = {}
    var bindingEmptyCartAlert : (()->()) = {}
    var order : OrderItem?
    let customerID = Helper.shared.getUserID()
    var orderProduct : [OrderItem] = []
    var totalOrder = Order()
    let networking = Networking()
    
    var showAlreadyExist : (()->()) {
        self.bindingAlreadyInCartToView
    }
    var showDeleteAlert : (()->()) {
        self.bindingDeleteCartToView
    }
    var showEmptyCartAlert : (()->()) {
        self.bindingEmptyCartAlert
    }
    
    
    func getItemsInCart(complition: @escaping (([OrderItemModel]?,Error?)->Void)){
        do {
            let cartItems = try context.fetch(OrderItemModel.fetchRequest())
            complition(cartItems, nil)
            
        } catch let error {
            complition(nil, error)
        }
    }
    
    // function to save item in core data
    func addItemsToCart(product:Product){
        do {
            let items = try context.fetch(OrderItemModel.fetchRequest())
            if checkIfItemExist(itemId: product.id!,itemms: items){
                print("Already in cart")
                self.showAlreadyExist()
            }else{
                //make object from core data
                let orderItem = OrderItemModel(context: context)
                // set value from data to core data
                orderItem.itemID = Int64(product.id!)
                orderItem.itemName = product.title
                orderItem.itemPrice = product.variants![0].price
                orderItem.itemImage = product.image?.src
                orderItem.itemQuantity = 1
                orderItem.userID = Int64(customerID!)
                try? context.save()
                print(orderItem)
            }
        } catch let error {
            print(error)
        }
    }
    
    func checkIfItemExist(itemId: Int,itemms:[OrderItemModel]) -> Bool {
        var check : Bool = false
        for i in itemms {
            if i.itemID == itemId {
                check = true
            }else {
                check = false
            }
        }
        return check
    }
    
    func deleteFromCoreData(indexPath:IndexPath,cartItems:[OrderItemModel]){
        context.delete(cartItems[indexPath.row])
        try? context.save()
    }
}

extension OrderViewModel{
    func getSelectedItemInCart(productId: Int64, completion: @escaping (OrderItemModel?, Error?)-> Void){
        getItemsInCart { orders, error in
            if error == nil {
                guard let orders = orders, let customerID = self.customerID else { return }
                for item in orders {
                    if item.itemID == productId && item.userID == customerID {
                        completion(item, nil)
                    }
                }
            }else{
                completion(nil, error)
            }
        }
    }
}

extension OrderViewModel{
    func getSelectedProducts(completion: @escaping ([OrderItemModel]?, Error?) -> Void){
        guard let customerID = Helper.shared.getUserID() else {return}
        coreDataServices.getCartProductForSelectedCustomer(customerID: customerID) { orders, error in
            guard let orders = orders, error == nil else {
                completion(nil, error)
                return
            }
            completion(orders, nil)
        }
    }
}

extension OrderViewModel{
    func saveProductToCart(){
        coreDataServices.saveToCoreData { saveSuccess in
            if saveSuccess{
                print("success to save product in cart")
            }else{
                print("failed to save product in cart")
            }
        }
    }
}

extension OrderViewModel{
    func calcTotalPrice(completion: @escaping (Double?)-> Void){
        var totalPrice: Double = 0.0
        getItemsInCart { orders, error in
            if error == nil {
                guard let orders = orders, let customerID = self.customerID  else { return }
                for item in orders{
                    if item.userID == customerID {
                        guard let priceStr = item.itemPrice, let price = Double(priceStr) else { return }
                        totalPrice += Double(item.itemQuantity) * price
                    }
                }
                Helper.shared.setTotalPrice(totalPrice: totalPrice)
                completion(totalPrice)
            }else{
                completion(nil)
            }
        }
    }
}

extension OrderViewModel{
    
    func getCustomer(completion: @escaping (Customer?)-> Void){
        networking.getAllCustomers { customers, error in
            guard let customers = customers, error == nil,let customerID = Helper.shared.getUserID() else {return}
            
            let filetr = customers.customers.filter { selectedCustomer in
                return selectedCustomer.id == customerID
            }
            if filetr.count != 0{
                print(filetr.count)
                completion(filetr[0])
            }else{
                completion(nil)
            }
        }
    }
}

//MARK: - post an order
extension OrderViewModel{
    func postOrder(cartArray:[OrderItemModel]){
        if cartArray.count == 0 {
            self.showEmptyCartAlert()
        }
        else{
        for item in cartArray {
            orderProduct.append(OrderItem(variant_id: Int(item.itemID), quantity: Int(item.itemQuantity), name: item.itemName, price: item.itemPrice,title:item.itemName))
        }        
        self.calcTotalPrice { total in
            guard let total = total else {
                return
            }
            self.totalOrder.current_total_price = String(total)
        }
        self.getCustomer { customer in
            guard let customer = customer else {
                return
            }
            let order = Order(customer: customer, line_items: self.orderProduct, current_total_price: self.totalOrder.current_total_price)
            let ordertoAPI = OrderToAPI(order: order)
            //net work
            self.networking.SubmitOrder(order: ordertoAPI) { data, urlResponse, error in
                if error == nil {
                    print("Post order success")
                    if let data = data{
                                    let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String,Any>
                                    let returnedOrder = json["order"] as? Dictionary<String,Any>
                                    let returnedCustomer = returnedOrder?["customer"] as? Dictionary<String,Any>
                                    let id = returnedCustomer?["id"] as? Int ?? 0
                        print(json)
                        print("----------")
                        print(id)
                        
                        for i in cartArray {
                            context.delete(i)
                        }
                        try! context.save()
                        
                                }
                }else{
                    print(error?.localizedDescription)
                }
            }
        }
    }
    }
    
    
}
