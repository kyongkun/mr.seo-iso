//
//  AppDelegate.swift
//  Mr SEO
//
//  Created by Mac on 26/02/21.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import UserNotifications



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    var FCMdeviceToken:String = ""
    var deviceToken:String = ""
    var PushRedirectTo : String = ""
    var setAdminChatSHow = false
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarPreviousNextAllowedClasses.append(UIStackView.self)
        IQKeyboardManager.shared.toolbarPreviousNextAllowedClasses.append(UIView.self)
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysShow
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        Thread.sleep(forTimeInterval: 1.0)
        self.registerForRemoteNotification()
        FirebaseApp.configure()
        if (EstalimUser.shared.RememberMe != "false"){
            if (EstalimUser.shared.id != "" )
            {
                self.setHome()
            }
            else
            {
                self.makeLoginAsRoot()
            }
        }
        else{
            self.makeLoginAsRoot()
        }

        
        return true
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
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


}

extension AppDelegate{
    func setNoDataHome(){
        self.window?.rootViewController = storyBoards.LoginRegister.instantiateViewController(withIdentifier: "NavNoData")
        self.window?.makeKeyAndVisible()
    }
    func setChat(){
        let vc = storyBoards.Tabbar.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        vc.selectedIndex = 2
        let win = self.window ?? UIApplication.shared.keyWindow
        
        if(win != nil){
            win?.rootViewController = vc
            win?.makeKeyAndVisible()
        }
    }
    func setHome(){
        let vc = storyBoards.Tabbar.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        let win = self.window ?? UIApplication.shared.keyWindow
        
        if(win != nil){
            win?.rootViewController = vc
            win?.makeKeyAndVisible()
        }
    }
    func makeLoginAsRoot(){
        self.window?.rootViewController = storyBoards.LoginRegister.instantiateViewController(withIdentifier: "LoginNav")
        self.window?.makeKeyAndVisible()
    }
}
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    
    @available(iOS 10.0, *)
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//
//        // Called to let your app know which action was selected by the user for a given notification.
//        let userInfo = response.notification.request.content.userInfo as NSDictionary
//
//        let data_item = userInfo as NSDictionary
//
//        let push_type = data_item.value(forKey: "push_type") as! String
//
//        //        let Push = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContainerClassVC") as! ContainerClassVC
//    }
    // For iOS 9+
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
      if Auth.auth().canHandle(url) {
        return true
      }
    return false
      // URL not auth related, developer should handle it.
    }

    // For iOS 8-
    func application(_ application: UIApplication,
                     open url: URL,
                     sourceApplication: String?,
                     annotation: Any) -> Bool {
      if Auth.auth().canHandle(url) {
        return true
      }
        return false
      // URL not auth related, developer should handle it.
    }
    //MARK: - Register Remote Notification Methods // <= iOS 9.x
    func registerForRemoteNotification() {
        if #available(iOS 10.0, *) {
            let center  = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
                if error == nil {
                    DispatchQueue.main.async(execute: {
                        UIApplication.shared.registerForRemoteNotifications()
                    })
                }
            }
        } else {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    func application(_ application: UIApplication,
        didReceiveRemoteNotification notification: [AnyHashable : Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
      if Auth.auth().canHandleNotification(notification) {
        completionHandler(.noData)
        return
      }
        
      // This notification is not auth related, developer should handle it.
    }
    //MARK: - Remote Notification Methods // <= iOS 9.x
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        self.deviceToken = deviceTokenString
        let firebaseAuth = Auth.auth()
        Auth.auth().setAPNSToken(deviceToken, type: .unknown)
        
//        Auth.auth().setAPNSToken(deviceToken, type: .prod)

        print("deviceToken" ,deviceTokenString)
        //NSLog("The NutTagDeviceToken is:- \(deviceTokenString)")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

    
        if let userInfo = response.notification.request.content.userInfo as? NSDictionary {
            print("\(String(describing: userInfo))")
            
            let apsvalue = userInfo.value(forKey: "aps") as! NSDictionary
            let push_type = apsvalue.value(forKey: "push_type") as! Int
            print("value  : \(push_type)")
            
          
            switch push_type {
            case 1 :
                if #available(iOS 13.0, *) {
                    sceneDelegate.setChat()
                } else {
                    self.setChat()
                    // Fallback on earlier versions
                }
//
                break
            case 2 :
                self.setAdminChatSHow = true
                if #available(iOS 13.0, *) {
                    sceneDelegate.setChat()
                } else {
                    self.setChat()
                    // Fallback on earlier versions
                }
//
                break
           
            

            default:
                print("opration")
                break
            }
        }
        completionHandler()

        
    }
    
    // MARK: - UNUserNotificationCenter Delegate // >= iOS 10
    //Called when a notification is delivered to a foreground app.
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("User Info = ",notification.request.content.userInfo)
        if let userInfo = notification.request.content.userInfo as? NSDictionary {
            print("\(String(describing: userInfo))")
        }
        //completionHandler([.alert, .badge, .sound])
        if let userInfo = notification.request.content.userInfo as? NSDictionary {
            print("\(String(describing: userInfo))")
            if let payload  = userInfo.value(forKey: "payload") as? NSDictionary{
                if let data  = payload.value(forKey: "data") as? NSDictionary{
                    if let push_type  = data.value(forKey: "push_type") as? Int{
                        if(push_type == 1){
                            if UIApplication.topViewController() is ChatDetailsVC {
                                (UIApplication.topViewController() as? ChatDetailsVC)?.RefreshWithOutLoader()
                            }
                            else {
                                completionHandler([.alert, .badge, .sound])
                            }
                        }
                        else if(push_type == 2){
                            if UIApplication.topViewController() is AdminChatVC {
                                (UIApplication.topViewController() as? AdminChatVC)?.RefreshWithOutLoader()
                            }
                            else {
                                completionHandler([.alert, .badge, .sound])
                            }
                        }
                        else{
                                completionHandler([.alert, .badge, .sound])
                            
                        }
                    }
                }
            }
            let apsvalue = userInfo.getInt(key: "push_type")
            print("value  : \(apsvalue)")
//            if(apsvalue == 1){
//                if UIApplication.topViewController() is ChatDetailsVC {
//                    (UIApplication.topViewController() as? ChatDetailsVC)?.RefreshWithOutLoader()
//                }
//                else {
//                    completionHandler([.alert, .badge, .sound])
//                }
//            }
//            else{
//                    completionHandler([.alert, .badge, .sound])
//
//            }
        }
    }

}
