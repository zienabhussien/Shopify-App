//
//  MeVC.swift
//  Shopify App
//
//  Created by Dragon on 02/03/2023.
//

import UIKit
import Alamofire
import CoreData

class MeVC: UIViewController {
    var viewModel: MeViewModel!

    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var ordersTable: UITableView!
    @IBOutlet weak var wishListTable: UITableView!
    @IBOutlet weak var bagButton: UIButton!
    var someWishList = [FavoriteProduct]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        if Helper.shared.getUserID() == 0 {
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
        viewModel = MeViewModel()
        
        
        NSLayoutConstraint.activate([
            bagButton.widthAnchor.constraint(equalToConstant: 34),
            bagButton.heightAnchor.constraint(equalToConstant: 44),
        ])
        
    }
    private func bindViewModelgategory(){
        viewModel.didFetchData = {[weak self] in
            guard let self = self else {return}
            self.ordersTable.reloadData()
        }
        viewModel.viewDidLoad()
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
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        let request: NSFetchRequest<OrderItemModel> = OrderItemModel.fetchRequest()
        let count = (try? context.count(for: request)) ?? 0
        
        BageButton.showBadge(bagBtn: bagButton, withCount: count - 3)
        
        userNameLabel.text = "Welcome " + (UserDefaults.standard.string(forKey: "userName") ?? "Ali")
        someWishList = CoreDataManager.fetchFromCoreData()
        viewModel.userID = Helper.shared.getUserID()!
        viewModel.fetchOrders()
        
        bindViewModelgategory()
        self.ordersTable.reloadData()
        wishListTable.reloadData()
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        bindViewModelgategory()
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
   


    @IBAction func moreWishListAction(_ sender: Any) {
        let favouriteVC = self.storyboard?.instantiateViewController(withIdentifier: "FavouriteVC") as! FavouriteVC
        self.navigationController?.pushViewController(favouriteVC, animated: true)
    }
}


extension MeVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == ordersTable){
            let cell = tableView.dequeueReusableCell(withIdentifier: "ordersCell", for: indexPath) as! OrdersTableCell
            cell.createdAtProduct.text = viewModel.reponseOrsers?.orders[indexPath.row].created_at
            if let firstPrice = viewModel.reponseOrsers?.orders[indexPath.row].current_total_price, let itemPrice = Double(firstPrice) {
                var convertedPrice = itemPrice
                if UserDefaults.standard.string(forKey: "Currency") == "EGP" {
                    convertedPrice *= 30.0
                    cell.priceProduct.text = "\(convertedPrice) EGP"
                } else {
                    cell.priceProduct.text = "$\(convertedPrice)"
                }
            } else {
                cell.priceProduct.text = ""
            }
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "wishListCell", for: indexPath) as! WishListTableCell
        cell.productName.text = someWishList[indexPath.row].productName
        cell.productImg.kf.setImage(with: URL(string : someWishList[indexPath.row].productImage ?? ""))
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == ordersTable {
            if let orders = viewModel.reponseOrsers?.orders {
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
        return 150
    }
    
}









