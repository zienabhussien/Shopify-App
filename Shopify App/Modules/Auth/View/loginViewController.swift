//
//  ViewController.swift
//  E-Commerce
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
    override func viewDidLoad() {
        super.viewDidLoad()
        emailView.addLayer()
        passwordView.addLayer()
        loginButton.addLayer()
        
        
        
    }
    
    
    
    
    @IBAction func didPressCreatAccount(_ sender: Any) {
        SingUp()
    }
    
    
    
    
    @IBAction func login(_ sender: Any) {
        
        goToTabBar()
    }
    
    
    
    
    
    
    
    func SingUp()
    {
        let storyboard =  UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SingUpViewController")
        navigationController?.pushViewController(viewController, animated: true)
        
        //
        //        let storyboard =  UIStoryboard(name: "Main", bundle: nil)
        //        let viewController = storyboard.instantiateViewController(withIdentifier: "SingUpViewController")
        //        let navigationController = UINavigationController(rootViewController: viewController)
        //        navigationController.modalPresentationStyle = .fullScreen
        //        present(navigationController, animated: true)
    }
    
    
    func goToTabBar()
    {
        //        let storyboard =  UIStoryboard(name: "Main", bundle: nil)
        //        let viewController = storyboard.instantiateViewController(withIdentifier: "TabBarVC")
        //        let navigationController = UINavigationController(rootViewController: viewController)
        ////        navigationController.modalPresentationStyle = .fullScreen
        //        present(navigationController, animated: true)
        
        
        
        let storyBoard = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        
        navigationController?.pushViewController(storyBoard, animated: true)
        
        
        
    }
    
    
    
    

    
    
    
    
}
