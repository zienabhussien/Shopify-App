//
//  AddressTVCell.swift
//  Shopify
//
//  Created by Hassan on 16/03/2022.
//

import UIKit

class AddressTVCell: UITableViewCell {

    @IBOutlet weak var addressLabel: UILabel!
    static let identifier = "addressTVCell"
    static func nib() -> UINib{
     return UINib(nibName: "AddressTVCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
