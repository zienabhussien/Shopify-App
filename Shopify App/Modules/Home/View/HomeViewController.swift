//
//  HomeViewController.swift
//  Shopify App
//
//  Created by Ali Moustafa on 02/03/2023.
//

import UIKit
import Alamofire
import Kingfisher
class HomeViewController: UIViewController {
    @IBOutlet weak var AddsImage: UIImageView!
    @IBOutlet weak var brandsCollectionView: UICollectionView!
    var brandsModel : BrandResponse?     //variable to response data
    var filteredBrands =  [SmartCollection]()
    var searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        registerBrandsCollectionView()
        self.title = "Home"
        
        
        initializeSearcBar()
        navigationItem.hidesSearchBarWhenScrolling = false
        //fetch data
        fetchData { result in
            DispatchQueue.main.async {
                self.brandsModel = result
                self.brandsCollectionView.reloadData()
            }
        }
       
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)

    }
  
    func  registerBrandsCollectionView(){
        
        brandsCollectionView.register(UINib(nibName: "BrandsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BrandsCollectionViewCell")
        brandsCollectionView.delegate = self
        brandsCollectionView.dataSource = self
        
    }
    


}
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
        filteredBrands = brandsModel?.smartCollections.filter{ smartCollection in
            return smartCollection.title.lowercased().contains(searchController.searchBar.text!.lowercased())
            
        } ?? []
        
        // reload
        self.brandsCollectionView.reloadData()
        
        
    }
}

extension HomeViewController: CollectionView_Delegate_DataSource_FlowLayout{
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = self.storyboard?.instantiateViewController(withIdentifier: "ProductOfBrandVC") as! ProductOfBrandVC
        if let brand = brandsModel?.smartCollections[indexPath.row] {
            storyBoard.SmartCollectionID = String(brand.id)
        }
        navigationController?.pushViewController(storyBoard, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return filteredBrands.count
        }
       
        return brandsModel?.smartCollections.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandsCollectionViewCell", for: indexPath) as! BrandsCollectionViewCell
        
        if isFiltering {
            cell.BrandName.text = filteredBrands[indexPath.row].title
            if let imageUrl = URL(string: filteredBrands[indexPath.row].image.src) {
                cell.BrandImage.kf.setImage(with: imageUrl)
                
            }
        }else{
            if let brand = brandsModel?.smartCollections[indexPath.row] {
                cell.BrandName.text = brand.title
                if let imageUrl = URL(string: brand.image.src) {
                    cell.BrandImage.kf.setImage(with: imageUrl)
                    
                }
            }
        }
        return cell
    }
    
    
}

extension HomeViewController{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.width
        return CGSize(width: width / 2, height:height * 0.48)
        }
        
   
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    
    
    
}
                
        
extension HomeViewController{
            
            func fetchData(compilation: @escaping (BrandResponse?) -> Void)
            {
           
                guard let url = URL(string: "https://b24cfe7f0d5cba8ddb793790aaefa12a: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@mad-ios-2.myshopify.com/admin/api/2023-01/smart_collections.json") else {return}
                
                AF.request(url).response
                { response in
                    if let data = response.data {
                        do{
                            
                            let result = try JSONDecoder().decode(BrandResponse.self, from: data)
                            
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
        
        
        

