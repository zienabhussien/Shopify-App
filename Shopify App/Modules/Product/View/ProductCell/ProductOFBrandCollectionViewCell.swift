//
//  ProductOFBrandCollectionViewCell.swift
//  Shopify App
//
//  Created by Ali Moustafa on 02/03/2023.
//

import UIKit

class ProductOFBrandCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameOfProductBrand: UILabel!
    @IBOutlet weak var ProductType: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    
    var addToWishList: (()->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func didPressedOnFavBtn(_ sender: UIButton) {
        addToWishList?()

    }
    
}
