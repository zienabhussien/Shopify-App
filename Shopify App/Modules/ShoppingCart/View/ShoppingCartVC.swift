//
//  ShoppingCartVC.swift
//  Shopify App
//
//  Created by Ali Moustafa on 08/03/2023.
//

import UIKit

class ShoppingCartVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var subtotal: UILabel!
    @IBOutlet weak var checkOutBtn: UIButton!
    
    var products : [ProductCart] = []
    var totalprice = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
      products.append(ProductCart(image: UIImage(named: "download")!, quantity: 1, price: 10.0))
      products.append(ProductCart(image: UIImage(named: "1")!, quantity: 1, price: 20.0))
      products.append(ProductCart(image: UIImage(named: "download")!, quantity: 1, price: 30.0))
        updateSubtotal()
    }
    
    @IBAction func decreaseButtonTapped(_ sender: Any) {
        let product = products[(sender as AnyObject).tag]
                if product.quantity > 1 {
                    product.quantity -= 1
                    tableView.reloadData()
                    updateSubtotal()
                }
    }
    
    @IBAction func increaseButtonTapped(_ sender: Any) {
        let product = products[(sender as AnyObject).tag]
                product.quantity += 1
                tableView.reloadData()
                updateSubtotal()
    }
    
    @IBAction func proceedToCheckoutButton(_ sender: Any) {
        
        let AddressVC = storyboard?.instantiateViewController(withIdentifier: "ChooseAddressVC") as! ChooseAddressVC
//         AddressVC.subtotal = self.totalprice
        self.navigationController?.pushViewController(AddressVC, animated: true)
    }
}

extension ShoppingCartVC : UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCell", for: indexPath) as! ShoppingCartCell
        
        let product = products[indexPath.row]
                cell.productImg.image = product.image
                cell.quantityNumber.text = "\(product.quantity)"
                cell.productPrice.text = "\(product.price) EGP"
                
                cell.increaseQuantity.addTarget(self, action: #selector(increaseButtonTapped(_:)), for: .touchUpInside)
                cell.increaseQuantity.tag = indexPath.row
    
                cell.decreaseQntity.addTarget(self, action: #selector(decreaseButtonTapped(_:)), for: .touchUpInside)
                cell.decreaseQntity.tag = indexPath.row
        
        return cell
    }
       
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            
            let alert = UIAlertController(title: "Confirm Delete", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Confirm", style: .destructive, handler: { _ in
                
                self.products.remove(at: indexPath.row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
                tableView.reloadData()
                self.updateSubtotal()
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }


    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func updateSubtotal() {
         totalprice = 0.0
            for product in products {
                totalprice += Double(product.quantity) * product.price
            }
        self.subtotal.text = "\(totalprice)"
        }
}

class ProductCart {
    var image: UIImage
    var quantity: Int
    var price: Double
    
    init(image: UIImage, quantity: Int, price: Double) {
        self.image = image
        self.quantity = quantity
        self.price = price
    }
}
