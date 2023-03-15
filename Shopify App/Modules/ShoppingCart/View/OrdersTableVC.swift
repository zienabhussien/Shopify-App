//
//  OrdersVC+TVC.swift
//  Shopify App
//
//  Created by Ali Moustafa on 02/03/2023.
//

import Foundation
import UIKit

extension OrdersVC : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: OrdersTVC.identifier, for: indexPath) as! OrdersTVC
        cell.addButton.tag = indexPath.row
        cell.imgView.kf.setImage(with: URL(string: cartArray[indexPath.row].itemImage ?? ""))
        cell.titleLabel.text = cartArray[indexPath.row].itemName
        
        if let itemPriceStr = cartArray[indexPath.row].itemPrice, let itemPrice = Double(itemPriceStr) {
            var convertedPrice = itemPrice
            if UserDefaults.standard.string(forKey: "Currency") == "EGP" {
                convertedPrice *= 30.0
                cell.priceLabel.text = "\(convertedPrice) EGP"
            } else {
                cell.priceLabel.text = "$\(convertedPrice)"
            }
        } else {
            cell.priceLabel.text = ""
        }
 
        cell.addItemQuantity = {
            self.orderViewModel.getSelectedItemInCart(productId: self.cartArray[indexPath.row].itemID) { selectedOrder, error in
                if selectedOrder != nil {
                    selectedOrder?.itemQuantity+=1
                }
                self.orderViewModel.saveProductToCart()
            }
            self.tableView.reloadData()
            self.setTotalPrice()
        }
        cell.subItemQuantity = {
            if self.cartArray[indexPath.row].itemQuantity > 1 {
                self.orderViewModel.getSelectedItemInCart(productId: self.cartArray[indexPath.row].itemID) { selectedOrder, error in
                    if selectedOrder != nil {
                        selectedOrder?.itemQuantity-=1
                    }
                    self.orderViewModel.saveProductToCart()
                }
            }
            self.tableView.reloadData()
            self.setTotalPrice()
        }
        
        
        cell.quantityLabel.text = String(cartArray[indexPath.row].itemQuantity)
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            showDeleteAlert(indexPath: indexPath)
            
        } else if editingStyle == .insert {
        }
    }
    
    
    func showDeleteAlert(indexPath:IndexPath){
        let alert = UIAlertController(title: "Are you sure?", message: "You will remove this item from bag", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { [self] UIAlertAction in
            orderViewModel.deleteFromCoreData(indexPath: indexPath, cartItems: cartArray)
            self.cartArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            setTotalPrice()

            self.tableView.reloadData()
            if self.cartArray.count == 0 {
                emptyCart.isHidden = false
                self.tableView.isHidden = true
                
                setTotalPrice()

                self.tableView.reloadData()
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}


extension OrdersVC : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

