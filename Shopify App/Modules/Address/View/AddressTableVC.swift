//
//  AddressVC+TVC.swift
//  Shopify App
//
//  Created by Ali Moustafa on 05/03/2023.
//

import UIKit
import CoreData

extension AddressVC : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrOfAddress.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressTVCell.identifier, for: indexPath) as! AddressTVCell
        cell.contentView.layer.cornerRadius = 20
        cell.contentView.layer.masksToBounds = true
        cell.contentView.layer.borderWidth = 1
       let address = self.arrOfAddress[indexPath.row]
        if let addres1 = address.address1, let city = address.city, let country = address.country{
            cell.addressLabel.text = "\(addres1), \(city), \(country)"
        }
        return cell
    }
}

extension AddressVC : UITableViewDelegate{
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isPresentedFromCart {
            guard let customrtId = Helper.shared.getUserID(), let id = self.arrOfAddress[indexPath.row].id else {return}
            setAddressDefault(customerId: customrtId, addressId: id, row: indexPath.row)
            self.showConfirmAlert(title: "Choose address", message: "Orders will be delivered to this address!") { isConfirm in
                if isConfirm{
                    self.addAddressToOrder(row: indexPath.row)
                    self.goToPayment()
                }
            }
        } else {
            let editAddress = self.storyboard?.instantiateViewController(withIdentifier: "CreateAddressVC") as! CreateAddressVC
            editAddress.fromMeTitle = true
            editAddress.address = arrOfAddress[indexPath.row]
            self.navigationController?.pushViewController(editAddress, animated: true)
          }
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         
         if editingStyle == .delete {
             // Delete the row from the data source
             showAlert(indexPath: indexPath)
             
             
         } else if editingStyle == .insert {
             // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         }
         
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Please select an address to deliver your order."
    }
}
extension AddressVC {
    func showAlert(indexPath: IndexPath){
        // declare Alert
        let alert = UIAlertController(title: "Delete", message: "Are you sure about deletion?", preferredStyle: .alert)
        
        //AddAction
        alert.addAction(UIAlertAction(title: "OK", style: .default , handler: { [self] action in
            addressViewModel.deleteFromApi(addressId: self.arrOfAddress[indexPath.row].id ?? 0)

            arrOfAddress.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
           
            self.tableView.reloadData()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel , handler: { action in
        }))
        

        //showAlert
        self.present(alert, animated: true) {
        }
    }
}

extension AddressVC{
    func setAddressDefault(customerId: Int, addressId: Int, row: Int){
        networking.setDefaultAddress(customerId: customerId, addressId: addressId, address: self.arrOfAddress[row]) { data, res, error in
            if error == nil {
               // print("set def success")
            }else{
                //print("set def falied")
            }
        }
    }
    
    func addAddressToOrder(row: Int){
        let myAddress = arrOfAddress[row]
       let selectedAddress = AddressModel(context: context)

        guard let customerId = Helper.shared.getUserID(), let addressID = myAddress.id , let address1 = myAddress.address1, let city = myAddress.city, let country = myAddress.country, let name = myAddress.first_name, let phone = myAddress.phone else {return}

        selectedAddress.custID = Int64(customerId)
        selectedAddress.addID = Int64(addressID)
        selectedAddress.address1 = address1
        selectedAddress.city = city
        selectedAddress.country = country
        selectedAddress.customerName = name
        selectedAddress.phoneNumber = phone

        self.addressViewModel.saveSelectedAddress()
    }

    func goToPayment(){
        let paymentVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PaymentOptionsVC")
        self.navigationController?.pushViewController(paymentVC, animated: true)
    }
    
}
