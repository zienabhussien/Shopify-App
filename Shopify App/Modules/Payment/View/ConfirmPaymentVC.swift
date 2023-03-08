//
//  ConfirmPaymentVC.swift
//  Shopify App
//
//  Created by Zienab on 01/03/2023.
//

import UIKit
import CoreData
import Toast_Swift

class ConfirmPaymentVC: UIViewController {

    @IBOutlet weak var subTotalLabel: UILabel!
    //order
    var placedOrders = [OrderItemModel]()
    var orderViewModel = OrderViewModel()
//order
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCartItems()
        guard let totalPrice = Helper.shared.getTotalPrice() else{return}
        subTotalLabel.text = String(totalPrice)
        
    }
    func setCartItems(){
        orderViewModel.getSelectedProducts { orders, error in
            guard let orders = orders else {return}
            self.placedOrders = orders
        }
    }

    @IBAction func placeOrder(_ sender: Any) {
        
        orderViewModel.postOrder(cartArray: placedOrders)
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
  

}




