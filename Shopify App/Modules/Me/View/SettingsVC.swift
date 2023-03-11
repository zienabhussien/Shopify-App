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
  
    @IBAction func logOut(_ sender: Any) {
     
        UserDefaults.standard.set(0, forKey: "loginId")
        self.navigationController?.popToRootViewController(animated: true)
        UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarVC")
    }
}
