//
//  ProductCollectionViewCell.swift
//  Shopify App
//
//  Created by Ali Moustafa on 02/03/2023.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageList: UIImageView!
    
    @IBOutlet weak var nameList: UILabel!
    
    @IBOutlet weak var brandlist: UILabel!
    
    
    @IBOutlet weak var starList: UIImageView!
    
    
    @IBAction func favriteListTapped(_ sender: UIButton) {
    }
    
    @IBOutlet weak var priceList: UILabel!
    
    @IBOutlet weak var favoritelist: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func layoutSubviews() {
        imageList.layer.cornerRadius = 8
    }
    
}
