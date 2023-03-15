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

    
    @IBOutlet weak var shippingFess: UILabel!
    @IBOutlet weak var grandTotal: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var couponTF: CouponTextField!
    var placedOrders = [OrderItemModel]()    //variable to response product in cart from core data
    var orderViewModel = OrderViewModel()
    var Total = 0.0
//order
    override func viewDidLoad() {
        super.viewDidLoad()
        setCartItems()
        guard let totalPrice = Helper.shared.getTotalPrice() else{return}
        if UserDefaults.standard.string(forKey: "Currency") == "EGP" {
            subTotalLabel.text = String(totalPrice * 30) + " EGP"
            shippingFess.text = "900.0 EGP"
            discountLabel.text = "-0.0 EGP"
         } else {
             subTotalLabel.text = "$" + String(totalPrice)
             shippingFess.text = "$30.0"
             discountLabel.text = "$-0.0"
         }
        calcGrandTotal()
    }
    
    @IBAction func validateCoupon(_ sender: Any) {
        if couponTF.textField.text == "IOS_ITI" {
            self.view.makeToast("Coupon applied")
            if UserDefaults.standard.string(forKey: "Currency") == "EGP" {
                discountLabel.text = "-600.0 EGP"
                grandTotal.text = String(Total - 600.0) + " EGP"
             } else {
                 discountLabel.text = "$-20.0 "
                 grandTotal.text =  "$" + String(Total - 20.0)
             }
        }else {
            self.view.makeToast("Coupon not valied")
            if UserDefaults.standard.string(forKey: "Currency") == "EGP" {
                discountLabel.text = "-0.0 EGP"
                grandTotal.text =  String(Total * 30) + " EGP"
             } else {
                 discountLabel.text = "$-0.0"
                 grandTotal.text = "$" + String(Total)
             }
        }
    }
    func calcGrandTotal(){
        guard let totalPrice = Helper.shared.getTotalPrice() else{return}
        if UserDefaults.standard.string(forKey: "Currency") == "EGP" {
            Total = totalPrice + 900

            grandTotal.text =  String(Total * 30) + " EGP"
         } else {
             Total = totalPrice + 30
             grandTotal.text = "$" + String(Total)
         }
    }
    
    //    MARK: - place Order

    func setCartItems(){
        orderViewModel.getSelectedProducts { orders, error in
            // return product
            guard let orders = orders else {return}
            self.placedOrders = orders
        }
    }
    //MARK: - post in server

    @IBAction func placeOrder(_ sender: Any) {
        
        let alert = UIAlertController(title: "Order done", message: "Thank you for your order!", preferredStyle: .actionSheet)
        
        let okAction = UIAlertAction(title: "OK", style: .destructive) { UIAlertAction in
            self.orderViewModel.postOrder(cartArray: self.placedOrders)
            self.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}




