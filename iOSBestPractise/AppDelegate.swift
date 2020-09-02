//
//  AppDelegate.swift
//  iOSBestPractise
//
//  Created by ajay singh thakur on 08/06/17.
//  Copyright © 2017 ajay singh thakur. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Fabric.with([Crashlytics.self])
        self.logUser()
        self.checkLoginAndLogout()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
extension AppDelegate {

    func logUser() {
        // TODO: Use the current user's information
        // You can call any combination of these three methods
        Crashlytics.sharedInstance().setUserEmail("user@fabric.io")
        Crashlytics.sharedInstance().setUserIdentifier("12345")
        Crashlytics.sharedInstance().setUserName("Test User")
    }
    
    func checkLoginAndLogout() -> Void {
    
        guard let logged = UserDefaults.standard.value(forKey: "login") as? Bool else {
            // not looged in
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let loginController = storyboard.instantiateViewController(withIdentifier: "InitialController") as! UINavigationController
            window?.rootViewController = loginController
            return
        }
        if logged != true { // show login
            window?.rootViewController = nil
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let loginController = storyboard.instantiateViewController(withIdentifier: "InitialController") as! UINavigationController
            window?.rootViewController = loginController
            window?.makeKeyAndVisible()
        }
        if logged == true {
        
            window?.rootViewController = nil
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainController = storyboard.instantiateViewController(withIdentifier: "InitialController") as! UITabBarController
            window?.rootViewController = mainController
            window?.makeKeyAndVisible()
            
        }
    }

}

