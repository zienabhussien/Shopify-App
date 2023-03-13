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
        if UserDefaults.standard.string(forKey: "Currency") == "EGP" {
            FavProductPrice.text = "\(price) EGP"
         } else {
             FavProductPrice.text = "$\(price)"
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
