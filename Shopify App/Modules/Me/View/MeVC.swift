//
//  MeVC.swift
//  Shopify App
//
//  Created by Sohila on 02/03/2023.
//

import UIKit

class MeVC: UIViewController {

    @IBOutlet weak var ordersTable: UITableView!
    @IBOutlet weak var wishListTable: UITableView!
    
    @IBOutlet weak var userWelcome: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    @IBAction func moreOrdersAction(_ sender: Any) {
        
    }
    
    
    @IBAction func moreWishListAction(_ sender: Any) {
        
    }
    
    
}


extension MeVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == ordersTable){
            let cell = tableView.dequeueReusableCell(withIdentifier: "ordersCell", for: indexPath) as! OrdersTableCell
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "wishListCell", for: indexPath) as! WishListTableCell
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
}
