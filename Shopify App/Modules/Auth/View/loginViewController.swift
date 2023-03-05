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
    
    var loginViewModel : LoginViewModel!
    var isExist : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailView.addLayer()
        passwordView.addLayer()
        loginButton.addLayer()
        
        loginViewModel = LoginViewModel()
        
        loadDataFromURL { data, _ in
            print(data ?? "null")
        }
        
//        fetchFromApi { data in
//            print(data ?? "null")
//        }

        
    }
    
    
    func loadDataFromURL( completionHandeler: @escaping ((AllCustomers?), Error?) -> Void){
              let url = URL(string: "https://a546963db1d86b6cdc7f01928132e7f7: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@mad-4-ism2023.myshopify.com/admin/api/2023-01/customers.json")
              guard let url = url else{ return }
              let req = URLRequest(url: url)
              let session = URLSession(configuration: URLSessionConfiguration.default)
              let task = session.dataTask(with: req) { data, response, error in

                  if let error = error{
                      completionHandeler(nil, error)
                  }else{
                      let res = try? JSONDecoder().decode(AllCustomers.self, from: data!)
                      print(res?.customers[0])
      //                let movieArray = res?.items
                      completionHandeler(res, nil)
                  }
                      
              }
              task.resume()
          }
    
    
  
   
     func fetchFromApi(  complition: @escaping (AllCustomers? ) -> Void)  {
         let API_URL = "https://a546963db1d86b6cdc7f01928132e7f7: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@mad-4-ism2023.myshopify.com/admin/api/2023-01/customers.json"
        AF.request(API_URL).responseJSON { response in
            do
            {

                guard let responseData = response.data else {return}
                let result = try JSONDecoder().decode(AllCustomers.self, from: responseData)
                print(result)
                complition(result)

            }catch let error {
                complition(nil )
                print(error.localizedDescription)

            }
        }
    }
    
    
    @IBAction func didPressCreatAccount(_ sender: Any) {
        SingUp()
    }
    
    
    
    
    @IBAction func login(_ sender: Any) {
        
        loginViewModel.bindResultToLoginView = { [weak self] customers in
            
            DispatchQueue.main.async {
                self?.isExist = self?.loginViewModel.searchCustomer(currEmail: self?.emailTextFiled.text ?? "", allCustomers: customers)
                print(self?.isExist)
            }
            
        }
        loginViewModel.getAllCustomers()
        
        goToTabBar()
    }
    
    
    
    
    
    
    // create your account
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
        let storyboard =  UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "TabBarVC")
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
}


