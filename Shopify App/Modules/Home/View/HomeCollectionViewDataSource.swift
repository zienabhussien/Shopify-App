//
//  HomeCollectionViewDataSource.swift
//  Shopify App
//
//  Created by Ali Moustafa on 10/03/2023.
//

import Foundation
import UIKit
extension HomeViewController{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == addsCollection{
            return CGSize(width: collectionView.frame.width, height:collectionView.frame.height)

        }else{
            let width = collectionView.frame.width
            let height = collectionView.frame.width
            return CGSize(width: width / 2, height:height * 0.423)
        }
        
        
        
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
//MARK: -
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
               
