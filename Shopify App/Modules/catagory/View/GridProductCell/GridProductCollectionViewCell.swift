//
//  GridProductCollectionViewCell.swift
//  Shopify App
//
//  Created by Ali Moustafa on 02/03/2023.
//

import UIKit

class GridProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageGrid: UIImageView!
    
    @IBOutlet weak var nameGrid: UILabel!
    
    @IBOutlet weak var brandGrid: UILabel!
    
    
    @IBOutlet weak var starGrid: UIImageView!
    
    
    @IBOutlet weak var priceGrid: UILabel!
    
    @IBOutlet weak var favoriteGrid: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        imageGrid.layer.cornerRadius = 8
    }
}
