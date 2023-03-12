//
//  Helper.swift
//  Shopify App
//
//  Created by Ali Moustafa on 03/03/2023.
//

import Foundation
import Reachability

class Helper{
    static let shared = Helper()
    
    var reachability: Reachability?
    
    
    func setFoundAdress(isFoundAddress: Bool){
        UserDefaults.standard.set(isFoundAddress, forKey: "Address_Found")
    }
    
    func checkFoundAdress()-> Bool{
        return UserDefaults.standard.bool(forKey: "Address_Found")
    }
    
    func getUserID()-> Int?{
        return UserDefaults.standard.integer(forKey: "loginId")
    }
    
    func getUserName()-> String?{
        return "jumia"
//        return UserDefaults.standard.string(forKey: "User_Name")
    }
  
    
    func setTotalPrice(totalPrice:Double){
        UserDefaults.standard.set(totalPrice, forKey: "Total_Price")
    }
    
    func getTotalPrice()->Double?{
        return UserDefaults.standard.double(forKey: "Total_Price")
    }
    
}

extension Helper{
    func checkNetworkConnectionUsingRechability(complition: @escaping (Bool)-> Void){
        reachability = try! Reachability()
        guard let reachability = reachability else {return}
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                //print("Reachable via WiFi")
                complition(true)
            } else {
                //print("Reachable via Cellular")
                complition(true)
            }
        }
        reachability.whenUnreachable = { _ in
            //print("Not reachable")
            complition(false)
        }
        do {
            try reachability.startNotifier()
        } catch {
            //print("Unable to start notifier")
        }
    }
}
