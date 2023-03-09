//
//  OrderVC.swift
//  Shopify App
//
//  Created by Dragon on 02/03/2023.
//

import UIKit

class OrderVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var OrderTable: UITableView!
    
    @IBOutlet weak var tableView: UITableView!
    //    var arr = [Order]()
    override func viewDidLoad() {
        super.viewDidLoad()
        OrderTable.delegate = self
        OrderTable.dataSource = self
        OrderTable.separatorStyle = .none
        
//        arr.append(Order.init(price: 1593.1 , date: Date() ))
//        arr.append(Order.init(price: 1593.1 , date: Date() ))
//        arr.append(Order.init(price: 1593.1 , date: Date() ))
//        arr.append(Order.init(price: 1593.1 , date: Date() ))
//        arr.append(Order.init(price: 1593.1 , date: Date() ))
//        arr.append(Order.init(price: 1593.1 , date: Date() ))
//
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
//        return arr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell") as! OrderTableViewCell
        cell.contentView.layer.cornerRadius = 20
        cell.contentView.layer.masksToBounds = true
        cell.contentView.layer.borderWidth = 1
//        let product = arr[indexPath.row]
//        cell.setUpCell(price: product.price, date: product.date)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
//struct Order {
//    let price : Double
//    let date : Date
//}

