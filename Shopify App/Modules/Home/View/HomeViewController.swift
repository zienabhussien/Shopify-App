//
//  HomeViewController.swift
//  Shopify App
//
//  Created by Ali Moustafa on 02/03/2023.
//

import UIKit
import Kingfisher
class HomeViewController: UIViewController {
    
    @IBOutlet var searchHome: UISearchBar!
    var viewModel: HomeViewModel!
    var isFiltering : Bool = false
    @IBOutlet weak var AddsImage: UIImageView!
    @IBOutlet weak var brandsCollectionView: UICollectionView!{
        didSet{
            brandsCollectionView.delegate = self
            brandsCollectionView.dataSource = self
//            registerBrandsCollectionView
            brandsCollectionView.register(UINib(nibName: "BrandsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BrandsCollectionViewCell")
        }
    }
    
    var searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        self.navigationItem.titleView = searchHome
        searchHome.placeholder = "Search Brand"
        super.viewDidLoad()
        viewModel = HomeViewModel()
        viewModel.viewDidLoad()
        bindViewModel()
        setUpUI()
    }
    
    @IBAction func goToCart(_ sender: Any) {
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
    
    @IBAction func goToWishList(_ sender: Any) {
        let userDefaultToken = UserDefaults.standard.integer(forKey: "loginId")

            if userDefaultToken != 0 {
                let wishListVC = self.storyboard?.instantiateViewController(withIdentifier: "FavouriteVC") as! FavouriteVC
                self.navigationController?.pushViewController(wishListVC, animated: true)
            }else{
                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
                self.navigationController?.pushViewController(loginVC, animated: true)
            }

    }
    func setUpUI(){
        self.title = "Home"
       // initializeSearcBar()
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func bindViewModel(){
        viewModel.didFetchData = {[weak self] in
            guard let self = self else {return}
            self.brandsCollectionView.reloadData()
        }
    }
    
    @IBAction func copyCoupon(_ sender: UITapGestureRecognizer) {
        let couponCode = "IOS_ITI"
            UIPasteboard.general.string = couponCode
        
        self.view.makeToast("The disscount coupon copied")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
  
    


}
//MARK: - SearchDelegate
extension HomeViewController : UISearchBarDelegate{
    var isSearchBarEmpty : Bool {
        return searchHome.text!.isEmpty
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        if !searchText.isEmpty {
            isFiltering = true
        }
        if !searchText.trimmingCharacters(in: .whitespaces).isEmpty  {
            // string contains non-whitespace characters
            viewModel.filteredBrands = viewModel.brandsModel?.smartCollections.filter{ smartCollection in
                return smartCollection.title.lowercased().contains(searchText.lowercased())
                
            } ?? []
            self.brandsCollectionView.reloadData()
       }         // reload
       
        
        if isSearchBarEmpty {
            isFiltering = false
            self.brandsCollectionView.reloadData()
        }
        
    }
    
}


//MARK: - CollectionView_Delegate

extension HomeViewController: CollectionView_Delegate_DataSource_FlowLayout{
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = self.storyboard?.instantiateViewController(withIdentifier: "ProductOfBrandVC") as! ProductOfBrandVC
        storyBoard.viewModel = ProductViewModel()
        if isFiltering {
          let brand = viewModel.filteredBrands[indexPath.row]
                storyBoard.viewModel.SmartCollectionID = String(brand.id)
            
         }else {
            if let brand = viewModel.brandsModel?.smartCollections[indexPath.row] {
                storyBoard.viewModel.SmartCollectionID = String(brand.id)
            }
        }
        

        navigationController?.pushViewController(storyBoard, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return viewModel.filteredBrands.count
        }
       
        return viewModel.brandsModel?.smartCollections.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandsCollectionViewCell", for: indexPath) as! BrandsCollectionViewCell
        
        if isFiltering {
            cell.BrandName.text = viewModel.filteredBrands[indexPath.row].title
            if let imageUrl = URL(string: viewModel.filteredBrands[indexPath.row].image.src) {
                cell.BrandImage.kf.setImage(with: imageUrl)
                
            }
        }else{
            if let brand = viewModel.brandsModel?.smartCollections[indexPath.row] {
                cell.BrandName.text = brand.title
                if let imageUrl = URL(string: brand.image.src) {
                    cell.BrandImage.kf.setImage(with: imageUrl)
                    
                }
            }
        }
        return cell
    }
    
}

 
        
