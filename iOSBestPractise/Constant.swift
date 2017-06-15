//
//  Constant.swift
//  iOSBestPractise
//
//  Created by ajay singh thakur on 08/06/17.
//  Copyright © 2017 ajay singh thakur. All rights reserved.
//

import UIKit
class LoginHelper {
    
    class func loginUser(target: AnyObject) {
        
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "InitialController")
        
        target.present(controller, animated: true, completion: nil)
        
    }
    class func showLoginScreen(_ target : Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = nil

        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let mainController = storyboard.instantiateViewController(withIdentifier: "InitialController") as! UINavigationController
        
        appDelegate.window?.rootViewController = mainController
        appDelegate.window?.makeKeyAndVisible()
    }
    
    class func showMainScreen(_ target : Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = nil
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainController = storyboard.instantiateViewController(withIdentifier: "InitialController") as! UITabBarController
       
        appDelegate.window?.rootViewController = mainController
        appDelegate.window?.makeKeyAndVisible()
    }
    
    
}
