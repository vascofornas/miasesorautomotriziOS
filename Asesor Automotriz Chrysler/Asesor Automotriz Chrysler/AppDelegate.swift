//
//  AppDelegate.swift
//  Pedro Villarejo App Clientes
//
//  Created by MODESTO VASCO FORNAS on 1/8/16.
//  Copyright © 2016 Modesto Vasco. All rights reserved.
//

import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        
         
        
        
        [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
            // Initialize Parse.
            Parse.setApplicationId("BgMIR069diLQoLTF1vRm0E7IMhLQ31eQWaqba64S",
                clientKey: "8eqKjrvR8lVyJT3qUWHfBnSxTiX2Z8CE9wWPaY3k")
        
        
        //tiempo de espera para el launch screen
       Thread.sleep(forTimeInterval: 2.5)
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // This method will be called everytime you open the app
        // Register the deviceToken on Pushbots
       
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Notification Registration Error: ", error);
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        //Track notification only if the application opened from Background by clicking on the notification.
        if application.applicationState == .inactive  {
           
        }
        
        //The application was already active when the user got the notification, just show an alert.
        //That should *not* be considered open from Push.
        if application.applicationState == .active  {
            //Capture notification data e.g. badge, alert and sound
            if let aps = userInfo["aps"] as? NSDictionary {
                let alert = aps["alert"] as! String
                UIAlertView(title:"Push Notification!", message:alert, delegate:nil, cancelButtonTitle:"OK").show()
            }
        }
        
    }
   
}

