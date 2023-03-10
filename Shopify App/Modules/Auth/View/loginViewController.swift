//
//  ViewController.swift
//  Shopify App
//
//  Created by Ali Moustafa on 27/02/2023.
//

import UIKit
import Alamofire
class loginViewController: UIViewController {
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var loginViewModel : LoginViewModel!
    var isExist : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailView.addLayer()
        passwordView.addLayer()
        loginButton.addLayer()
        
        loginViewModel = LoginViewModel()

        
    }
    
    
    
    
    @IBAction func didPressCreatAccount(_ sender: Any) {
        SingUp()
    }
    
    
    
    
    @IBAction func login(_ sender: Any) {
        
        loginViewModel.bindResultToLoginView = { [weak self] customers in
            
            DispatchQueue.main.async {
                self?.isExist = self?.loginViewModel.searchCustomer(currEmail: self?.emailTextFiled.text ?? "",password: self?.passwordTextFiled.text ?? "" ,  allCustomers: customers)
            
                if  (self?.isExist)! {
                    // show toast for user
                    self?.goToTabBar()
                    
                }else{
                    self?.showAlert(title: "⚠️", message: "check your data please!")
                }
            }
            
        }
        loginViewModel.getAllCustomers()

    }
    
    
    
    
    func SingUp()
    {
        let storyboard =  UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SingUpViewController")
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    func goToTabBar()
    {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    func validateData(name:String, email: String,password: String ){
        
    }

    
    func showAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
        
    }
    
    
}
