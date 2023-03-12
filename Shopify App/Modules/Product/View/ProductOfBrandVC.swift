//
//  ProductOfBrandVC.swift
//  Shopify App
//
//  Created by Ali Moustafa on 02/03/2023.
//

import UIKit
import Alamofire
import Kingfisher

class ProductOfBrandVC: UIViewController {
    var viewModel: ProductViewModel!
    @IBOutlet weak var ProductOfBrandsCollection: UICollectionView!{
        didSet{
            ProductOfBrandsCollection.register(UINib(nibName: "ProductOFBrandCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductOFBrandCollectionViewCell")
            ProductOfBrandsCollection.delegate = self
            ProductOfBrandsCollection.dataSource = self
        }
    }
   
    
    var  searchedProducts  = [Product]()
    var isFavorite: Bool = false
    var isFiltered = false //for slider
    var filterIsPressed = true
    var isFiltering : Bool = false


    @IBOutlet weak var productSearchBar: UISearchBar!
    @IBOutlet weak var priceSlider: UISlider!
    @IBOutlet weak var minimumPrice: UILabel!
    
    @IBOutlet weak var maximumPrice: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
//        viewModel = ProductViewModel()
        viewModel.viewDidLoad()
        productSearchBar.delegate = self
        bindViewModel()
        //slider
        maximumPrice.isHidden = true
        minimumPrice.isHidden = true
        priceSlider.isHidden = true
    }
    
    private func bindViewModel(){
        viewModel.didFetchData = {[weak self] in
            guard let self = self else {return}
            self.title = self.viewModel.productOBbrandsModel?.products?.first?.vendor
            self.ProductOfBrandsCollection.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.ProductOfBrandsCollection.reloadData()
    }
    
    @IBAction func filterSlider(_ sender: UISlider) {
        
        //print(sender.value)
        isFiltered = true
        let filteredByPrice = self.viewModel.productOBbrandsModel?.products?.filter({ product in
            maximumPrice.text = "$"+String(Int(sender.value))
            return Float(product.variants?[0].price ?? "" ) ?? 0 <= sender.value
        })
        self.viewModel.filteredProducts = filteredByPrice
        self.updateUi()
    }
    
    private func updateUi(){
        DispatchQueue.main.async {
        self.ProductOfBrandsCollection.reloadData()
        }
    }
    
    
    
    @IBAction func filterButtonByPrice(_ sender: UIButton) {
        filterBtnIsPressed()

    }
    
    private func filterBtnIsPressed(){
        if filterIsPressed{
            filterIsPressed = false
            minimumPrice.isHidden = false
            maximumPrice.isHidden = false
            priceSlider.isHidden = false
        }else{
            minimumPrice.isHidden = true
            maximumPrice.isHidden = true
            filterIsPressed = true
            priceSlider.isHidden = true
        }
    }
    @IBAction func toWishlistButton(_ sender: Any) {
        
        let userDefaultToken = UserDefaults.standard.integer(forKey: "loginId")

            if userDefaultToken != 0 {
                let wishListVC = self.storyboard?.instantiateViewController(withIdentifier: "FavouriteVC") as! FavouriteVC
                self.navigationController?.pushViewController(wishListVC, animated: true)
            }else{
                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
                self.navigationController?.pushViewController(loginVC, animated: true)
            }
        }
    
    @IBAction func toCartButton(_ sender: Any) {
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)

    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}


extension ProductOfBrandVC : UISearchBarDelegate{
    var isSearchBarEmpty : Bool {
        return productSearchBar.text!.isEmpty
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //print(searchText)
        if !searchText.isEmpty {
            isFiltering = true
        }
        searchedProducts =  viewModel.productOBbrandsModel?.products?.filter({ product in
            return (product.title.lowercased().contains(searchText.lowercased()))
        }) ?? []
        
        self.ProductOfBrandsCollection.reloadData()
        if isSearchBarEmpty {
            isFiltering = false
            self.ProductOfBrandsCollection.reloadData()
        }
    }
}


extension ProductOfBrandVC: CollectionView_Delegate_DataSource_FlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return searchedProducts.count
            
        }
        return  viewModel.filteredProducts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductOFBrandCollectionViewCell", for: indexPath) as! ProductOFBrandCollectionViewCell
        
        var productKey = "\((viewModel.filteredProducts?[indexPath.row].id)!)"
       // print(productKey)
        if UserDefaults.standard.bool(forKey: productKey){
            cell.favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            //print("add Fav")
          }else{
              cell.favButton.setImage(UIImage(systemName: "heart"), for: .normal)
               // print("not fav")
        }
        cell.addToWishList = { [unowned self] in
            
            var favIsSelected =  UserDefaults.standard.bool(forKey: productKey)
               cell.favButton.isSelected =   UserDefaults.standard.bool(forKey: productKey)
            cell.favButton.isSelected = !cell.favButton.isSelected
            
            if  cell.favButton.isSelected {
                
             cell.favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            // save to core data
                CoreDataManager.saveProductToCoreData(productName:viewModel.filteredProducts?[indexPath.row].title ?? ""      , productPrice: viewModel.filteredProducts?[indexPath.row].variants?.first?.price ?? "", productImage:        viewModel.filteredProducts?[indexPath.row].image?.src ?? "", productId: viewModel.filteredProducts?[indexPath.row].id ?? 0)
                
                UserDefaults.standard.set(true, forKey: "\(viewModel.filteredProducts?[indexPath.row].id ?? 0)")

            }else{
                
                cell.favButton.setImage(UIImage(systemName: "heart"), for: .normal)
                CoreDataManager.deleteFromCoreData(productName: viewModel.filteredProducts?[indexPath.row].title ?? "" )
                UserDefaults.standard.set(false, forKey: "\(viewModel.filteredProducts?[indexPath.row].id ?? 0)")
            }
    }
        if isFiltering {
            cell.nameOfProductBrand.text = searchedProducts[indexPath.row].title
            cell.ProductType.text = searchedProducts[indexPath.row].product_type
            if let firstPrice = searchedProducts[indexPath.row].variants?.first?.price {
                    cell.productPrice.text = "$\(firstPrice)"
                } else {
                    cell.productPrice.text = ""
                }
                
            if let imageUrl = URL(string: searchedProducts[indexPath.row].image?.src ?? "") {
                           cell.productImage.kf.setImage(with: imageUrl)
                }
        } else{
            if let productOfbrand = viewModel.filteredProducts?[indexPath.row] {
                        cell.nameOfProductBrand.text = productOfbrand.title
                        cell.ProductType.text = productOfbrand.product_type
                        if let firstPrice = productOfbrand.variants?.first?.price {
                            cell.productPrice.text = "$\(firstPrice)"
                        } else {
                            cell.productPrice.text = ""
                        }
                        if let imageUrl = URL(string: productOfbrand.image?.src ?? "") {
                                   cell.productImage.kf.setImage(with: imageUrl)
            
                               }
                           }
        }
        return cell
    }
}

// MARK: CollectionView delegate
extension ProductOfBrandVC{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = viewModel.filteredProducts?[indexPath.row]
        let ProductVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductVC") as! ProductVC
        ProductVC.product = product
        self.navigationController?.pushViewController(ProductVC, animated: true)
    }
    
}

