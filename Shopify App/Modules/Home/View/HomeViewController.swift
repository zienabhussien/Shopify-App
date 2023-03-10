//
//  HomeViewController.swift
//  Shopify App
//
//  Created by Ali Moustafa on 02/03/2023.
//

import UIKit
import Kingfisher
class HomeViewController: UIViewController {
    var viewModel: HomeViewModel!
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
        super.viewDidLoad()
        viewModel = HomeViewModel()
        viewModel.viewDidLoad()
        bindViewModel()
        setUpUI()
    }
    
    func setUpUI(){
        self.title = "Home"
        initializeSearcBar()
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func bindViewModel(){
        viewModel.didFetchData = {[weak self] in
            guard let self = self else {return}
            self.brandsCollectionView.reloadData()
        }
    }
    
    @IBAction func copyCoupon(_ sender: UITapGestureRecognizer) {
        let couponCode = "iOS_iTi"
            UIPasteboard.general.string = couponCode
        
        self.view.makeToast("The disscount coupon copied")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
  
    


}
//MARK: - SearchDelegate
extension HomeViewController: UISearchBarDelegate,UISearchResultsUpdating{
    
      var isSearchBarEmpty: Bool{
              return searchController.searchBar.text!.isEmpty
          }
      var isFiltering : Bool{
              return searchController.isActive && !isSearchBarEmpty
          }
   
    func initializeSearcBar(){

        searchController.searchResultsUpdater = self
        searchController.searchBar.tintColor = .white
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Brand"
        searchController.searchBar.tintColor = .black
        navigationItem.searchController = searchController
        definesPresentationContext = false
                
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.filteredBrands = viewModel.brandsModel?.smartCollections.filter{ smartCollection in
            return smartCollection.title.lowercased().contains(searchController.searchBar.text!.lowercased())
            
        } ?? []
        
        // reload
        self.brandsCollectionView.reloadData()
        
        
    }
}

//MARK: - CollectionView_Delegate

extension HomeViewController: CollectionView_Delegate_DataSource_FlowLayout{
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = self.storyboard?.instantiateViewController(withIdentifier: "ProductOfBrandVC") as! ProductOfBrandVC
        let productViewModel = ProductViewModel()

        if let brand = viewModel.brandsModel?.smartCollections[indexPath.row] {
            productViewModel.SmartCollectionID = String(brand.id)
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

 
        
