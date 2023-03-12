//
//  CategoryCollectionViewDataSource.swift
//  Shopify App
//
//  Created by Ali Moustafa on 10/03/2023.
//

import Foundation
import UIKit

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
