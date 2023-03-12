//
//  CreateAddressVC.swift
//  Shopify App
//
//  Created by Ali Moustafa on 05/03/2023.
//

import UIKit
import Toast_Swift
class CreateAddressVC: UIViewController {
    
 
    @IBOutlet weak var addAddressBtn: UIButton!
    @IBOutlet weak var countryTxt: UITextField!
    @IBOutlet weak var cityTxt: UITextField!
    @IBOutlet weak var AddressTxt: UITextField!
    @IBOutlet weak var phoneTxt: UITextField!
    
    let networking = Networking()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func didPressedOnAddAddress(_ sender: Any) {
        // Make Alert
        checkData()
        //
        if AddressTxt.text != "" && cityTxt.text != "" && countryTxt.text != "" && phoneTxt.text != ""
        {
            // value of id and Address's value (name, address, city and phone)
            guard let customerID = Helper.shared.getUserID(), let name = Helper.shared.getUserName(), let address = AddressTxt.text, !address.isEmpty, let country = countryTxt.text, !country.isEmpty, let city = cityTxt.text, !city.isEmpty, let phone = phoneTxt.text, !phone.isEmpty, phone.count == 11 else {
                showAlertError(title: "Missing Data", message: "Please fill your info")
                return
            }
            // variable to take Address's value
            let add = Address(address1: address, city: city, province: "", phone: phone, zip: "", last_name: "", first_name: name, country: country, id: nil)
            // method to send Address to API
            networking.createAddress(customerId: customerID, address: add) { data , res, error in
                if error == nil{
                    //print("success to create address")
                    // save state of Adress in UserDefaults
                    Helper.shared.setFoundAdress(isFoundAddress: true)
                    DispatchQueue.main.async {
                        self.view.makeToast("success to create address")
                        self.navigationController?.popViewController(animated: true)
                    }
                }else{
                    DispatchQueue.main.async {
                        self.view.makeToast("falied to create address")
                    }
                    //print("falied to create address")

                }
            }
            // finish method to send Address to API

        }
    }
    
    // Make Alert if text filed is empty
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
// Predicate for phone format
    func validate(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{11}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: value)
        //print("RESULT \(result)")
        return result
    }
}





