//
//  ViewController.swift
//  E-Commerce
//
//  Created by Ali Moustafa on 27/02/2023.
//

import UIKit

class loginViewController: UIViewController {
@IBOutlet weak var emailView: UIView!
@IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var loginButton: UIButton!    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailView.addLayer()
        passwordView.addLayer()
        loginButton.addLayer()
    }


    
    
    @IBAction func didPressCreatAccount(_ sender: Any) {
        
        SingUp()
       
        
    }
    
    func SingUp()
    {
        let storyboard =  UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SingUpViewController")
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func goToTabBar()
    {
        let storyboard =  UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "tabBarController")
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    
}

