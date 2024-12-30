//
//  AppDelegate.swift
//  mazedash
//
//  Created by Clement Gan on 29/12/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
                
        let menuVC = MenuViewController()
        let navigationController = UINavigationController(rootViewController: menuVC)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

