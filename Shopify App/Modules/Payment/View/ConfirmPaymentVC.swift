//
//  ConfirmPaymentVC.swift
//  Shopify App
//
//  Created by Zienab on 01/03/2023.
//

import UIKit
import CoreData
class ConfirmPaymentVC: UIViewController {

    //order
    var placedOrders = [OrderItemModel]()
    var orderViewModel = OrderViewModel()
//order
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func placeOrder(_ sender: Any) {
        
        orderViewModel.postOrder(cartArray: placedOrders)
        let doneVC = UIStoryboard(name: "Done", bundle: nil).instantiateViewController(withIdentifier: "SingUpViewController") as! SingUpViewController
        present(doneVC, animated: true, completion: nil)
        
        
    }
   

}




