//
//  ProductVC.swift
//  Shopify App
//
//  Created by Dragon on 01/03/2023.
//

import UIKit
import Toast_Swift
class ProductVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var ProductPageControl: UIPageControl!
     
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var ProductCV: UICollectionView!
    
    @IBOutlet weak var addToCart: UIBarButtonItem!
    //add to cart
    let orderViewModel = OrderViewModel()
    var product : Product?
    var timer : Timer?
    
    var currentCellIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProductCV.dataSource = self
        ProductCV.delegate = self
        
        ProductPageControl.numberOfPages =  product?.images?.count ?? 0
        productName.text = product?.title
        guard let price = product?.variants?.first?.price else {return}
        productPrice.text = "$\(price)"
        productDescription.text = product?.body_html
        startTimer()
    }
    
    
    
    @IBAction func addToCart(_ sender: UIButton) {
        print("addToCartButton")
                orderViewModel.bindingAlreadyInCartToView = {
                    self.showToast(message: "Already in Cart", font: .boldSystemFont(ofSize: 15))
                }
                orderViewModel.addItemsToCart(product: product!)
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
        
        if currentCellIndex < (product?.images?.count ?? 0) - 1 {
            currentCellIndex += 1
        }else{
            currentCellIndex = 0
        }
        ProductPageControl.currentPage = currentCellIndex

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product?.images?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCVC
        
        cell.ProductPhoto.kf.setImage(with: URL(string: product?.images?[indexPath.row].src ?? ""))
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
