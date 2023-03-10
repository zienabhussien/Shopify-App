//
//  catagoryViewController.swift
//  Shopify App
//
//  Created by Ali Moustafa on 01/03/2023.
//

import UIKit
import Alamofire
import Floaty

class CatagoryViewController: UIViewController {
    
    @IBOutlet weak var laoding: UIActivityIndicatorView!
    @IBOutlet weak var subCategoriesCollectionViev: UICollectionView!{
        didSet{
            subCategoriesCollectionViev.register(UINib(nibName: "CatagoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CatagoryCollectionViewCell")
            subCategoriesCollectionViev.delegate = self
            subCategoriesCollectionViev.dataSource = self

        }
    }
    
    @IBOutlet weak var gridListButton: UIButton!
    
    @IBOutlet weak var productsCollectionView: UICollectionView!{
        didSet{
            
            productsCollectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionViewCell")
            
            productsCollectionView.register(UINib(nibName: "GridProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GridProductCollectionViewCell")
            
            productsCollectionView.delegate = self
            productsCollectionView.dataSource = self
        }
    }
    var subCategoriesNamesModel : subCatecoryResponse?     //variable .to response data
    var productOfbrandsCategoryModel : Products?     //variable to response data
    let floaty = Floaty()
    var isFiltered = false
    var FilterdArr: [Product]? = [Product]()
    var id = "?collection_id=437934555426"

    var isList: Bool = true
    var isFavorite: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //fetch data
        fetchData { result in
            DispatchQueue.main.async {
                self.subCategoriesNamesModel = result
                self.subCategoriesCollectionViev.reloadData()
            }
        }
        //
        
        
        //fetch data
        fetchproduct { result in
            DispatchQueue.main.async {
                self.productOfbrandsCategoryModel = result
                self.laoding.stopAnimating()
                self.productsCollectionView.reloadData()
            }
        }
        //
        
        
        // Float Action button animation style
        makeFloatyStyleButton()
        DispatchQueue.main.async {
            self.laoding.hidesWhenStopped = true
            self.laoding.startAnimating()
        }
        //

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)

    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
   
    
    @IBAction func didTapedGrid_ListButton(_ sender: UIButton) {
        
        isList.toggle()
        let imageList = UIImage(named: "list")
        let imageGrid = UIImage(named: "grid")
        let image = isList == true ? imageGrid : imageList
        gridListButton.setImage(image, for: .normal)
        productsCollectionView.reloadData()
    }
    
    
//floaty Button
    func makeFloatyStyleButton(){
        floaty.buttonColor =  .white
        floaty.paddingX = 10
        floaty.paddingY = 10
        floaty.openAnimationType = .slideLeft
        floaty.buttonImage = UIImage(named: "filter")
        floaty.itemButtonColor = .white
        floaty.itemTitleColor = .white
        floaty.addItem("ALL", icon: UIImage(named: "all")) { _ in
            self.isFiltered = false
            self.productsCollectionView.reloadData()
        }
        floaty.addItem("T-Shirts", icon: UIImage(named: "t-shirt")) { _ in
            let filered = self.productOfbrandsCategoryModel?.products?.filter({ item in
                return item.product_type == "T-SHIRTS"
            })
            self.FilterdArr = filered ?? []
            self.isFiltered = true
            self.productsCollectionView.reloadData()
        }
        floaty.addItem("Shoes", icon: UIImage(named: "shoes (2)")){ _ in
            let filered = self.productOfbrandsCategoryModel?.products?.filter({ item in
                return item.product_type=="SHOES"
            })

            self.FilterdArr = filered ?? []
            print(self.FilterdArr)
            self.isFiltered = true
            self.productsCollectionView.reloadData()
        }
        floaty.addItem("Accessories", icon: UIImage(named: "accessories")){ _ in
            let filered = self.productOfbrandsCategoryModel?.products?.filter({ item in
                return item.product_type=="ACCESSORIES"
            })
            self.FilterdArr = filered ?? []
            self.isFiltered = true
            self.productsCollectionView.reloadData()
        }
        view.addSubview(floaty)
    }
    //
}





extension CatagoryViewController: CollectionView_Delegate_DataSource_FlowLayout{
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == subCategoriesCollectionViev {
            return subCategoriesNamesModel?.customCollections.count ?? 0
        }else if collectionView == productsCollectionView{
            
            
            if(isFiltered){
                return FilterdArr?.count ?? 0
            }else{
                return productOfbrandsCategoryModel?.products?.count ?? 0
            }
            
        }else{
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView{
        case subCategoriesCollectionViev:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatagoryCollectionViewCell", for: indexPath) as! CatagoryCollectionViewCell
            
            if let subcategory = subCategoriesNamesModel?.customCollections[indexPath.row] {
                cell.categoryNameLabel.text = subcategory.title
            }
            return cell
        default:
            
            if isList == true{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as!ProductCollectionViewCell
                
                let imagefav = UIImage(named: "favoriteRed")
                let imageUnFav = UIImage(named: "unFavorite")
                let setimagefav = isFavorite == true ? imageUnFav : imagefav
                cell.favoritelist.setImage(setimagefav, for: .normal)
                
                if(isFiltered){
                    
                    if let productOfbrandCategory = FilterdArr?[indexPath.row] {
                        cell.nameList.text = productOfbrandCategory.title
                        cell.brandlist.text = productOfbrandCategory.product_type
                        if let firstPrice = productOfbrandCategory.variants?.first?.price {
                            cell.priceList.text = "$\(firstPrice)"
                        } else {
                            cell.priceList.text = ""
                        }
                        
                        cell.imageList.kf.indicatorType = .activity
                        
                        if let imageUrl = URL(string: productOfbrandCategory.image?.src ?? "") {
                            cell.imageList.kf.setImage(with: imageUrl)
                            
                        }
                    }
                
            }else
                {
                if let productOfbrandCategory = productOfbrandsCategoryModel?.products?[indexPath.row] {
                        cell.nameList.text = productOfbrandCategory.title
                        cell.brandlist.text = productOfbrandCategory.product_type
                    if let firstPrice = productOfbrandCategory.variants?.first?.price {
                            cell.priceList.text = "$\(firstPrice)"
                        } else {
                            cell.priceList.text = ""
                        }
                        
                        cell.imageList.kf.indicatorType = .activity
                        
                    if let imageUrl = URL(string: productOfbrandCategory.image?.src ?? "") {
                            cell.imageList.kf.setImage(with: imageUrl)
                            
                        }
                    }
                }
               
                return cell
            }else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridProductCollectionViewCell", for: indexPath) as!GridProductCollectionViewCell
                
                let imagefav = UIImage(named: "favoriteRed")
                let imageUnFav = UIImage(named: "unFavorite")
                let setimagefav = isFavorite == true ? imageUnFav : imagefav
                cell.favoriteGrid.setImage(setimagefav, for: .normal)
                
                if(isFiltered){
                    
                    if let productOfbrandCategory = FilterdArr?[indexPath.row] {
                        cell.nameGrid.text = productOfbrandCategory.title
                        cell.brandGrid.text = productOfbrandCategory.product_type
                        if let firstPrice = productOfbrandCategory.variants?.first?.price {
                            cell.priceGrid.text = "$\(firstPrice)"
                        } else {
                            cell.priceGrid.text = ""
                        }
                        
                        cell.imageGrid.kf.indicatorType = .activity
                        
                        if let imageUrl = URL(string: productOfbrandCategory.image?.src ?? "") {
                            cell.imageGrid.kf.setImage(with: imageUrl)
                            
                        }
                    }
            }else
                {
                if let productOfbrandCategory = productOfbrandsCategoryModel?.products?[indexPath.row] {
                    cell.nameGrid.text = productOfbrandCategory.title
                    cell.brandGrid.text = productOfbrandCategory.product_type
                    if let firstPrice = productOfbrandCategory.variants?.first?.price {
                        cell.priceGrid.text = "$\(firstPrice)"
                    } else {
                        cell.priceGrid.text = ""
                    }
                    if let imageUrl = URL(string: productOfbrandCategory.image?.src ?? "") {
                        cell.imageGrid.kf.setImage(with: imageUrl)
                            
                        }
                    }
                }
               
                return cell
            }
        }
    }
}




extension CatagoryViewController{
    func fetchData(compilation: @escaping (subCatecoryResponse?) -> Void)
    {
   
        guard let url = URL(string: "https://b24cfe7f0d5cba8ddb793790aaefa12a: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@mad-ios-2.myshopify.com/admin/api/2023-01/custom_collections.json") else {return}
        
        AF.request(url).response
        { response in
            if let data = response.data {
                do{
                    
                    let result = try JSONDecoder().decode(subCatecoryResponse.self, from: data)
                    
                    compilation(result)
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


extension CatagoryViewController{
    func fetchproduct(compilation: @escaping (Products?) -> Void)
    {
   
        guard let url = URL(string: "https://b24cfe7f0d5cba8ddb793790aaefa12a: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@mad-ios-2.myshopify.com/admin/api/2023-01/products.json\(id)") else {return}
        
    
        AF.request(url).response
        { response in
            if let data = response.data {
                do{
                    
                    let result = try JSONDecoder().decode(Products.self, from: data)
                    
                    compilation(result)
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




extension CatagoryViewController {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if collectionView == subCategoriesCollectionViev {

            // Get the selected subcategory from the model
            guard let subcategory = subCategoriesNamesModel?.customCollections[indexPath.item] else {
                return
            }

            // Update the id variable with the collection ID of the selected subcategory
            id = "?collection_id=\(subcategory.id)"
            print(subcategory.id)

            // Call the fetchproduct method again to fetch the updated data
            fetchproduct { result in
                DispatchQueue.main.async {
                    self.productOfbrandsCategoryModel = result
                    self.laoding.stopAnimating()
                    // Reload the productsCollectionView to show products in the selected subcategory
                    self.productsCollectionView.reloadData()
                }
            }
        } else if collectionView == productsCollectionView {
            let product = productOfbrandsCategoryModel?.products?[indexPath.row]
            let ProductVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductVC") as! ProductVC
            ProductVC.product = product
            self.navigationController?.pushViewController(ProductVC, animated: true)
        }

    }

}
