//
//  PaymentOptionsCell.swift
//  Shopify App
//
//  Created by Zienab on 01/03/2023.
//

import UIKit

class PaymentOptionsCell: UITableViewCell {
  
    @IBOutlet weak var PaymentWayName: UILabel!
    @IBOutlet weak var checkPaymentWay: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
