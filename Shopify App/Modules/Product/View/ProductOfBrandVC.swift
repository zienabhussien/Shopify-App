//
//  ProductOfBrandVC.swift
//  Shopify App
//
//  Created by Ali Moustafa on 02/03/2023.
//

import UIKit

class ProductOfBrandVC: UIViewController {
    
    @IBOutlet weak var ProductOfBrandsCollection: UICollectionView!
    let subCategoriesNames: [String] = ["WOMEN","KID","MEN","SALE"]
    var isList: Bool = true
    var isFavorite: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerBrandCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)

    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func  registerBrandCollectionView(){
        
        ProductOfBrandsCollection.register(UINib(nibName: "ProductOFBrandCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductOFBrandCollectionViewCell")
        ProductOfBrandsCollection.delegate = self
        ProductOfBrandsCollection.dataSource = self
        
      
    }
    
   
}





extension ProductOfBrandVC: CollectionView_Delegate_DataSource_FlowLayout{
    

    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        let storyboard =  UIStoryboard(name: "Main", bundle: nil)
    //        let viewController = storyboard.instantiateViewController(withIdentifier: "SingUpViewController")
    //        navigationController?.pushViewController(viewController, animated: true)
    //    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductOFBrandCollectionViewCell", for: indexPath) as! ProductOFBrandCollectionViewCell
//            cell.categoryNameLabel.text = subCategoriesNames[indexPath.row]
            return cell
        
    }
    
}


extension ProductOfBrandVC{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
                let width = collectionView.frame.width
                return CGSize(width: width / 2, height: 236)
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
