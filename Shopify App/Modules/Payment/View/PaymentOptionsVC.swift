//
//  PaymentOptionsVC.swift
//  Shopify App
//
//  Created by Zienab on 01/03/2023.
//

import UIKit

class PaymentOptionsVC: UIViewController {

    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func continueToPayment(_ sender: Any) {
    }
    

}
extension PaymentOptionsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var title : String?
        if section == 0 {
            title = "Online Payment"
            return title
        }
        title = "More payment options"
        return title
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view:UIView, forSection: Int) {
        view.tintColor = .opaqueSeparator
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = .black
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentOptionCell", for: indexPath) as! PaymentOptionsCell
        if  indexPath.section == 0 {
            cell.checkPaymentWay.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        } else {
            cell.checkPaymentWay.setImage(UIImage(systemName: "circle"), for: .normal)
            cell.PaymentWayName.text = "Cash On Delivery (COD)"
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
