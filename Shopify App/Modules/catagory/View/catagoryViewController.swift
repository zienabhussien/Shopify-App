//
//  catagoryViewController.swift
//  Shopify App
//
//  Created by Ali Moustafa on 01/03/2023.
//

import UIKit

class CatagoryViewController: UIViewController {
    
    @IBOutlet weak var subCategoriesCollectionViev: UICollectionView!
    
    @IBOutlet weak var gridListButton: UIButton!
    
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    
    let subCategoriesNames: [String] = ["WOMEN","KID","MEN","SALE"]
    var isList: Bool = true
    var isFavorite: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)

    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func  registerCollectionView(){
        
        subCategoriesCollectionViev.register(UINib(nibName: "CatagoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CatagoryCollectionViewCell")
        subCategoriesCollectionViev.delegate = self
        subCategoriesCollectionViev.dataSource = self
        
        productsCollectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionViewCell")
        
        productsCollectionView.register(UINib(nibName: "GridProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GridProductCollectionViewCell")
        
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
    }
    
    @IBAction func didTapedGrid_ListButton(_ sender: UIButton) {
        
        isList.toggle()
        let imageList = UIImage(named: "list")
        let imageGrid = UIImage(named: "grid")
        let image = isList == true ? imageGrid : imageList
        gridListButton.setImage(image, for: .normal)
        productsCollectionView.reloadData()
    }
    
    

    
    
}





extension CatagoryViewController: CollectionView_Delegate_DataSource_FlowLayout{
    

    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        let storyboard =  UIStoryboard(name: "Main", bundle: nil)
    //        let viewController = storyboard.instantiateViewController(withIdentifier: "SingUpViewController")
    //        navigationController?.pushViewController(viewController, animated: true)
    //    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == subCategoriesCollectionViev {
            return subCategoriesNames.count
        }else if collectionView == productsCollectionView{
            return 5
        }else{
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView{
        case subCategoriesCollectionViev:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatagoryCollectionViewCell", for: indexPath) as! CatagoryCollectionViewCell
            cell.categoryNameLabel.text = subCategoriesNames[indexPath.row]
            return cell
        default:
            
            if isList == true{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as!ProductCollectionViewCell
                
                let imagefav = UIImage(named: "favoriteRed")
                let imageUnFav = UIImage(named: "unFavorite")
                let setimagefav = isFavorite == true ? imageUnFav : imagefav
                cell.favoritelist.setImage(setimagefav, for: .normal)
//                cell.favriteListTapped(UIButton)
    //            cell.categoryNameLabel.text = subCategoriesNames[indexPath.row]
                return cell
            }else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridProductCollectionViewCell", for: indexPath) as!GridProductCollectionViewCell
                
                let imagefav = UIImage(named: "favoriteRed")
                let imageUnFav = UIImage(named: "unFavorite")
                let setimagefav = isFavorite == true ? imageUnFav : imagefav
                cell.favoriteGrid.setImage(setimagefav, for: .normal)
                
    //            cell.categoryNameLabel.text = subCategoriesNames[indexPath.row]
                return cell
            }
            
            
            
          
        }
        
       
    }
    
}


extension CatagoryViewController{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        switch collectionView{
        case subCategoriesCollectionViev:
            
            let width = collectionView.frame.width
            let height =  collectionView.frame.height
            return CGSize(width: width / 3, height: height)
            
        default:
            if isList == true {
                let width = collectionView.frame.width
                return CGSize(width: width, height: 150)
            }else{
                let width = collectionView.frame.width
                return CGSize(width: width / 2, height: 236)
            }
            
        }
        
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
