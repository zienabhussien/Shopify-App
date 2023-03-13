//
//  SettingsVC.swift
//  Shopify App
//
//  Created by Sohila on 02/03/2023.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var SettingTable: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
  
    @IBAction func currency(_ sender: Any) {
        let alert = UIAlertController(title: "Currency", message: "Choose the currency", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "EGP", style: .default ,handler: {  [weak self] _ in
            UserDefaults.standard.set("EGP", forKey: "Currency")
        }))
       alert.addAction(UIAlertAction(title: "USD", style: .cancel ,handler: {  [weak self] _ in
           UserDefaults.standard.set("USD", forKey: "Currency")
       }))
        present(alert, animated: true)
    }
    
    @IBAction func logOut(_ sender: Any) {
     
        UserDefaults.standard.set(0, forKey: "loginId")
        self.navigationController?.popToRootViewController(animated: true)
        UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarVC")
    }
}
