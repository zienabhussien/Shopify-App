//
//  AllOrderViewController.swift
//  Shopify App
//
//  Created by Ali Moustafa on 08/03/2023.
//

import UIKit
import Alamofire

class AllOrderViewController: UIViewController {
    var viewModel: MeViewModel!

    let userID = Helper.shared.getUserID()!

    @IBOutlet weak var allOrderTable: UITableView!
    var reponseOrsers : [Order]?
    override func viewDidLoad() {
        super.viewDidLoad()
        allOrderTable.separatorStyle = .none

        allOrderTable.dataSource = self
        allOrderTable.delegate = self
        viewModel = MeViewModel()
        viewModel.viewDidLoad()
        bindViewModelorder()

        
    }
    
    private func bindViewModelorder(){
        viewModel.didFetchData = {[weak self] in
            guard let self = self else {return}
            self.allOrderTable.reloadData()
        }
    }
}




extension AllOrderViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            let cell = tableView.dequeueReusableCell(withIdentifier: "AllOrderTableViewCell", for: indexPath) as! AllOrderTableViewCell
        cell.contentView.layer.cornerRadius = 20
        cell.contentView.layer.masksToBounds = true
        cell.contentView.layer.borderWidth = 1
        cell.createdAt.text = viewModel.reponseOrsers?.orders[indexPath.row].created_at
        cell.addressLabel.text = "\(viewModel.reponseOrsers?.orders[indexPath.row].customer?.default_address?.address1 ?? "def"),\(viewModel.reponseOrsers?.orders[indexPath.row].customer?.default_address?.city ?? "def"),\(viewModel.reponseOrsers?.orders[indexPath.row].customer?.default_address?.country ?? "def")"
        if let firstPrice = viewModel.reponseOrsers?.orders[indexPath.row].current_total_price, let itemPrice = Double(firstPrice) {
            var convertedPrice = itemPrice
            if UserDefaults.standard.string(forKey: "Currency") == "EGP" {
                convertedPrice *= 30.0
                cell.orderPrice.text = "\(convertedPrice) EGP"
            } else {
                cell.orderPrice.text = "$\(convertedPrice)"
            }
        } else {
            cell.orderPrice.text = ""
        }
 
            return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let orders = viewModel.reponseOrsers?.orders {
            return orders.count
        }
        else{
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

