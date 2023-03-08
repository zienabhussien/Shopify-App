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
        
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        self.navigationController?.pushViewController(homeVC, animated: true)
        
//        let doneVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//        present(doneVC, animated: true, completion: nil)
    }
   

}




