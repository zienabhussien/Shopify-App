//
//  ShoppingCartCell.swift
//  Shopify App
//
//  Created by Zienab on 01/03/2023.
//

import UIKit

class ShoppingCartCell: UITableViewCell {

    @IBOutlet weak var productImg: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet weak var increaseQuantity: UIButton!
    @IBOutlet weak var quantityNumber: UILabel!
    @IBOutlet weak var decreaseQntity: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        super.layoutSubviews()
      
        
        increaseQuantity.layer.borderWidth = 1
        increaseQuantity.layer.cornerRadius = 10
        increaseQuantity.layer.borderColor = UIColor.blue.cgColor
        
        decreaseQntity.layer.borderWidth = 1
        decreaseQntity.layer.cornerRadius = 10
        decreaseQntity.layer.borderColor = UIColor.blue.cgColor
        
//        contentView.layer.cornerRadius = 20
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    
    
}
