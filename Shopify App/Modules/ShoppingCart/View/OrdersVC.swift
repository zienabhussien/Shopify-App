//
//  OrdersVC.swift
//  Shopify App
//
//  Created by Ali Moustafa on 02/03/2023.
//

import UIKit

class OrdersVC: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var emptyCart: UIImageView!
    
    var cartArray : [OrderItemModel] = []
    let orderViewModel = OrderViewModel()
    var orderProduct : [OrderItem] = []
    var order = Order()
    let networking = Networking()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(OrdersTVC.nib(), forCellReuseIdentifier: OrdersTVC.identifier)
        setCartItems()
        setTotalPrice()
        checkCartIsEmpty()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkNetworking()
    }
    @IBAction func proccedToCheckout(_ sender: Any) {
        
        if cartArray.count == 0 {
            self.showAlertError(title: "Cart empty!", message: "There are no items to checkout.")
        }else{
            checkIsFoundAddress()
        }
    }
    
    func checkCartIsEmpty(){
        if cartArray.count == 0 {
            tableView.isHidden = true
            emptyCart.isHidden = false
        }
    }
    
    func retriveCartItems(){
        orderViewModel.getItemsInCart { cartItems, error in
            guard let items = cartItems else {return}
            self.cartArray = items
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setCartItems(){
        orderViewModel.getSelectedProducts { orders, error in
            guard let orders = orders else {return}
            self.cartArray = orders
            self.tableView.reloadData()
        }
    }
    
    func setTotalPrice(){
        orderViewModel.calcTotalPrice { totalPrice in
            guard let totalPrice = totalPrice else { return }
            Helper.shared.setTotalPrice(totalPrice:totalPrice)
            if UserDefaults.standard.string(forKey: "Currency") == "EGP" {
                self.totalPriceLabel.text = String(totalPrice) + " EGP"
             } else {
                 self.totalPriceLabel.text = "$" + String(totalPrice)
             }
        }
    }
}


extension OrdersVC{
    func checkNetworking(){
        Helper.shared.checkNetworkConnectionUsingRechability { isConnected in
            if !isConnected{
                self.tableView.isHidden = true
                self.emptyCart.isHidden = true
                //self.noInternetimageView.isHidden = false
                self.showAlertForInterNetConnection()
            }else{
                self.emptyCart.isHidden = false
                self.tableView.isHidden = false
                //self.noInternetimageView.isHidden = true
                self.setCartItems()
                self.setTotalPrice()
                self.checkCartIsEmpty()
                self.tableView.reloadData()
            }
        }
    }
}

extension OrdersVC{
    func checkIsFoundAddress(){
        if Helper.shared.checkFoundAdress() {
            goToSelectedAddress()
        }else{
            goToCreateAddress()
        }
    }
}
extension OrdersVC{
    func goToCreateAddress(){
        let createAddressVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateAddressVC") as! CreateAddressVC
        createAddressVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(createAddressVC, animated: true)
    }
    
    func goToSelectedAddress(){
        let addressVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddressVC") as! AddressVC
        addressVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(addressVC, animated: true)
    }
}
