//
//  BrandsCollectionViewCell.swift
//  Shopify App
//
//  Created by Ali Moustafa on 02/03/2023.
//

import UIKit

class BrandsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var BrandImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        BrandImage.layer.cornerRadius = 8
    }
}
