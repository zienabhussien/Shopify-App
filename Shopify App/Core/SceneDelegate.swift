//
//  SceneDelegate.swift
//  Shopify App
//
//  Created by Zienab on 28/02/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        rootViewController()
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
           
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    func rootViewController() {
                    let userDefaultToken = UserDefaults.standard.integer(forKey: "loginId")
            print("userDefaultToken", userDefaultToken )
             //when log out delete value of this key
                if userDefaultToken != 0 {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let homeViewController = storyboard.instantiateViewController(withIdentifier: "TabBarVC")
                    let navigationController = UINavigationController(rootViewController: homeViewController)
                    window?.rootViewController = navigationController
                    window?.makeKeyAndVisible()
                    
                }else {
                       let storyboard = UIStoryboard(name: "Main", bundle: nil)
                       let loginViewController = storyboard.instantiateViewController(withIdentifier: "loginViewController")
                       let navigationController = UINavigationController(rootViewController: loginViewController)
                       window?.rootViewController = navigationController
                       window?.makeKeyAndVisible()
                    }
        }
    
//    func rootViewController() {
//        let userDefaultToken = UserDefaults.standard.string(forKey: "LoginToken")
//        print("userDefaultToken", userDefaultToken ?? "no id")
////when log out delete value of this key
//        if userDefaultToken != nil {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let loginViewController = storyboard.instantiateViewController(withIdentifier: "TabBarController")
//            let navigationController = UINavigationController(rootViewController: loginViewController)
//            window?.rootViewController = navigationController
//            window?.makeKeyAndVisible()
//        } else {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
//            let navigationController = UINavigationController(rootViewController: loginViewController)
//            window?.rootViewController = navigationController
//            window?.makeKeyAndVisible()
//        }
//    }

    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

