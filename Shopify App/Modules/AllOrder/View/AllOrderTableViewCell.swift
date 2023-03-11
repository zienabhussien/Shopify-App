//
//  AllOrderTableViewCell.swift
//  Shopify App
//
//  Created by Ali Moustafa on 08/03/2023.
//

import UIKit

class AllOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var orderPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
