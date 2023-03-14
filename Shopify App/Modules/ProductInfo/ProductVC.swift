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
    var favProduct : FavoriteProduct?
    var fromFavouriteVC : Bool = false
    var timer : Timer?
    
    var currentCellIndex = 0
    var productId :Int?
    var productTitle: String?
    var productPriceVal: String?
    var productDesc: String?
    
    @IBOutlet weak var favourite: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        ProductCV.dataSource = self
        ProductCV.delegate = self
        
        productId = fromFavouriteVC ? favProduct?.productId : product?.id
        productTitle = fromFavouriteVC ? favProduct?.productName : product?.title
        productPriceVal = fromFavouriteVC ? favProduct?.productPrice : product?.variants?.first?.price
        productDesc =  fromFavouriteVC ? favProduct?.productDesc  : product?.body_html
        
        ProductPageControl.numberOfPages = fromFavouriteVC ? 1 : product?.images?.count ?? 0
        productName.text = productTitle
        guard let price = productPriceVal else {return}
        if UserDefaults.standard.string(forKey: "Currency") == "EGP" {
            productPrice.text = "\(price) EGP"
         } else {
        productPrice.text = "$\(price)"
         }
        
        productDescription.text = productDesc
        startTimer()
    }
    
    
      override func viewWillAppear(_ animated: Bool) {
          
          let favIsSelected =  UserDefaults.standard.bool(forKey: "\((productId) ?? 0)")
          favourite.isSelected =  favIsSelected
          if favIsSelected {
              favourite.setImage(UIImage(named: "favoriteRed"), for: .normal)
          }else{
              favourite.setImage(UIImage(named: "unFavorite"), for: .normal)
          }
      }
    
    @IBAction func addToWishList(_ sender: UIButton) {
       
        favourite.isSelected = !favourite.isSelected

        if favourite.isSelected {
            favourite.setImage(UIImage(named: "favoriteRed"), for: .normal)
            CoreDataManager.saveProductToCoreData(productName: productTitle ?? "", productPrice: productPriceVal ?? "", productImage: fromFavouriteVC ? favProduct?.productImage ?? "" : product?.image?.src ?? "", productId: productId ?? 0,productDesc: productDesc ?? "")
            UserDefaults.standard.set(true, forKey: "\((productId) ?? 0)")

        }else{
            favourite.setImage(UIImage(named: "unFavorite"), for: .normal)
            CoreDataManager.deleteFromCoreData(productName: productTitle ?? "")
            UserDefaults.standard.set(false, forKey: "\((productId) ?? 0)")
        }
    }
    @IBAction func addToCart(_ sender: UIButton) {
        
        orderViewModel.bindingAlreadyInCartToView = {
        self.showToast(message: "Already in bag", font: .boldSystemFont(ofSize: 15))
        }
        if fromFavouriteVC {
           // orderViewModel.addItemsToCart(product: favProduct)
        }else{
            orderViewModel.addItemsToCart(product: product!)
        }

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
        return fromFavouriteVC ? 1 :  product?.images?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCVC
        var  imageStr = (fromFavouriteVC ? favProduct?.productImage : product?.images?[indexPath.row].src ) ?? ""
        cell.ProductPhoto.kf.setImage(with: URL(string: imageStr))
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
