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

