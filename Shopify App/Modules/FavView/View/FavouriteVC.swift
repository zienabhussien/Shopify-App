//
//  FavouriteVC.swift
//  Shopify App
//
//  Created by Dragon on 01/03/2023.
//

import UIKit

class FavouriteVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
   

    @IBOutlet weak var FavouriteTableView: UITableView!
    
    var arr = [Product]()
    override func viewDidLoad() {
        super.viewDidLoad()
        FavouriteTableView.delegate = self
        FavouriteTableView.dataSource = self
        FavouriteTableView.separatorStyle = .none

        arr.append(Product.init(name: "pro1", img: UIImage(named: "1")!, price: 369))
        arr.append(Product.init(name: "pro2", img: UIImage(named: "download")!, price: 875))
        arr.append(Product.init(name: "pro2", img: UIImage(named: "download")!, price: 875))
        arr.append(Product.init(name: "pro3", img: UIImage(named: "1")!, price: 965))
        arr.append(Product.init(name: "pro3", img: UIImage(named: "1")!, price: 965))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell") as! FavourieTableViewCell
        cell.contentView.layer.cornerRadius = 20
        cell.contentView.layer.masksToBounds = true
        cell.contentView.layer.borderWidth = 1
        let product = arr[indexPath.row]
        cell.setUpCell(photo: product.img, name: product.name, price: product.price)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
struct Product {
    let name : String
    let img : UIImage
    let price : Double
}
