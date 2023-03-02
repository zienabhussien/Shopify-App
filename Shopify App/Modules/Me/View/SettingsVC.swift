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

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logoutAction(_ sender: Any) {
    }
}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! SettingCell
        
        switch indexPath.row {
        case 0:
            cell.firstLabel.text = "Address"
            cell.secondLabel.text = "ismailia"
        case 1:
            cell.firstLabel.text = "Currency"
            cell.secondLabel.text = "EGP"
        case 2:
            cell.firstLabel.text = "Contact Us"
            cell.secondLabel.text = ""
        default:
            cell.firstLabel.text = "About Us"
            cell.secondLabel.text = ""
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
}
