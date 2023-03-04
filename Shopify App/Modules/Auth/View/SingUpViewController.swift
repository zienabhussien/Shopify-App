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

    var signUpViewModel : SignupViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameView.addLayer()
        emailView.addLayer()
        passwordView.addLayer()
        singUpButton.addLayer()
        
        signUpViewModel = SignupViewModel()
        
        
        //postCustomer(name:  "www", email: "zzzz123@gmail.com", password: "12356789")

    }
        
    
    
//   func taskForPOSTRequest( body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
//
//       let url = URL(string: "https://a546963db1d86b6cdc7f01928132e7f7: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@mad-4-ism2023.myshopify.com/admin/api/2023-01/customers.json" )
//       let responseType = CustomerResponse(customer: <#T##Customer#>)
//
//
//
//            var request = URLRequest(url: url!)
//            request.httpMethod = "POST"
//            request.httpBody = try! JSONEncoder().encode(body)
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            let task = URLSession.shared.dataTask(with: request) { data, response, error in
//                guard let data = data else {
//                    DispatchQueue.main.async {
//                        completion(nil, error)
//                    }
//                    return
//                }
//                let decoder = JSONDecoder()
//                do {
//                    let responseObject = try decoder.decode(ResponseType.self, from: data)
//                    DispatchQueue.main.async {
//                        completion(responseObject, nil)
//                    }
//                } catch {
//                    print(error)
//                }
//            }
//            task.resume()
//        }

    
    @IBAction func signUp(_ sender: Any) {
//        let storyboard =  UIStoryboard(name: "Main", bundle: nil)
//        let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        signUpViewModel.createCustomer(name: nameTextFiled.text ?? "", email: emailTextFiled.text ?? "", password: passwordTextFiled.text ?? "")
    }
    

    @IBAction func goToLogin(_ sender: Any) {
        
        let storyboard =  UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "loginViewController")
        
        
        present(viewController, animated: true)
//        navigationController?.pushViewController(viewController, animated: true)
    }
    
  
}

