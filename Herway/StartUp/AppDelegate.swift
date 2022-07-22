//
//  AppDelegate.swift
//  MyRidePay
//
//  Created by Faizan Ali  on 2021/4/15.
//

import UIKit
import GoogleMaps
import Stripe
import FirebaseMessaging
import Firebase
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var redirect : RedirectHelper!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        Firebase.config()
        
        
        R.string.localizable.oK.tableName
        
        
        FirebaseApp.configure()
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
          )
        } else {
          let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
//        Messaging.messaging().delegate = self
        
        Messaging.messaging().token { (token, error) in
            if let err = error {
//                log.error(err.localizedDescription)
                return
            }
            Constants.Static.notificationToken = token!
            #if DEBUG
            print("notification token:")
            print(Constants.Static.notificationToken)
            #endif
        }
//        Messaging.messaging().autoInitEnabled = true
        
        
        if #available(iOS 13, *) {
            //It will start from SceneDelegate
            
        } else {
            
            let frame = UIScreen.main.bounds
            self.window = UIWindow(frame: frame)
            redirect = RedirectHelper(window: window)
            redirect.determineRoutes()
        }
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        GMSServices.provideAPIKey("AIzaSyDgxUkkfvb-L-bQyr5_WFbj18w2swdn1QY")
//        STPAPIClient.shared().publishableKey = "pk_live_51KGg5cDB90NRgbBGQZMApCtIZGbPbP2mfyevJDtr8UUITIQ5kndTxfaP0mX4nPl3fpDNQO8kVh3BNV3Y54FRIVA400Kb1t0M1K"
        Constants.setupConsVariables()
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: - Notifications
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        Messaging.messaging().apnsToken = deviceToken
        Messaging.messaging().token { (token, error) in
            if let err = error {
//                log.error(err.localizedDescription)
                return
            }
            Constants.Static.notificationToken = token!
            #if DEBUG
            print("notification token:")
            print(Constants.Static.notificationToken)
            #endif
        }
    }
    
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
//        Constants.Static.notificationToken = deviceTokenString
//        #if DEBUG
//        print("notification token:")
//        print(Constants.Static.notificationToken)
//        #endif
//    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        Constants.Static.notificationToken = "iOS"
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        /// Handle notification received
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        /// Log event
    }


}



extension UIApplication{
    
    static func window() -> UIWindow {
        
        if #available(iOS 13.0, *) {
            let sceneDelegate = UIApplication.shared.connectedScenes
                .first!.delegate as! SceneDelegate
            return sceneDelegate.window!
            
        } else {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.window!
            
        }
    }
}

import UserNotifications


extension AppDelegate: UNUserNotificationCenterDelegate {
  // Receive displayed notifications for iOS 10 devices.
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        
//    let userInfo = notification.request.content.userInfo
//
//    // With swizzling disabled you must let Messaging know about the message, for Analytics
//    // Messaging.messaging().appDidReceiveMessage(userInfo)
//
//    // ...
//
//    // Print full message.
//    print(userInfo)
//
//    // Change this to your preferred presentation option
//    completionHandler([[.alert, .sound]])
//  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo

    // ...

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // Print full message.
    print(userInfo)

    completionHandler()
  }
}
