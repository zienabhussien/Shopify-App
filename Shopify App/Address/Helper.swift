//
//  Helper.swift
//  Shopify
//
//  Created by Ali Moustafa on 01/03/2023.
//

import Foundation
import Reachability

class Helper{
    static let shared = Helper()
    var reachability: Reachability?
    
    func setUserStatus(userIsLogged: Bool){
        UserDefaults.standard.set(userIsLogged, forKey: "User_Status")
    }
    
    func getUserStatus()-> Bool{
        return UserDefaults.standard.bool(forKey: "User_Status")
    }
    
    func setUserID(customerID: Int?){
        UserDefaults.standard.set(customerID, forKey: "User_ID")
    }
    
    func getUserID()-> Int?{
        return 6810028835106
//        return UserDefaults.standard.integer(forKey: "User_ID")
    }
    
    func setUserName(userName: String?){
        UserDefaults.standard.set(userName, forKey: "User_Name")
    }
    
    func getUserName()-> String?{
        return "jumia"

//        return UserDefaults.standard.string(forKey: "User_Name")
    }
    
    func setUserEmail(userEmail: String?){
        UserDefaults.standard.set(userEmail, forKey: "User_Email")
    }
    
    func getUserEmail()-> String?{
        return UserDefaults.standard.string(forKey: "User_Email")
    }
    
    func setTotalPrice(totalPrice:Double){
        UserDefaults.standard.set(totalPrice, forKey: "Total_Price")
    }
    
    func getTotalPrice()->Double?{
        return UserDefaults.standard.double(forKey: "Total_Price")
    }
    
    func setFoundAdress(isFoundAddress: Bool){
        UserDefaults.standard.set(isFoundAddress, forKey: "Address_Found")
    }
    
    func checkFoundAdress()-> Bool{
        return UserDefaults.standard.bool(forKey: "Address_Found")
    }
    func checkUserIsLogged(completion: @escaping (Bool) -> Void){
        if getUserStatus() {
            completion(true)
        }else{
            completion(false)
        }
    }
}

extension Helper{
    func checkNetworkConnectionUsingRechability(complition: @escaping (Bool)-> Void){
        reachability = try! Reachability()
        guard let reachability = reachability else {return}
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
                complition(true)
            } else {
                print("Reachable via Cellular")
                complition(true)
            }
        }
        reachability.whenUnreachable = { _ in
            print("Not reachable")
            complition(false)
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
}
