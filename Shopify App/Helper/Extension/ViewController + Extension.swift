//
//  ViewController + Extension.swift
//  Shopify App
//
//  Created by Ali Moustafa on 05/03/2023.
//

import Foundation
import UIKit

extension UIViewController{
    func showAlertError(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIViewController{
    
    func showConfirmAlert(title:String, message:String, complition:@escaping (Bool)->Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let confirmBtn = UIAlertAction(title: "Confirm", style: .destructive) { _ in
            complition(true)
        }
        alert.addAction(cancelBtn)
        alert.addAction(confirmBtn)
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIViewController{
    func showAlertForInterNetConnection(){
        let alert = UIAlertController(title: "network is not connected", message: "please, check your internet connection for using app..", preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
    }
}
