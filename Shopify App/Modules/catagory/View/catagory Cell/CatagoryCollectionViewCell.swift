//
//  catagoryCollectionViewCell.swift
//  Shopify App
//
//  Created by Ali Moustafa on 01/03/2023.
//

import UIKit

class CatagoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cardView.layer.cornerRadius = 8
    }
}
