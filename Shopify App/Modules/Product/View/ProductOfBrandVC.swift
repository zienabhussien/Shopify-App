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
    
    @IBOutlet weak var vendorName: UILabel!
    @IBOutlet weak var ProductOfBrandsCollection: UICollectionView!
    var productOBbrandsModel : ProductOfBrand?     //variable to response data
    var isFavorite: Bool = false
    var SmartCollectionID: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerBrandCollectionView()
        
        //fetch data
        fetchData { result in
            DispatchQueue.main.async {
                self.productOBbrandsModel = result
                self.vendorName.text = self.productOBbrandsModel?.products.first?.vendor
                self.ProductOfBrandsCollection.reloadData()
            }
        }
        //
        
    }
    
    @IBAction func toWishlistButton(_ sender: Any) {
        
        
        
        let storyboard =  UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "toWishlistButton")
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
        print("wish")

    }
    
    @IBAction func toCartButton(_ sender: Any) {
        let storyboard =  UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SingUpViewController")
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
        print("toCartButton")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)

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
        productOBbrandsModel?.products.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductOFBrandCollectionViewCell", for: indexPath) as! ProductOFBrandCollectionViewCell
        if let productOfbrand = productOBbrandsModel?.products[indexPath.row] {
            cell.nameOfProductBrand.text = productOfbrand.title
            cell.ProductType.text = productOfbrand.productType
            if let firstPrice = productOfbrand.variants.first?.price {
                cell.productPrice.text = "$\(firstPrice)"
            } else {
                cell.productPrice.text = ""
            }
            
            if let imageUrl = URL(string: productOfbrand.image.src) {
                       cell.productImage.kf.setImage(with: imageUrl)

                   }
               }
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



extension ProductOfBrandVC{
    func fetchData(compilation: @escaping (ProductOfBrand?) -> Void)
    {
   
        guard let url = URL(string: "https://b24cfe7f0d5cba8ddb793790aaefa12a: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@mad-ios-2.myshopify.com/admin/api/2023-01/products.json?collection_id=\(SmartCollectionID)") else {return}
        
        AF.request(url).response
        { response in
            if let data = response.data {
                do{
                    
                    let result = try JSONDecoder().decode(ProductOfBrand.self, from: data)
                    
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



//
//extension ProductOfBrandVC{
//    func checkIsProductSelected(row: Int, sender: UIButton){
//        if !sender.isSelected {
//             //button selected
//            sender.isSelected = true
//            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//            self.addToWishList(row: row)
//         }
//         else{
//             //button non selected
//             sender.isSelected = false
//             sender.setImage(UIImage(systemName: "heart"), for: .normal)
//             self.nonSelectedProduct(row: row)
//         }
//    }
//}


