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

    
    @IBOutlet weak var grandTotal: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var couponTF: CouponTextField!
    //order
    var placedOrders = [OrderItemModel]()
    var orderViewModel = OrderViewModel()
    var Total = 0.0
//order
    override func viewDidLoad() {
        super.viewDidLoad()
        setCartItems()
        guard let totalPrice = Helper.shared.getTotalPrice() else{return}
        subTotalLabel.text = "$" + String(totalPrice)
        calcGrandTotal()
    }
    
    @IBAction func validateCoupon(_ sender: Any) {
        if couponTF.textField.text == "iOS_iTi" {
            self.view.makeToast("Coupon applied")
            discountLabel.text = "$20.0"
            grandTotal.text = "$" + String(Total - 20.0)
        }else {
            self.view.makeToast("Coupon not valied")
            discountLabel.text = "$0.0"
            grandTotal.text = "$" + String(Total)
        }
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
    func calcGrandTotal(){
        guard let totalPrice = Helper.shared.getTotalPrice() else{return}
        Total = totalPrice + 30
        grandTotal.text = "$" + String(Total)
    }
}




