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
    
     var someWishList = [FavoriteProduct]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        someWishList = CoreDataManager.fetchFromCoreData()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        wishListTable.reloadData()
        navigationController?.setNavigationBarHidden(false, animated: false)

    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    @IBAction func moreOrdersAction(_ sender: Any) {
        
    }
    
    
    @IBAction func moreWishListAction(_ sender: Any) {
        var favouriteVC = self.storyboard?.instantiateViewController(withIdentifier: "FavouriteVC") as! FavouriteVC
        self.navigationController?.pushViewController(favouriteVC, animated: true)
        
        
    }
    
    
}


extension MeVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == ordersTable){
            let cell = tableView.dequeueReusableCell(withIdentifier: "ordersCell", for: indexPath) as! OrdersTableCell
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "wishListCell", for: indexPath) as! WishListTableCell
        cell.productName.text = someWishList[indexPath.row].productName
        cell.productImg.kf.setImage(with: URL(string : someWishList[indexPath.row].productImage ?? ""))
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if someWishList.count > 2 {
            return 2
        }
        return someWishList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    
    
}
