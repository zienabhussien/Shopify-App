//
//  PaymentOptionsVC.swift
//  Shopify App
//
//  Created by Zienab on 01/03/2023.
//

import UIKit
import PassKit
class PaymentOptionsVC: UIViewController {
    
    var selectedPaymentOption: String?
    var index: Int?
    var total = Helper.shared.getTotalPrice()
    lazy var totalPay = NSDecimalNumber(string: "\(total ?? 1.1)")
    //var totalprice = NSDecimalNumber(nonretainedObject: Helper.shared.getTotalPrice())
    //var price :NSDecimalNumber = NSDecimalNumber(nonretainedObject: Helper.shared.getTotalPrice())

    //MARK: - LOCAL PROPERTIES
    private lazy var paymentRequest : PKPaymentRequest = {
        let request = PKPaymentRequest ()
        request.merchantIdentifier = "merchant.com.pushpendra.pay"
        request.supportedNetworks = [.quicPay, .masterCard, .visa]
        request.supportedCountries = ["EG", "US" ]
        request.merchantCapabilities = .capability3DS
        request.countryCode = "EG"
        request.currencyCode = "EGP"
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "shopify", amount: totalPay)]
        return request}()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func continueToPayment(_ sender: Any) {
        

        let confirmPaymentVC = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmPaymentVC") as! ConfirmPaymentVC
        
        self.navigationController?.pushViewController(confirmPaymentVC, animated: true)
    }
}
extension PaymentOptionsVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
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
        
        if indexPath.section == 0 {
            let image = selectedPaymentOption == "Apple Pay" ? UIImage(systemName: "circle.fill") : UIImage(systemName: "circle")
            cell.checkPaymentWay.setImage(image, for: .normal)
            cell.PaymentWayName.text = "Apple Pay"
        } else {
            let image = selectedPaymentOption == "Cash On Delivery (COD)" ? UIImage(systemName: "circle.fill") : UIImage(systemName: "circle")
            cell.checkPaymentWay.setImage(image, for: .normal)
            cell.PaymentWayName.text = "Cash On Delivery (COD)"
        }
        
        return cell
    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            tapForPay ()
            selectedPaymentOption = "Apple Pay"
        } else {
            selectedPaymentOption = "Cash On Delivery (COD)"
        }
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension PaymentOptionsVC : PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment
                                            payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
    
    @objc func tapForPay (){
        let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
        if controller != nil{
            controller!.delegate = self
            present (controller!, animated: true)
        }
       
    }
}
