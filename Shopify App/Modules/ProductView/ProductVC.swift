//
//  ProductVC.swift
//  Shopify App
//
//  Created by Dragon on 01/03/2023.
//

import UIKit
import Toast_Swift
class ProductVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var ProductPageControl: UIPageControl!
     
    @IBOutlet weak var ProductCV: UICollectionView!
    
    @IBOutlet weak var addToCart: UIBarButtonItem!
    //add to cart
    let orderViewModel = OrderViewModel()
    var product : Product?
    //add to cart

    
    
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
    
    @IBAction func addToCartButton(_ sender: Any) {
        print("addToCartButton")

//        orderViewModel.bindingAlreadyInCartToView = {
//            self.showToast(message: "Already in Cart", font: .boldSystemFont(ofSize: 15))
//        }
//        orderViewModel.addItemsToCart(product: product!)
        
//        UIView.animate(withDuration: 0.5, delay: 0,
//                       usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1,
//                       options: [], animations: {
//                        self.addToCart.transform =
//                           CGAffineTransform(scaleX: 2.0, y: 2.0)
//                        self.addToCart.transform =
//                           CGAffineTransform(scaleX: 1.0, y: 1.0)
//                    }, completion: nil)
    }
    
    
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2-100, y: self.view.frame.size.height-200, width: 200, height: 40))
        toastLabel.backgroundColor = .label
        toastLabel.textColor = .systemBackground
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.layer.cornerRadius = 8;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 5.0, delay: 0.5, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
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
