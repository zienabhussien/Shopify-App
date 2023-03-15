//
//  FavourieTableViewCell.swift
//  Shopify App
//
//  Created by Dragon on 01/03/2023.

import UIKit

class FavourieTableViewCell: UITableViewCell {

    @IBOutlet weak var FavProductPrice: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var FavProuctName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func setUpCell(photo: String,name:String,price: String){
        favoriteImage.kf.setImage(with: URL(string: photo))
        FavProuctName.text = name
        
          if let itemPrice = Double(price) {
            var convertedPrice = itemPrice
            if UserDefaults.standard.string(forKey: "Currency") == "EGP" {
                convertedPrice *= 30.0
                FavProductPrice.text = "\(convertedPrice) EGP"
            } else {
                FavProductPrice.text = "$\(convertedPrice)"
            }
        } else {
            FavProductPrice.text = ""
        }
       
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
    }

}
