//
//  AddressVC.swift
//  Shopify App
//
//  Created by Ali Moustafa on 05/03/2023.
//

import UIKit
import SwiftUI

class AddressVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var arrOfAddress: [Address] = []
    let addressViewModel = AddressViewModel()
    let networking = Networking()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(AddressTVCell.nib(), forCellReuseIdentifier: AddressTVCell.identifier)
        setAddress()
    }
    
    @IBAction func createAddressButton(_ sender: Any) {
        let address =  self.storyboard?.instantiateViewController(withIdentifier: "CreateAddressVC") as! CreateAddressVC
        
        self.navigationController?.pushViewController(address, animated: true)
    }
    func setAddress(){
        addressViewModel.bindSuccessToView = {
            self.arrOfAddress = self.addressViewModel.address
            self.tableView.reloadData()
        }
        addressViewModel.bindFailedToView = {
        }
    }
}
