//
//  FavouriteVC.swift
//  Shopify App
//
//  Created by Dragon on 01/03/2023.
//

import UIKit

class FavouriteVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
   

    @IBOutlet weak var FavouriteTableView: UITableView!
    
    var wishList = [FavoriteProduct]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.FavouriteTableView.reloadData()
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        FavouriteTableView.delegate = self
        FavouriteTableView.dataSource = self
        FavouriteTableView.separatorStyle = .none

        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        wishList = CoreDataManager.fetchFromCoreData()
        FavouriteTableView.reloadData()
        
    }
   
  override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell") as! FavourieTableViewCell
        
        cell.contentView.layer.cornerRadius = 20
        cell.contentView.layer.masksToBounds = true
        cell.contentView.layer.borderWidth = 1
        
        let product = wishList[indexPath.row]
        cell.setUpCell(photo: product.productImage ?? "" , name: product.productName ?? "", price: product.productPrice ?? "")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    
    // Override to support editing the table view.
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            showAlert(indexPath: indexPath)
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var productInfoVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductVC") as! ProductVC
        
          productInfoVC.favProduct = wishList[indexPath.row]
        productInfoVC.fromFavouriteVC = true
        
        self.navigationController?.pushViewController(productInfoVC, animated: true)
        
    }
    
    
    func showAlert(indexPath: IndexPath){
        // declare Alert
        let alert = UIAlertController(title: "Delete", message: "Are you sure about deletion?", preferredStyle: .alert)
        
        //AddAction
        alert.addAction(UIAlertAction(title: "OK", style: .default , handler: { [self] action in
            UserDefaults.standard.set(false, forKey: "\((wishList[indexPath.row].productId)!)")
            CoreDataManager.deleteFromCoreData(productName: wishList[indexPath.row].productName ?? "")
            wishList.remove(at: indexPath.row)
            FavouriteTableView.deleteRows(at: [indexPath], with: .fade)
            
            self.FavouriteTableView.reloadData()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel , handler: { action in
        }))
        

        //showAlert
        self.present(alert, animated: true) {
        }
    }
    
}

