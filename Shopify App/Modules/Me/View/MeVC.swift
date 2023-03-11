//
//  MeVC.swift
//  Shopify App
//
//  Created by Sohila on 02/03/2023.
//

import UIKit
import Alamofire

class MeVC: UIViewController {

    @IBOutlet weak var ordersTable: UITableView!
    @IBOutlet weak var wishListTable: UITableView!
    
    @IBOutlet weak var userWelcome: UILabel!
    
    var someWishList = [FavoriteProduct]()

    var reponseOrsers : [Order]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetch data
        fetchOrders { result in
            DispatchQueue.main.async {
                self.reponseOrsers = result
                print(self.reponseOrsers ?? "no order")
                self.ordersTable.reloadData()

            }
        }
        //
       
    }
    
    @IBAction func settingButton(_ sender: Any) {
        
        let userDefaultToken = UserDefaults.standard.integer(forKey: "loginId")
            if userDefaultToken != 0 {
                let storyboard =  UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "SettingsVC")
                viewController.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(viewController, animated: true)
            }else{
                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
                self.navigationController?.pushViewController(loginVC, animated: true)
            }
    }
    @IBAction func cartButton(_ sender: Any) {
            let userDefaultToken = UserDefaults.standard.integer(forKey: "loginId")
                if userDefaultToken != 0 {
                    let storyboard =  UIStoryboard(name: "Main", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "OrdersVC")
                    viewController.hidesBottomBarWhenPushed = true
                    navigationController?.pushViewController(viewController, animated: true)
                }else{
                    let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
                    self.navigationController?.pushViewController(loginVC, animated: true)
        }
    }

    @IBAction func moreOrder(_ sender: Any) {
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        someWishList = CoreDataManager.fetchFromCoreData()
       wishListTable.reloadData()

    }
    override func viewWillAppear(_ animated: Bool) {
        wishListTable.reloadData()

        navigationController?.setNavigationBarHidden(false, animated: false)

    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
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
            cell.createdAtProduct.text = reponseOrsers?[indexPath.row].created_at
            cell.priceProduct.text = reponseOrsers?[indexPath.row].current_total_price
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "wishListCell", for: indexPath) as! WishListTableCell
        cell.productName.text = someWishList[indexPath.row].productName
        cell.productImg.kf.setImage(with: URL(string : someWishList[indexPath.row].productImage ?? ""))
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == ordersTable {
            if let orders = reponseOrsers {
                if orders.count < 3 {
                    return orders.count
                } else {
                    return 3
                }
            } else {
                return 0
            }
        } else {
            if someWishList.count > 3 {
                return 3
            }
            return someWishList.count
        }
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
}




//MARK: - order in me
extension MeVC{
    func fetchOrders(compilation: @escaping ([Order]?) -> Void)
    {
        let userID = Helper.shared.getUserID()

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




