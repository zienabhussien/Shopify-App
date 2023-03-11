//
//  AllOrderViewController.swift
//  Shopify App
//
//  Created by Ali Moustafa on 08/03/2023.
//

import UIKit
import Alamofire

class AllOrderViewController: UIViewController {
    let userID = Helper.shared.getUserID()!

    @IBOutlet weak var allOrderTable: UITableView!
    var reponseOrsers : [Order]?
    override func viewDidLoad() {
        super.viewDidLoad()
        allOrderTable.dataSource = self
        allOrderTable.delegate = self
        //fetch data
                fetchOrders { result in
                    DispatchQueue.main.async {
                        self.reponseOrsers = result
                        print(self.reponseOrsers ?? "no order")
                        self.allOrderTable.reloadData()
                    }
                }
                //
    }
    
}




extension AllOrderViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            let cell = tableView.dequeueReusableCell(withIdentifier: "AllOrderTableViewCell", for: indexPath) as! AllOrderTableViewCell
        cell.createdAt.text = reponseOrsers?[indexPath.row].created_at
        cell.orderPrice.text = reponseOrsers?[indexPath.row].current_total_price
            return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reponseOrsers?.count ?? 0
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
}

extension AllOrderViewController{
    func fetchOrders(compilation: @escaping ([Order]?) -> Void)
    {
        guard let url = URL(string: "https://b24cfe7f0d5cba8ddb793790aaefa12a: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@mad-ios-2.myshopify.com/admin/api/2023-01/customers/\(userID)/orders.json") else {return}
        
//        \(customerId)
    
        AF.request(url).response
        { response in
            if let data = response.data {
                do{
                    
                    let result = try JSONDecoder().decode(OrdersFromAPI.self, from: data)
                    
                    compilation(result.orders)
                }
                catch{
                    compilation(nil)
                }
            } else {
                compilation(nil)
            }
        }
    }
    
    
}




