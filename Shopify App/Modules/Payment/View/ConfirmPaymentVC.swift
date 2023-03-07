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

        // Do any additional setup after loading the view.
    }
    

    @IBAction func placeOrder(_ sender: Any) {
        
        orderViewModel.postOrder(cartArray: placedOrders)
        let doneVC = UIStoryboard(name: "Done", bundle: nil).instantiateViewController(withIdentifier: "SingUpViewController") as! SingUpViewController
        present(doneVC, animated: true, completion: nil)
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}




