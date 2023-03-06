//
//  CreateAddressVC.swift
//  Shopify
//
//  Created by Ali Moustafa on 01/03/2023.
//

import UIKit

class CreateAddressVC: UIViewController {
    
 
    @IBOutlet weak var addAddressBtn: UIButton!
    @IBOutlet weak var countryTxt: UITextField!
    @IBOutlet weak var cityTxt: UITextField!
    @IBOutlet weak var AddressTxt: UITextField!
    @IBOutlet weak var phoneTxt: UITextField!
    
    var customerId = ""
    let networking = Networking()

    
//    let networking = Networking()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.hideKeyboardWhenTappedAround()
       custmoizeTextField()
        countryTxt.text = "Egypt"
      // custmoizeBtn()
    }
    
    func custmoizeTextField()
    {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: countryTxt.frame.height - 1, width: countryTxt.frame.width - 30, height: 1.0)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        countryTxt.borderStyle = UITextField.BorderStyle.none
        countryTxt.layer.addSublayer(bottomLine)
        
        let bottomLine2 = CALayer()
        bottomLine2.frame = CGRect(x: 0.0, y: countryTxt.frame.height - 1, width: countryTxt.frame.width - 30, height: 1.0)
        bottomLine2.backgroundColor = UIColor.gray.cgColor
        cityTxt.borderStyle = UITextField.BorderStyle.none
        cityTxt.layer.addSublayer(bottomLine2)
        
        
        let bottomLine3 = CALayer()
        bottomLine3.frame = CGRect(x: 0.0, y: countryTxt.frame.height - 1, width: countryTxt.frame.width - 30, height: 1.0)
        bottomLine3.backgroundColor = UIColor.gray.cgColor
        AddressTxt.borderStyle = UITextField.BorderStyle.none
        AddressTxt.layer.addSublayer(bottomLine3)
        
        
        let bottomLine1 = CALayer()
        bottomLine1.frame = CGRect(x: 0.0, y: countryTxt.frame.height - 1, width: countryTxt.frame.width - 30, height: 1.0)
        bottomLine1.backgroundColor = UIColor.gray.cgColor
        phoneTxt.borderStyle = UITextField.BorderStyle.none
        phoneTxt.layer.addSublayer(bottomLine1)
        
        
    }
    
    func custmoizeBtn()
    {
        addAddressBtn.backgroundColor = .clear
        addAddressBtn.layer.cornerRadius = 5
        addAddressBtn.layer.borderWidth = 1
        addAddressBtn.layer.borderColor = UIColor.tintColor.cgColor
    }
    
    @IBAction func didPressedOnAddAddress(_ sender: Any) {
        checkData()
        
        if AddressTxt.text != "" && cityTxt.text != "" && countryTxt.text != "" && phoneTxt.text != ""
        {
            guard let customerID = Helper.shared.getUserID(), let name = Helper.shared.getUserName(), let address = AddressTxt.text, !address.isEmpty, let country = countryTxt.text, !country.isEmpty, let city = cityTxt.text, !city.isEmpty, let phone = phoneTxt.text, !phone.isEmpty, phone.count == 11 else {
                showAlertError(title: "Missing Data", message: "Please fill your info")
                return
            }
            
            let add = Address(address1: address, city: city, province: "", phone: phone, zip: "", last_name: "", first_name: name, country: country, id: nil)
            
            networking.createAddress(customerId: customerID, address: add) { data , res, error in
                if error == nil{
                    print("success to create address")
                    Helper.shared.setFoundAdress(isFoundAddress: true)
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }else{
                    print("falied to create address")
                }
            }
        }
    }
    
    func checkData() {
        let titleMessage = "Missing Data"
        if countryTxt.text == "" {
            showAlertError(title: titleMessage, message: "Please enter your country name")
        }
            
        if cityTxt.text == "" {
            showAlertError(title: titleMessage, message: "Please enter your city name")
        }
            
        if AddressTxt.text == "" {
            showAlertError(title: titleMessage, message: "Please enter your address")
        }
            
        if phoneTxt.text == "" {
            showAlertError(title: titleMessage, message: "Please enter you phone number")
                
        } else {
            let check: Bool = validate(value: phoneTxt.text!)
            if check == false {
                self.showAlertError(title: "invalid data!", message: "please enter you phone number in correct format")
            }
        }
    }

    func validate(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{11}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: value)
        print("RESULT \(result)")
        return result
    }
}





