//
//  OrdersTableCell.swift
//  Shopify App
//
//  Created by Sohila on 02/03/2023.
//

import UIKit

class OrdersTableCell: UITableViewCell {

    
    
    @IBOutlet weak var priceProduct: UILabel!
    
    @IBOutlet weak var createdAtProduct: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
}
