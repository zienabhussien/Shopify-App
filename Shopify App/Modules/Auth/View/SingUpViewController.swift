//
//  SingUpViewController.swift
//  E-Commerce
//
//  Created by Ali Moustafa on 01/03/2023.
//

import UIKit
import Alamofire

class SingUpViewController: UIViewController {

    @IBOutlet weak var nameView: UIView!

    @IBOutlet weak var nameTextFiled: UITextField!

    @IBOutlet weak var emailView: UIView!

    @IBOutlet weak var emailTextFiled: UITextField!

    @IBOutlet weak var passwordView: UIView!

    @IBOutlet weak var passwordTextFiled: UITextField!

    @IBOutlet weak var singUpButton: UIButton!

    @IBOutlet weak var alreadyHaveAnAccount: UIButton!

    struct customer {
        var first_name = "JackOne"
        var email  = "JackOne.lastnameson@example.com"
        var password  = "12345678"
        var password_confirmation  = "12345678"
        
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nameView.addLayer()
        emailView.addLayer()
        passwordView.addLayer()
        singUpButton.addLayer()
        
        
        test()
    }

    
    
    func test (){

        let params: Parameters = [
            "customer":[
                "first_name": "Jack",
                "last_name" : "Lastnameson",
                "email" :"steveWO.lastnameson@example.com",
                "phone":  "+15142546019",
                 "verified_email" : true,
                "addresses" : [
                  [
                    "address1": "123 Oak St",
                    "city": "Ottawa",
                    "province": "ON",
                    "phone": "555-1212",
                    "zip": "123 ABC",
                    "last_name": "Lastnameson",
                    "first_name": "Mother",
                    "country": "CA"
                  ] ],
                "password": "12345888",
                "password_confirmation":"12345888",
                "send_email_welcome" : false
        ]
     ]
        
        
        
        
        let url  = "https://a546963db1d86b6cdc7f01928132e7f7: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@mad-4-ism2023.myshopify.com/admin/api/2023-01/customers.json"
        
        
        

          AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
              switch response.result {
              case .success(let response):
                print(response)
              case .failure(let error):
                  print("fail")
                print(error.localizedDescription)
              }
          }
            
//            AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseData { response in
//
//                let data = response.data!
//                print(data)
////                switch response.result {
////
////                    case .success(let data):
////                        do {
//////                            let jsonObject = try JSONSerialization.jsonObject(with: data  ,options: .allowFragments) as! [Dictionary<String, AnyObject>
//////                            let arr = jsonObject["customers"] as! [Dictionary<String, Any>]
//////                            let customer1 = arr[0] as! Dictionary<String, Any>
//////
//////                            print((customer1["id"]) as! Int)
////                                print("yeee")
////
////
////                        } catch{
////                                  print(response.error)
////                            return
////                        }
////                    case .failure(let error):
////                        print(error)
////                }
//           }
//
        
    }


    @IBAction func goToLogin(_ sender: Any) {
        
        let storyboard =  UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "loginViewController")
        
        present(viewController, animated: true)
//        navigationController?.pushViewController(viewController, animated: true)
    }
    
  
}

