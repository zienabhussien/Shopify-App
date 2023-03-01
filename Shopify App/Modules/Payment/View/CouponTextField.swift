//
//  CouponTextField.swift
//  Shopify App
//
//  Created by Zienab on 01/03/2023.
//

import UIKit
import MaterialComponents.MaterialTextFields
import MaterialComponents.MaterialTextFields_ColorThemer
class CouponTextField: UIView {

    private var textFieldControllerFloating: MDCTextInputControllerOutlined!
    var textField: MDCTextField!

    @IBInspectable var placeHolder: String!
    @IBInspectable var value: String!
    @IBInspectable var primaryColor: UIColor! = .purple

    override open func draw(_ rect: CGRect) {
        super.draw(rect)

        textField.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)

    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        setUpProperty()
    }
    func setUpProperty() {
        //Change this properties to change the propperties of text
        textField = MDCTextField(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        textField.placeholder =  "Coupon"       //placeHolder
        textField.text = value
        
        //Change this properties to change the colors of border around text
        textFieldControllerFloating = MDCTextInputControllerOutlined(textInput: textField)

        textFieldControllerFloating.activeColor = primaryColor
        textFieldControllerFloating.floatingPlaceholderActiveColor = primaryColor
        textFieldControllerFloating.normalColor = UIColor.lightGray
        textFieldControllerFloating.inlinePlaceholderColor = UIColor.lightGray

        //Change this font to make borderRect bigger
        textFieldControllerFloating.inlinePlaceholderFont = UIFont.systemFont(ofSize: 14)
        textFieldControllerFloating.textInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))

        self.addSubview(textField)
    }

}
