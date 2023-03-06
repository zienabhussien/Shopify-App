//
//  AddressVC+TVC.swift
//  Shopify
//
//  Created by Ali Moustafa on 01/03/2023.
//

import UIKit
import CoreData

extension AddressVC : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrOfAddress.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressTVCell.identifier, for: indexPath) as! AddressTVCell
       let address = self.arrOfAddress[indexPath.row]
        if let addres1 = address.address1, let city = address.city, let country = address.country{
            cell.addressLabel.text = "\(addres1), \(city), \(country)"
        }
        return cell
    }
}

extension AddressVC : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let customrtId = Helper.shared.getUserID(), let id = self.arrOfAddress[indexPath.row].id else {return}
        
        setAddressDefault(customerId: customrtId, addressId: id, row: indexPath.row)
        self.showConfirmAlert(title: "are you sure!!", message: "this address added in your order!") { isConfirm in
            if isConfirm{
//                self.addAddressToOrder(row: indexPath.row)
//                self.goToPayment()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Please,Select an address from the following :"
    }
}

extension AddressVC{
    func setAddressDefault(customerId: Int, addressId: Int, row: Int){
        networking.setDefaultAddress(customerId: customerId, addressId: addressId, address: self.arrOfAddress[row]) { data, res, error in
            if error == nil {
                print("set def success")
               
            }else{
                print("set def falied")
            }
        }
    }
    func addAddressToOrder(row: Int){
        let myAddress = arrOfAddress[row]
//        let selectedAddress = AddressModel(context: context)

        guard let customerId = Helper.shared.getUserID(), let addressID = myAddress.id , let address1 = myAddress.address1, let city = myAddress.city, let country = myAddress.country, let name = myAddress.first_name, let phone = myAddress.phone else {return}

//        selectedAddress.custID = Int64(customerId)
//        selectedAddress.addID = Int64(addressID)
//        selectedAddress.address1 = address1
//        selectedAddress.city = city
//        selectedAddress.country = country
//        selectedAddress.customerName = name
//        selectedAddress.phoneNumber = phone

//        self.addressViewModel.saveSelectedAddress()
    }

    func goToPayment(){
        let paymentVC = UIStoryboard(name: "Checkout", bundle: nil).instantiateViewController(withIdentifier: "PaymentViewController")
        self.navigationController?.pushViewController(paymentVC, animated: true)
    }
}
