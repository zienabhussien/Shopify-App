//
//  OrderTableViewCell.swift
//  Shopify App
//
//  Created by Dragon on 02/03/2023.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var OrderDate: UILabel!
    @IBOutlet weak var OderPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func setUpCell(price:Double,date:Date){
        
        OderPrice.text = "\(price) EGP"
        OrderDate.text = "\(date)"
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
    }

}
