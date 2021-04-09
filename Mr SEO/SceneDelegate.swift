//
//  SceneDelegate.swift
//  Fit U
//
//  Created by Mac on 20/01/21.
//

import UIKit
import Firebase

@available(iOS 13.0, *)
let scene = UIApplication.shared.connectedScenes.first
@available(iOS 13.0, *)
let sceneDelegate : SceneDelegate = (scene?.delegate as? SceneDelegate)!

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
      for urlContext in URLContexts {
          let url = urlContext.url
          Auth.auth().canHandle(url)
      }
      // URL not auth related, developer should handle it.
    }
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
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
        guard let _ = (scene as? UIWindowScene) else { return }
    }

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
    }


}

@available(iOS 13.0, *)
extension SceneDelegate{
    func setNoDataHome(){
        self.window?.rootViewController = storyBoards.LoginRegister.instantiateViewController(withIdentifier: "NavNoData")
        self.window?.makeKeyAndVisible()
    }
    func setHome(){
        let vc = storyBoards.Tabbar.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        let win = self.window ?? UIApplication.shared.keyWindow
        
        if(win != nil){
            win?.rootViewController = vc
            win?.makeKeyAndVisible()
        }
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
//    func setHome(){
//        let vc = storyBoards.LoginRegister.instantiateViewController(withIdentifier: "HomeNav")
//        let win = self.window ?? UIApplication.shared.keyWindow
//        if(win != nil){
//               win?.rootViewController = vc
//               win?.makeKeyAndVisible()
//        }
//    }
    func makeLoginAsRoot(){
            self.window?.rootViewController = storyBoards.LoginRegister.instantiateViewController(withIdentifier: "LoginNav")
        self.window?.makeKeyAndVisible()
    }
}
