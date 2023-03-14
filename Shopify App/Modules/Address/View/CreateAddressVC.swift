//
//  CreateAddressVC.swift
//  Shopify App
//
//  Created by Ali Moustafa on 05/03/2023.
//

import UIKit
import Toast_Swift
class CreateAddressVC: UIViewController {
    
    var fromMeTitle: Bool = false
    
    
    @IBOutlet weak var titleOfEditOrAdd: UILabel!
    
    @IBOutlet weak var titleOfbuttonEditOrAdd: UIButton!
    
    @IBOutlet weak var counterButton: UIButton!
    
    @IBOutlet weak var addAddressBtn: UIButton!
    @IBOutlet weak var countryTxt: UITextField!
    @IBOutlet weak var cityTxt: UITextField!
    @IBOutlet weak var AddressTxt: UITextField!
    @IBOutlet weak var phoneTxt: UITextField!
    
    
    var address: Address?
    
    
    
    let networking = Networking()
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        
        
        if fromMeTitle{
            titleOfEditOrAdd.text = "Edit Your Address"
            
            
            countryTxt.text = address?.country
            cityTxt.text = address?.city
            AddressTxt.text = address?.address1
            phoneTxt.text = address?.phone
            switch address?.country{
            case "United States":
                countrymenu(otherState: .off, USAState: .on, Egypttate: .off, SyriaState: .off)
            case "Syria":
                countrymenu(otherState: .off, USAState: .off, Egypttate: .off, SyriaState: .on)
            case "Egypt":
                countrymenu(otherState: .off, USAState: .off, Egypttate: .on, SyriaState: .off)
            default:
                countrymenu(otherState: .on, USAState: .off, Egypttate: .off, SyriaState: .off)
            }
            
            
            //          phoneTxt: UIT  titleOfbuttonEditOrAdd.setTitle(<#T##title: String?##String?#>, for: <#T##UIControl.State#>)
        }else{
            countrymenu(otherState: .on, USAState: .off, Egypttate: .off, SyriaState: .off)

        }
        
    }
    
    @IBAction func didPressedOnAddAddress(_ sender: Any) {
        
        
        
        if fromMeTitle{
            
            let params: [String : Any] = [
                "address":[
                    "id": address?.id ?? 0,
                    "address1": AddressTxt.text ?? "",
                    "country": countryTxt.text ?? "",
                    "phone" : phoneTxt.text ?? "",
                    "city" : cityTxt.text ?? ""
                    
                ]
            ]
            NetworkService.updateApi(adrressID: address?.id ?? 0, params: params) { (data: Address?, error) in
                
            }
        }else{
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
                    }
                }
                // finish method to send Address to API
                
            }
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
    
    
    
    
    
   
    
    
    
    
    func countrymenu(otherState: UIMenuElement.State, USAState: UIMenuElement.State,Egypttate: UIMenuElement.State,SyriaState: UIMenuElement.State){
        counterButton.menu = UIMenu(title: "Country", options: .singleSelection, children: [
            UIAction(title: "Other",state:otherState , handler: { [weak self] action in
                self?.countryTxt.text = ""
                self?.countryTxt.placeholder = "Enter your country"
            }),
            UIAction(title: "USA",state:USAState ,handler: { [weak self] action in
                self?.countryTxt.text = "USA"
            }),
            UIAction(title: "Egypt",state:Egypttate , handler: { [weak self] action in
                self?.countryTxt.text = "Egypt"
            }),
            UIAction(title: "Syria",state:SyriaState,handler: { [weak self] action in
                self?.countryTxt.text = "Syria"
            })
        ])
        
        counterButton.showsMenuAsPrimaryAction = true
        counterButton.changesSelectionAsPrimaryAction = true
    }
    
    
    
}





