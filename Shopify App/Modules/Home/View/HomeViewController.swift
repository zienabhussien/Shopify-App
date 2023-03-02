//
//  HomeViewController.swift
//  Shopify App
//
//  Created by Ali Moustafa on 02/03/2023.
//

import UIKit
import Toast_Swift

class HomeViewController: UIViewController {
    @IBOutlet weak var AddsImage: UIImageView!
    
    @IBAction func copyCoupon(_ sender: UITapGestureRecognizer) {
        let couponCode = "MYCOUPON123"
            UIPasteboard.general.string = couponCode
        
        self.view.makeToast("The disscount coupon copied")
    }
    @IBOutlet weak var brandsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerBrandsCollectionView()
    }
    
    func  registerBrandsCollectionView(){
        
        brandsCollectionView.register(UINib(nibName: "BrandsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BrandsCollectionViewCell")
        brandsCollectionView.delegate = self
        brandsCollectionView.dataSource = self
        
    }

}

extension HomeViewController: CollectionView_Delegate_DataSource_FlowLayout{
    
    
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let storyboard =  UIStoryboard(name: "Main", bundle: nil)
//        let viewController = storyboard.instantiateViewController(withIdentifier: "SingUpViewController")
//        navigationController?.pushViewController(viewController, animated: true)
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandsCollectionViewCell", for: indexPath) as! BrandsCollectionViewCell
//        cell.categoryNameLabel.text = subCategoriesNames[indexPath.row]
        return cell
    }
    
    
}

extension HomeViewController{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.width
        return CGSize(width: width / 3, height:height * 0.43)
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
