//
//  WishListTableCell.swift
//  Shopify App
//
//  Created by Sohila on 02/03/2023.
//

import UIKit

class WishListTableCell: UITableViewCell {

    
    @IBOutlet weak var productImg: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
