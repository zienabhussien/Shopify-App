//
//  ProductVC.swift
//  Shopify App
//
//  Created by Dragon on 01/03/2023.
//

import UIKit

class ProductVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var ProductPageControl: UIPageControl!
     
    @IBOutlet weak var ProductCV: UICollectionView!
    
   var arrProductPhotos = [UIImage(named: "1")!,UIImage(named: "download")!,UIImage(named: "download")!,UIImage(named: "download")!]
    
    var timer : Timer?
    
    var currentCellIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProductCV.dataSource = self
        ProductCV.delegate = self
        
        ProductPageControl.numberOfPages = arrProductPhotos.count
        
        startTimer()
    }
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }
    @objc func moveToNextIndex(){
        
        if currentCellIndex < arrProductPhotos.count - 1 {
            currentCellIndex += 1
        }else{
            currentCellIndex = 0
        }
        //ProductCV.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)

        ProductPageControl.currentPage = currentCellIndex

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrProductPhotos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCVC
        
        cell.ProductPhoto.image = arrProductPhotos[indexPath.row]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
