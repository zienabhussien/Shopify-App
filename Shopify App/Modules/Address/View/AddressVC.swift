//
//  AddressVC.swift
//  Shopify App
//
//  Created by Ali Moustafa on 05/03/2023.
//

import UIKit
import SwiftUI

class AddressVC: UIViewController {
    
    
    @IBOutlet weak var emptyImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var arrOfAddress: [Address] = []
    let addressViewModel = AddressViewModel()
    let networking = Networking()
    
    var isPresentedFromCart: Bool = false


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAddress()
        tableView.separatorStyle = .none
        tableView.register(AddressTVCell.nib(), forCellReuseIdentifier: AddressTVCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addressViewModel.userID = Helper.shared.getUserID()!

        addressViewModel.getAllAddressForCustomer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.checkCartIsEmpty()
        }
    }

    func checkCartIsEmpty(){
        if arrOfAddress.count == 0 {
            tableView.isHidden = true
            emptyImage.isHidden = false
        }
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
