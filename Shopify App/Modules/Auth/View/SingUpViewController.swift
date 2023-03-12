//
//  SingUpViewController.swift
//  Shopify App
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

    }


    @IBAction func signUp(_ sender: Any) {
        
        //        signUpViewModel.createCustomer(name: nameTextFiled.text ?? "", email: emailTextFiled.text ?? "", password: passwordTextFiled.text ?? "")
                if nameTextFiled.text!.isEmpty || emailTextFiled.text!.isEmpty || passwordTextFiled.text!.isEmpty {
                    self.showAlert(title: "⚠️", message: "Fields can't be empty!!")
                    
                }else{
                    
                    let params: [String : Any] = [
                        "customer":[
                            "first_name": nameTextFiled.text ?? "",
                            "email" :emailTextFiled.text ?? "",
                            "note": passwordTextFiled.text ?? "",
                        ]]
                    signUpViewModel.bindResToSignUp = { [weak self]  in
                        DispatchQueue.main.async {
                            if self?.signUpViewModel.statusCode == 201 {
                                self?.goToTabBar()
                                
                            }else{
                                // show worning alert
                                self?.showAlert(title: "⚠️", message: """
        • Enter password more than 5 characters
        • Email format: "name@gmail.com"
        • Try another email
        """)
                               // print("signup error")
                            }
                        }
                        
                    }
                    
                    signUpViewModel.postCustomer(params: params)
                }
                
            }
    
    @IBAction func goToLogin(_ sender: Any) {
        
        var loginVC = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
        navigationController?.pushViewController(loginVC, animated: true)
    }
    func showAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
        
    }
    func goToTabBar()
    {
//        let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
//        navigationController?.pushViewController(tabVC, animated: true)
        self.navigationController?.popToRootViewController(animated: true)

    }
  
}

