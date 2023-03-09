////
////  ChooseAddressVC.swift
////  Shopify App
////
////  Created by Zienab on 01/03/2023.
////
//
//import UIKit
//
//class ChooseAddressVC: UIViewController {
//
//    @IBOutlet weak var continueToPaymentBtn: UIButton!
//    @IBOutlet weak var tableView: UITableView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
//}
//
//extension ChooseAddressVC : UITableViewDataSource, UITableViewDelegate{
//    func numberOfSections(in tableView: UITableView) -> Int {
//        1
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseAddressCell", for: indexPath) as! ChooseAddressCell
//        return cell
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
//}
