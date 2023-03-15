//
//  BageButton.swift
//  Shopify App
//
//  Created by Zienab on 15/03/2023.
//

import Foundation
import UIKit
class BageButton{
    
   static let badgeSize: CGFloat = 20
   static let badgeTag = 9830384

    static func badgeLabel(withCount count: Int) -> UILabel {
        let badgeCount = UILabel(frame: CGRect(x: 0, y: 0, width: badgeSize, height: badgeSize))
        badgeCount.translatesAutoresizingMaskIntoConstraints = false
        badgeCount.tag = badgeTag
        badgeCount.layer.cornerRadius = badgeCount.bounds.size.height / 2
        badgeCount.textAlignment = .center
        badgeCount.layer.masksToBounds = true
        badgeCount.textColor = .white
        badgeCount.font = UIFont(name: "SanFranciscoText-Light", size: 13)
        badgeCount.backgroundColor = .red
        badgeCount.text = String(count)
        return badgeCount
    }

   static func showBadge(bagBtn : UIButton ,withCount count: Int) {
       let badge = badgeLabel(withCount: count)
        bagBtn.addSubview(badge)

        NSLayoutConstraint.activate([
            badge.leftAnchor.constraint(equalTo: bagBtn.leftAnchor, constant: 14),
            badge.topAnchor.constraint(equalTo: bagBtn.topAnchor, constant: 4),
            badge.widthAnchor.constraint(equalToConstant: badgeSize),
            badge.heightAnchor.constraint(equalToConstant: badgeSize)
        ])
    }

   static func removeBadge(bagBtn : UIButton) {
        if let badge = bagBtn.viewWithTag(badgeTag) {
            badge.removeFromSuperview()
        }
    }

}
