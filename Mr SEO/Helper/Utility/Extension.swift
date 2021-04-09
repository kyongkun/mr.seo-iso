//
//  Extension.swift
//  SpiritVibe
//
//  Created by Mac on 26/12/19.
//  Copyright © 2019 Mac. All rights reserved.
//

//
//  Extension.swift
//  Dailies Task
//
//  Created by Malav's iMac on 9/9/19.
//  Copyright © 2019 agileimac-7. All rights reserved.
//

import Foundation
import UIKit

let tabBarTintColor: UIColor = UIColor.red
let navigationBarTitleColor: UIColor = UIColor.black
let navigationBarTintColor: UIColor = UIColor.blue
let navigationBarbarTintColor: UIColor = UIColor.red


extension UINavigationController
{
    func addCustomBottomLine(color:UIColor,height:Double)
    {
        //Hiding Default Line and Shadow
        navigationBar.setValue(true, forKey: "hidesShadow")
    
        //Creating New line
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width:0, height: height))
        lineView.backgroundColor = color
        navigationBar.addSubview(lineView)
    
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.widthAnchor.constraint(equalTo: navigationBar.widthAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        lineView.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor).isActive = true
        lineView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor).isActive = true
    }
}
extension UIFont {
    class func appFont_PoppinsBold(Size:CGFloat)->UIFont{
        
        if let font = UIFont.init(name: "Poppins-Bold", size: CGFloat(Size).proportionalFontSize()){
            return font
        } else {
            return UIFont.systemFont(ofSize: CGFloat(Size).proportionalFontSize())        }
    }
    
    
    class func appFont_PoppinsSemiBold(Size:CGFloat)->UIFont{
        
        if let font = UIFont.init(name: "Poppins-SemiBold", size: CGFloat(Size).proportionalFontSize()){
            return font
        } else {
return UIFont.systemFont(ofSize: CGFloat(Size).proportionalFontSize())        }
    }
    class func appFont_PoppinsRegular(Size:CGFloat)->UIFont{
           
           if let font = UIFont.init(name: "Poppins-Regular", size: CGFloat(Size).proportionalFontSize()){
               return font
           } else {
            return UIFont.systemFont(ofSize: CGFloat(Size).proportionalFontSize())
           }
       }
    class func appFont_PoppinsMedium(Size:CGFloat)->UIFont{
        
        if let font = UIFont.init(name: "Poppins-Medium", size: CGFloat(Size).proportionalFontSize()){
            return font
        } else {
return UIFont.systemFont(ofSize: CGFloat(Size).proportionalFontSize())        }
    }
   
   
}

 

extension UIFont {
    var bold: UIFont { return withWeight(.bold) }
    var semibold: UIFont { return withWeight(.semibold) }
    
    private func withWeight(_ weight: UIFont.Weight) -> UIFont {
        var attributes = fontDescriptor.fontAttributes
        var traits = (attributes[.traits] as? [UIFontDescriptor.TraitKey: Any]) ?? [:]
        
        traits[.weight] = weight
        
        attributes[.name] = nil
        attributes[.traits] = traits
        attributes[.family] = familyName
        
        let descriptor = UIFontDescriptor(fontAttributes: attributes)
        
        return UIFont(descriptor: descriptor, size: pointSize)
    }
}

extension CGFloat{
    
    init?(_ str: String) {
        guard let float = Float(str) else { return nil }
        self = CGFloat(float)
    }
    
    
    func twoDigitValue() -> String {
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        formatter.roundingMode = NumberFormatter.RoundingMode.halfUp //NumberFormatter.roundingMode.roundHalfUp
        
        
        //        let str : NSString = formatter.stringFromNumber(NSNumber(self))!
        let str = formatter.string(from: NSNumber(value: Double(self)))
        return str! as String;
    }
    
    
    
    func proportionalFontSize() -> CGFloat {
        
        var sizeToCheckAgainst = self
        
        if(IS_IPAD_DEVICE())    {
            //            sizeToCheckAgainst += 12
        }
        else {
            if(IS_IPHONE_6P_OR_6SP()) {
                sizeToCheckAgainst += 1
            }
            else if(IS_IPHONE_6_OR_6S()) {
                sizeToCheckAgainst += 0
            }
            else if(IS_IPHONE_5_OR_5S()) {
                sizeToCheckAgainst -= 1
            }
            else if(IS_IPHONE_4_OR_4S()) {
                sizeToCheckAgainst -= 2
            }
        }
        return sizeToCheckAgainst
    }
}

extension UIViewController {
    func convertDateFormat(inputDate: String) -> String {

         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "yyyy-MM-dd"

         let oldDate = olDateFormatter.date(from: inputDate)

         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "yyyy-MM-dd"

         return convertDateFormatter.string(from: oldDate!)
    }
    func reloadViewFromNib() {
          let parent = view.superview
          view.removeFromSuperview()
          view = nil
          parent?.addSubview(view) // This line causes the view to be reloaded
      }
    // get top most view controller helper method.
    static var topMostViewController : UIViewController {
        get {
            return UIViewController.topViewController(rootViewController: UIApplication.shared.keyWindow!.rootViewController!)
        }
    }
    
    fileprivate static func topViewController(rootViewController: UIViewController) -> UIViewController {
        guard rootViewController.presentedViewController != nil else {
            if rootViewController is UITabBarController {
                let tabbarVC = rootViewController as! UITabBarController
                let selectedViewController = tabbarVC.selectedViewController
                return UIViewController.topViewController(rootViewController: selectedViewController!)
            }
                
            else if rootViewController is UINavigationController {
                let navVC = rootViewController as! UINavigationController
                return UIViewController.topViewController(rootViewController: navVC.viewControllers.last!)
            }
            
            return rootViewController
        }
        
        return topViewController(rootViewController: rootViewController.presentedViewController!)
    }
}

public extension UIViewController {
    
    // MARK: - NavigationController Functions
    /// Set Appearance of UINavigationBar.
    func hideshowimg(val:Bool) -> Bool {
        if(val == true)
        {
            return false
        }
        else{
            return true
        }
    }
    
    func setWhiteStatusBar(){
        if #available(iOS 13.0, *) {
                      let app = UIApplication.shared
                      let statusBarHeight: CGFloat = app.statusBarFrame.size.height
                      
                      let statusbarView = UIView()
                      statusbarView.backgroundColor = UIColor.white
                      view.addSubview(statusbarView)
                    
                      statusbarView.translatesAutoresizingMaskIntoConstraints = false
                      statusbarView.heightAnchor
                          .constraint(equalToConstant: statusBarHeight).isActive = true
                      statusbarView.widthAnchor
                          .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
                      statusbarView.topAnchor
                          .constraint(equalTo: view.topAnchor).isActive = true
                      statusbarView.centerXAnchor
                          .constraint(equalTo: view.centerXAnchor).isActive = true
                    
                  } else {
                      let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
                      statusBar?.backgroundColor = UIColor.white
                        
                  }
    }
    func setblueStatusBar(){
           if #available(iOS 13.0, *) {
                         let app = UIApplication.shared
                         let statusBarHeight: CGFloat = app.statusBarFrame.size.height
                         
                         let statusbarView = UIView()
                         statusbarView.backgroundColor = UIColor.ThemeRedColor
                         view.addSubview(statusbarView)
                         statusbarView.translatesAutoresizingMaskIntoConstraints = false
                   //      statusbarView.heightAnchor
                      //       .constraint(equalToConstant: statusBarHeight).isActive = true
                         statusbarView.widthAnchor
                             .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
                         statusbarView.topAnchor
                             .constraint(equalTo: view.topAnchor).isActive = true
                         statusbarView.centerXAnchor
                             .constraint(equalTo: view.centerXAnchor).isActive = true
                       
                     } else {
                         let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
                         statusBar?.backgroundColor = UIColor.ThemeRedColor
                           
                     }
       }
    func setAppearanceOfNavigationBar() {
        
        // Set navigationbar tittle,bar item , backgeound color
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = navigationBarTintColor
        self.navigationController?.navigationBar.barTintColor = navigationBarbarTintColor
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: navigationBarTitleColor,
                                       NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0) ]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key: AnyObject]
        
        // Set navigationbar back image(remove 'Back' from navagation)
        let backImage = UIImage(named: "ic_back")?.withRenderingMode(.alwaysOriginal)
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        
        // Set status bar
        // self.setStatusBar()
        
        // Set image in navigation title
        // let imageViewTitle = UIImageView(image:ImageNamed(name: "skilliTextLogo"))
        // imageViewTitle.contentMode = .scaleAspectFit
        // self.navigationItem.titleView = imageViewTitle
    }
    func SetCommonNavigation(backbtnimgName:String)
    {
        setWhiteStatusBar()
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = .none
        self.navigationController?.view.backgroundColor = UIColor.white
              
        self.navigationController?.navigationBar.tintColor = UIColor.ThemeRedColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray,NSAttributedString.Key.font: UIFont.appFont_PoppinsSemiBold(Size: 18)]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let backImage = UIImage(named: backbtnimgName)?.withRenderingMode(.alwaysOriginal)
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
    
    func SetPopupNavigation(){
        //self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
                 self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.view.backgroundColor = .approveColor
                 self.navigationController?.navigationBar.backgroundColor = UIColor.clear
                 self.navigationController?.navigationBar.isTranslucent = true
        if #available(iOS 13.0, *) {
                              let app = UIApplication.shared
                              let statusBarHeight: CGFloat = app.statusBarFrame.size.height
                              
                              let statusbarView = UIView()
                              statusbarView.backgroundColor = UIColor.white
                              view.addSubview(statusbarView)
                            
                              statusbarView.translatesAutoresizingMaskIntoConstraints = false
                              statusbarView.heightAnchor
                                  .constraint(equalToConstant: statusBarHeight).isActive = true
                              statusbarView.widthAnchor
                                  .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
                              statusbarView.topAnchor
                                  .constraint(equalTo: view.topAnchor).isActive = true
                              statusbarView.centerXAnchor
                                  .constraint(equalTo: view.centerXAnchor).isActive = true
                            
                          } else {
                              let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
                              statusBar?.backgroundColor = UIColor.white
                                
                          }
        
        
    }
    func SetTheameNavigation()
    {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .ThemeRedColor
        setblueStatusBar()
//         // self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//                 self.navigationController?.navigationBar.shadowImage = .none
//
//                 self.navigationController?.view.backgroundColor = UIColor.themeBlueColor
//
//          self.navigationController?.navigationBar.tintColor = UIColor.white
//          self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont.appFont_MontserratMedium(Size: 18)]
//          self.navigationController?.navigationBar.isTranslucent = false
//          navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
//          navigationController?.navigationBar.shadowImage = UIImage()
//
//        let backImage = UIImage(#imageLiteral(resourceName: "ic_backWhite")).withRenderingMode(.alwaysOriginal)
//        self.navigationController?.navigationBar.backIndicatorImage = backImage
//        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
//        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
//        setblueStatusBar()
        
        
    }
    func navBar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,NSAttributedString.Key.font: UIFont.appFont_PoppinsSemiBold(Size: 18)]
        self.navigationController?.navigationBar.tintColor = UIColor.ThemeRedColor

    }
    func SetProfileNavigation()
       {
             self.navigationController?.navigationBar.barTintColor = UIColor.white
             self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
                    self.navigationController?.navigationBar.shadowImage = .none
             
                    self.navigationController?.view.backgroundColor = UIColor.white
                 
             self.navigationController?.navigationBar.tintColor = UIColor.HeaderTitleBlackColor
             self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.HeaderTitleBlackColor,NSAttributedString.Key.font: UIFont.appFont_PoppinsSemiBold(Size: 18)]
             self.navigationController?.navigationBar.isTranslucent = false
             navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
             navigationController?.navigationBar.shadowImage = UIImage()
         
//
           
       }
    //Home Navigationbar
    func setHomeNavigationBar() {
   
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(.none, for: .default)
               self.navigationController?.navigationBar.shadowImage = .none
               self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont.appFont_PoppinsSemiBold(Size: 18)]
        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    /// Set Translucent of UINavigationBar.
    func setTranslucentOfNavigationBar() {
        
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.view.backgroundColor = .white
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    /// Hide bottom line from UINavigationBar.
//    func hideBottomLine() {
//        self.navigationController?.navigationBar.hideBottomHairline()
//    }
    
    /// Default push mathord.
    ///
    /// - Parameter viewController: your viewcontroller(String)
    func pushTo(_ viewController: String) {
        
        self.navigationController?.pushViewController((self.storyboard?.instantiateViewController(withIdentifier: viewController))!, animated: true)
    }
    
    /// Default pop mathord.
    func popTo() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Default pop to root controller.
    func popToRoot() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    /// Default present methord
    ///
    /// - Parameter viewController: your viewcontroller(String)
    func presentTo(_ viewController: String) {
        let VC1 = self.storyboard?.instantiateViewController(withIdentifier: viewController)
        let navController = UINavigationController(rootViewController: VC1!)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
    
    /// Default dismiss methord
    func dismissTo() {
        self.navigationController?.dismiss(animated: true, completion: {})
    }
    
    // MARK: - NavigationBar Functions
    /// Remove navigation bar item
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
    }
    
    /// Show or hide navigation bar
    ///
    /// - Parameter isShow: Bool(true, false)
    func showNavigationBar(_ isShow: Bool) {
        self.navigationController?.isNavigationBarHidden = !isShow
    }
    
    // Right,left buttons
    /// Set left side Navigationbar button image.
    ///
    /// - Parameters:
    ///   - Name: set image name
    ///   - selector: return selector
    func setLeftBarButtonImage(_ name: String, selector: Selector) {
        if self.navigationController != nil {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: name), style: .plain, target: self, action: selector)
        }
    }
    
    /// Set left side Navigationbar button title.
    ///
    /// - Parameters:
    ///   - Name: button name
    ///   - selector: return selector
    func setLeftBarButtonTitle(_ name: String, selector: Selector) {
        if self.navigationController != nil {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: name, style: UIBarButtonItem.Style.plain, target: self, action: selector)
        }
    }
    
    /// Set right side Navigationbar button image.
    ///
    /// - Parameters:
    ///   - Name: set image name
    ///   - selector: return selector
    func setRightBarButtonImage(_ name: String, selector: Selector) {
        if self.navigationController != nil {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: name), style: .plain, target: self, action: selector)
        }
    }
    
    /// Set right side Navigationbar button title.
    ///
    /// - Parameters:
    ///   - Name: button name
    ///   - selector: return selector
    func setRightBarButtonTitle(_ name: String, selector: Selector) {
        if self.navigationController != nil {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: name, style: UIBarButtonItem.Style.plain, target: self, action: selector)
        }
    }
    
    /// Set right side two Navigationbar button image.
    ///
    /// - Parameters:
    ///   - btn1Name: First button image name
    ///   - selector1: Second button selector
    ///   - btn2Name: First button image name
    ///   - selector2: Second button selector
    func setThreeRightBarButtonImage(_ btn1Name: String, selector1: Selector, btn2Name: String, selector2: Selector, btn3Name: String, selector3: Selector) {
        if self.navigationController != nil {
            let barBtn1: UIBarButtonItem =  UIBarButtonItem(image: UIImage(named: btn1Name), style: .plain, target: self, action: selector1)
            let barBtn2: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: btn2Name), style: .plain, target: self, action: selector2)
            let barBtn3: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: btn3Name), style: .plain, target: self, action: selector3)
            let buttons: [UIBarButtonItem] = [barBtn1, barBtn2,barBtn3]
            self.navigationItem.rightBarButtonItems = buttons
        }
    }
    
    /*
     func setRightBarButtonTitle(_ Name : String, selector : Selector) {
     
     if (self.navigationController != nil) {
     var barButton : UIBarButtonItem = UIBarButtonItem()
     barButton = UIBarButtonItem.init(title:Name.localized, style: UIBarButtonItemStyle.plain, target: self, action: selector)
     barButton.setTitleTextAttributes([ NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18.0),
     NSAttributedStringKey.foregroundColor : UIColor.white,
     NSAttributedStringKey.backgroundColor:UIColor.white],
     for: UIControlState())
     self.navigationItem.rightBarButtonItem = barButton
     }
     }
     */
    
    // MARK: - TabBar Functions
    /// Set TabBar visiblity
    ///
    /// - Parameter visible: Bool
    func setTabBarVisible(visible: Bool) {
        
        if self.tabBarIsVisible() == visible { return }
        let frame = self.tabBarController?.tabBar.frame
        let height = frame?.size.height
        let offsetY = (visible ? -60 : height) ?? 0
        
        self.tabBarController?.tabBar.frame.offsetBy(dx: 0, dy: offsetY)
        self.tabBarController?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: (self.view.frame.height + offsetY))
        self.tabBarController?.view.setNeedsDisplay()
        self.tabBarController?.view.layoutIfNeeded()
    }
    
    /// Check TabBar visible or not
    ///
    /// - Returns: Bool(true, false)
    func tabBarIsVisible() -> Bool {
        return self.tabBarController?.tabBar.frame.origin.y ?? 00 < UIScreen.main.bounds.height
    }
    
    /// Set AppearanceOfTabBar
    func setAppearanceOfTabBar() {
        self.tabBarController?.tabBar.isTranslucent = false
        self.tabBarController?.tabBar.tintColor = tabBarTintColor
    }
    
    /// Remove TabBar
    func removeTabBar() {
        self.tabBarController?.tabBar.isHidden = true
    }
    func loginToContinue(){}
    // MARK: - UIViewController Functions
    /// Load your VieweContoller
    ///
    /// - Returns: self
    class func loadController(strStoryBoardName: String = "Main") -> Self {
        return instantiateViewControllerFromMainStoryBoard(strStoryBoardName: strStoryBoardName)
    }
    
    /// Set instantiat ViewController
    ///
    /// - Returns: self
    private class func instantiateViewControllerFromMainStoryBoard<T>(strStoryBoardName: String) -> T {
        guard let controller  = UIStoryboard(name: strStoryBoardName, bundle: nil).instantiateViewController(withIdentifier: String(describing: self)) as? T else {
            fatalError("Unable to find View controller with identifier")
        }
        return controller
    }
    
    /// Set status bar background color
    ///
    /// - Parameter color: your color
    func setStatusBarBackgroundColor(color: UIColor) {
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = color
    }
    
    /// Set status bar style
    ///
    /// - Parameter style: statusbar style
    func setStatusBar(style: UIStatusBarStyle = .lightContent) {
        UIApplication.shared.statusBarStyle = style
    }
    
    /// Return Top Controller from window
    static var topMostController: UIViewController {
        if let topVC = UIViewController.topViewController() {
            return topVC
        }
        else if let window =  UIApplication.shared.delegate!.window, let rootVC = window?.rootViewController {
            return rootVC
        }
        return UIViewController()
    }
    
    private class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
extension UITextField{}
extension UICollectionView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = UIColor.HeaderInfoGrayColor
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .left
        messageLabel.font = UIFont.appFont_PoppinsRegular(Size: 10)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
    }

    func restore() {
        self.backgroundView = nil
    }
}
extension UIResponder {
    /**
     * Returns the next responder in the responder chain cast to the given type, or
     * if nil, recurses the chain until the next responder is nil or castable.
     */
    func next<U: UIResponder>(of type: U.Type = U.self) -> U? {
        return self.next.flatMap({ $0 as? U ?? $0.next() })
    }
}

extension UITableViewCell {
    var tableView: UITableView? {
            return self.next(of: UITableView.self)
        }

        var indexPath: IndexPath? {
            return self.tableView?.indexPath(for: self)
        }
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
    
}
public extension CGFloat {
    
    func toRadians() -> CGFloat {
        return self / (180 * .pi)
    }
    
    func toDegrees() -> CGFloat {
        return self * (180 * .pi)
    }
}

public extension UIImage {

func imageRotatedByDegrees(degrees: CGFloat) -> UIImage {
        
        // calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox = UIView(frame: CGRect(origin: .zero, size: size))
        let t = CGAffineTransform(rotationAngle: degrees.toRadians());
        rotatedViewBox.transform = t
        let rotatedSize = rotatedViewBox.frame.size
        
        // Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        if let bitmap = UIGraphicsGetCurrentContext() {
            
            bitmap.translateBy(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0)
            
            //   // Rotate the image context
            bitmap.rotate(by: degrees.toRadians())
            
            // Now, draw the rotated/scaled image into the context
            bitmap.scaleBy(x: 1.0, y: -1.0)
            
            if let cgImage = self.cgImage {
                bitmap.draw(cgImage, in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))
            }
            
            guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { debugPrint("Failed to rotate image. Returning the same as input..."); return self }
            UIGraphicsEndImageContext()
            
            return newImage
        }else {
            debugPrint("Failed to create graphics context. Returning the same as input...")
            return self
        }

    }

}
private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
               return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        //let t = textField.text
        if let t: String = textField.text {
            textField.text = String(t.prefix(maxLength))
        }
        //textField.text = t?.prefix(maxLength).string
    }
}

public extension UITableView {
    
    /**
     Register nibs faster by passing the type - if for some reason the `identifier` is different then it can be passed
     - Parameter type: UITableViewCell.Type
     - Parameter identifier: String?
     */
    func registerCell(type: UITableViewCell.Type, identifier: String? = nil) {
        let cellId = String(describing: type)
        register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: identifier ?? cellId)
    }
    
    /**
     DequeueCell by passing the type of UITableViewCell
     - Parameter type: UITableViewCell.Type
     */
    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier) as? T
    }
    
    /**
     DequeueCell by passing the type of UITableViewCell and IndexPath
     - Parameter type: UITableViewCell.Type
     - Parameter indexPath: IndexPath
     */
    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as? T
    }
    
}

public extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
extension UITableView {
    
    func setDefaultProperties(vc:UIViewController){
        self.separatorStyle = .none
        self.dataSource = vc as? UITableViewDataSource
        self.delegate = vc as? UITableViewDelegate
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
    }
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = UIColor.HeaderInfoGrayColor
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.appFont_PoppinsSemiBold(Size: 18)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
extension UIColor {
    
    static let HeaderTitleBlackColor =  UIColor(red: 49.0/255.0, green: 48.0/255.0, blue: 50.0/255.0, alpha: 1.0)
    static let HeaderInfoGrayColor:UIColor = UIColor.init(red: 118.0/255.0, green: 112.0/255.0, blue: 123.0/255.0, alpha: 1.0)
    static let PlaceholderGrayColor:UIColor = UIColor.init(red: 182.0/255.0, green: 182.0/255.0, blue: 182.0/255.0, alpha: 1.0)
     static let TextFieldGrayColor:UIColor = UIColor.init(red: 87.0/255.0, green: 87.0/255.0, blue: 87.0/255.0, alpha: 1.0)
    static let SubmitButtonColor:UIColor = UIColor.init(red: 118.0/255.0, green: 112.0/255.0, blue: 123.0/255.0, alpha: 1.0)
     static let TitleButtonColor:UIColor = UIColor.init(red: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
    static let BodyInfoLightGrayColor:UIColor = UIColor.init(red: 199.0/255.0, green: 199.0/255.0, blue: 199.0/255.0, alpha: 1.0)
    static let ThemeRedColor:UIColor = UIColor.init(red: 240.0/255.0, green: 174.0/255.0, blue: 184.0/255.0, alpha: 1.0)
    static let Themegradiant1:UIColor = UIColor.init(red: 118.0/255.0, green: 112.0/255.0, blue: 123.0/255.0, alpha: 1.0)
    static let Themegradiant2:UIColor = UIColor.init(red: 240.0/255.0, green: 174.0/255.0, blue: 184.0/255.0, alpha: 1.0)
    static let TextFieldBorderColor:UIColor = UIColor.init(red: 226.0/255.0, green: 230.0/255.0, blue: 234.0/255.0, alpha: 1.0)
    static let themeBlueColor:UIColor = UIColor.init(red: 61.0/255.0, green: 189.0/255.0, blue: 234.0/255.0, alpha: 1.0)
    static let cellBorderColor:UIColor = UIColor.init(red: 238.0/255.0, green: 238.0/255.0, blue: 238.0/255.0, alpha: 1.0)
    static let dashedBorder:UIColor = UIColor.init(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 0.1)
    
    static let themeShadowColor:UIColor = UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.1)
    
    static let themeGrayColor:UIColor = UIColor.init(red: 166/255.0, green: 166/255.0, blue: 166/255.0, alpha: 1.0)
    
    static let themeBlueColorUneri:UIColor = UIColor.init(red: 13/255.0, green: 116/255.0, blue: 148/255.0, alpha: 1.0)

    static let themeGreenColorUneri =  UIColor(red: 55.0/255.0, green: 158.0/255.0, blue: 135.0/255.0, alpha: 1.0)

    
    static let redColor:UIColor = UIColor.init(red: 250/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
    
    static let orangeColor:UIColor = UIColor.init(red: 248/255.0, green: 90/255.0, blue: 84/255.0, alpha: 1.0)

    
    static let yellowColor:UIColor = UIColor.init(red: 255/255.0, green: 196/255.0, blue: 03/255.0, alpha: 1.0)

    static let approveColor:UIColor = UIColor.init(red: 100/255.0, green: 183/255.0, blue: 163/255.0, alpha: 1.0)

    
    static let healthfirst:UIColor = UIColor.init(red: 98/255.0, green: 108/255.0, blue: 229/255.0, alpha: 1.0)
    
    static let healthsecond:UIColor = UIColor.init(red: 47/255.0, green: 132/255.0, blue: 161/255.0, alpha: 1.0)

    
    static let healththird:UIColor = UIColor.init(red: 54/255.0, green: 144/255.0, blue: 155/255.0, alpha: 1.0)

    
    static let healthfour:UIColor = UIColor.init(red: 67/255.0, green: 74/255.0, blue: 164/255.0, alpha: 1.0)
    
    static let healthfive:UIColor = UIColor.init(red: 79/255.0, green: 162/255.0, blue: 145/255.0, alpha: 1.0)

    

    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    static func themeTintColor() -> UIColor {
        return UIColor.init(red: 0, green: 122, blue: 255)
    }
    
    
}


public extension UIAlertController {
    
    /// Show AlertController with message only
    ///
    /// - Parameters:
    ///   - message: set your message
    ///   - buttonTitles: set button array
    ///   - buttonAction: return button click block
    static func showAlert(withMessage message: String,
                                 buttonTitles: [String] = ["확인"],
                                 buttonAction: ((_ index: Int) -> Void)? = nil) {
        var appName = ""
        if let dict = Bundle.main.infoDictionary, let name = dict[kCFBundleNameKey as String] as? String {
            appName = name
        }
        
        self.showAlert(withTitle: appName,
                       withMessage: message,
                       buttonTitles: buttonTitles,
                       buttonAction: buttonAction)
        
    }
    
    /// Show AlertController with message and title
    ///
    /// - Parameters:
    ///   - title: set your title
    ///   - message: set your message
    ///   - buttonTitles: set button array
    ///   - buttonAction: return button click block
    static func showAlert(withTitle title: String,
                                 withMessage message: String,
                                 buttonTitles: [String],
                                 buttonAction: ((_ index: Int) -> Void)?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for btn in buttonTitles {
            alertController.addAction(UIAlertAction(title: btn, style: .default, handler: { (_) in
                if let validHandler = buttonAction {
                    validHandler(buttonTitles.firstIndex(of: btn)!)
                }
            }))
        }
        // (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController?.present(alertController, animated: true, completion: nil)
        UIApplication.shared.delegate!.window!?.rootViewController?.present(alertController, animated: true, completion: nil)
        
    }
    
    /// Show Actionsheet with message only
    ///
    /// - Parameters:
    ///   - vc: where you display (UIViewController)
    ///   - message: your message
    ///   - buttons: button array
    ///   - canCancel: with cancel button
    ///   - completion: completion handler
    static func showActionSheetFromVC(_ viewController: UIViewController,
                                             andMessage message: String,
                                             buttons: [String],
                                             canCancel: Bool,
                                             completion: ((_ index: Int) -> Void)?) {
        var appName = ""
        if let dict = Bundle.main.infoDictionary, let name = dict[kCFBundleNameKey as String] as? String {
            appName = name
        }
        
        self.showActionSheetWithTitleFromVC(viewController,
                                            title: appName,
                                            andMessage: message,
                                            buttons: buttons,
                                            canCancel: canCancel,
                                            completion: completion)
    }
    
    /// Show Actionsheet with message and title
    ///
    /// - Parameters:
    ///   - vc: where you display (UIViewController)
    ///   - title: Alert title
    ///   - message: your message
    ///   - buttons: button array
    ///   - canCancel: with cancel button
    ///   - completion: completion handler
    static func showActionSheetWithTitleFromCurrentVC(_ message: String,
                                               buttons: [String],
                                               canCancel: Bool,
                                               completion: ((_ index: Int) -> Void)?) {
        
        
        if let viewController = appDelegate.window?.rootViewController
        {
        var appName = ""
        if let dict = Bundle.main.infoDictionary, let name = dict[kCFBundleNameKey as String] as? String {
            appName = name
        }
        
        
        
        let alertController = UIAlertController(title: appName, message: message, preferredStyle: .actionSheet)
        
        for index in 0..<buttons.count {
            
            let action = UIAlertAction(title: buttons[index], style: .default, handler: { (_) in
                if let handler = completion {
                    handler(index)
                }
            })
            alertController.addAction(action)
        }
        
        if canCancel {
            let action = UIAlertAction(title: "취소", style: .cancel, handler: { (_) in
                if let handler = completion {
                    handler(buttons.count)
                }
            })
            
            alertController.addAction(action)
        }
        
        if UIDevice.isIpad {
            
            if viewController.view != nil {
                alertController.popoverPresentationController?.sourceView = viewController.view
                alertController.popoverPresentationController?.sourceRect = CGRect(x: 0, y: (viewController.view?.frame.size.height)!, width: 1.0, height: 1.0)
            } else {
                alertController.popoverPresentationController?.sourceView = UIApplication.shared.delegate!.window!?.rootViewController!.view
                alertController.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
            }
        }
        viewController.present(alertController, animated: true, completion: nil)
        }
    }
    
    /// Show Actionsheet with message and title
    ///
    /// - Parameters:
    ///   - vc: where you display (UIViewController)
    ///   - title: Alert title
    ///   - message: your message
    ///   - buttons: button array
    ///   - canCancel: with cancel button
    ///   - completion: completion handler
    static func showActionSheetWithTitleFromVC(_ viewController: UIViewController,
                                                      title: String,
                                                      andMessage message: String,
                                                      buttons: [String],
                                                      canCancel: Bool,
                                                      completion: ((_ index: Int) -> Void)?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for index in 0..<buttons.count {
            
            let action = UIAlertAction(title: buttons[index], style: .default, handler: { (_) in
                if let handler = completion {
                    handler(index)
                }
            })
            alertController.addAction(action)
        }
        
        if canCancel {
            let action = UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
                if let handler = completion {
                    handler(buttons.count)
                }
            })
            
            alertController.addAction(action)
        }
        
        if UIDevice.isIpad {
            
            if viewController.view != nil {
                alertController.popoverPresentationController?.sourceView = viewController.view
                alertController.popoverPresentationController?.sourceRect = CGRect(x: 0, y: (viewController.view?.frame.size.height)!, width: 1.0, height: 1.0)
            } else {
                alertController.popoverPresentationController?.sourceView = UIApplication.shared.delegate!.window!?.rootViewController!.view
                alertController.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
            }
        }
        viewController.present(alertController, animated: true, completion: nil)
    }
}


public extension UIDevice {
    
    enum DeviceType: Int {
        case iPhone4or4s
        case iPhone5or5s
        case iPhone6or6s
        case iPhone6por6sp
        case iPhoneXorXs
        case iPhoneXrorXsMax
        case iPad
    }
    
    /// Check Decide type
    static var deviceType: DeviceType {
        // Need to match width also because if device is in portrait mode height will be different.
        if UIDevice.screenHeight == 480 || UIDevice.screenWidth == 480 {
            return DeviceType.iPhone4or4s
        } else if UIDevice.screenHeight == 568 || UIDevice.screenWidth == 568 {
            return DeviceType.iPhone5or5s
        } else if UIDevice.screenHeight == 667 || UIDevice.screenWidth == 667 {
            return DeviceType.iPhone6or6s
        } else if UIDevice.screenHeight == 736 || UIDevice.screenWidth == 736 {
            return DeviceType.iPhone6por6sp
        } else if UIDevice.screenHeight == 812 || UIDevice.screenWidth == 812 {
            return DeviceType.iPhoneXorXs
        } else if UIDevice.screenHeight == 896 || UIDevice.screenWidth == 896 {
            return DeviceType.iPhoneXorXs
        } else {
            return DeviceType.iPad
        }
    }
    
    /// Check device is Portrait mode
    static var isPortrait: Bool {
        return UIDevice.current.orientation.isPortrait
    }
    
    /// Check device is Landscape mode
    static var isLandscape: Bool {
        return UIDevice.current.orientation.isLandscape
    }
    
    // MARK: - Device Screen Height
    
    /// Return screen height
    static var screenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    // MARK: - Device Screen Width
    
    /// Return screen width
    static var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    /// Return screen size
    static var screenSize: CGSize {
        return UIScreen.main.bounds.size
    }
    
    /// Return device model name
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    // MARK: - Device is iPad
    /// Return is iPad device
    static var isIpad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    // MARK: - Device is iPhone
    
    /// Return is iPhone device
    static var isIphone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
}

extension UIImageView{
    func FlipForAR() {
        self.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
    func FlipForEn() {
        self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
    }
}
extension UIImage {
    
    func resizeImage(_ dimension: CGFloat, opaque: Bool, contentMode: UIView.ContentMode = .scaleAspectFit) -> UIImage {
        var width: CGFloat
        var height: CGFloat
        var newImage: UIImage
        
        let size = self.size
        let aspectRatio =  size.width/size.height
        
        switch contentMode {
        case .scaleAspectFit:
            if aspectRatio > 1 {                            // Landscape image
                width = dimension
                height = dimension / aspectRatio
            } else {                                        // Portrait image
                height = dimension
                width = dimension * aspectRatio
            }
            
        default:
            fatalError("UIIMage.resizeToFit(): FATAL: Unimplemented ContentMode")
        }
        
        if #available(iOS 10.0, *) {
            let renderFormat = UIGraphicsImageRendererFormat.default()
            renderFormat.opaque = opaque
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height), format: renderFormat)
            newImage = renderer.image {
                (context) in
                self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), opaque, 0)
            self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
            newImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
        }
        
        return newImage
    }
}


//MARK:- AIEdge -
enum AIEdge:Int {
    case
    Top,
    Left,
    Bottom,
    Right,
    Top_Left,
    Top_Right,
    Bottom_Left,
    Bottom_Right,
    All,
    None
}


extension Bundle {
    
    static func loadView<T>(fromNib name: String, withType type: T.Type) -> T {
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }
        
        fatalError("Could not load view with type " + String(describing: type))
    }
}


extension UIView {
    
    private struct AssociatedKeys {
        static var descriptiveName = "AssociatedKeys.DescriptiveName.blurView"
    }
    
    private (set) var blurView: BlurView {
        get {
            if let blurView = objc_getAssociatedObject(
                self,
                &AssociatedKeys.descriptiveName
                ) as? BlurView {
                return blurView
            }
            self.blurView = BlurView(to: self)
            return self.blurView
        }
        set(blurView) {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.descriptiveName,
                blurView,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    class BlurView {
        
        private var superview: UIView
        private var blur: UIVisualEffectView?
        private var editing: Bool = false
        private (set) var blurContentView: UIView?
        private (set) var vibrancyContentView: UIView?
        
        var animationDuration: TimeInterval = 0.1
        
        /**
         * Blur style. After it is changed all subviews on
         * blurContentView & vibrancyContentView will be deleted.
         */
        var style: UIBlurEffect.Style = .light {
            didSet {
                guard oldValue != style,
                    !editing else { return }
                applyBlurEffect()
            }
        }
        /**
         * Alpha component of view. It can be changed freely.
         */
        var alpha: CGFloat = 0 {
            didSet {
                guard !editing else { return }
                if blur == nil {
                    applyBlurEffect()
                }
                let alpha = self.alpha
                UIView.animate(withDuration: animationDuration) {
                    self.blur?.alpha = alpha
                }
            }
        }
        
        init(to view: UIView) {
            self.superview = view
        }
        
        func setup(style: UIBlurEffect.Style, alpha: CGFloat) -> Self {
            self.editing = true
            
            self.style = style
            self.alpha = alpha
            
            self.editing = false
            
            return self
        }
        
        func enable(isHidden: Bool = false) {
            if blur == nil {
                applyBlurEffect()
            }
            
            self.blur?.isHidden = isHidden
        }
        
        private func applyBlurEffect() {
            blur?.removeFromSuperview()
            
            applyBlurEffect(
                style: style,
                blurAlpha: alpha
            )
        }
        
        private func applyBlurEffect(style: UIBlurEffect.Style,
                                     blurAlpha: CGFloat) {
            superview.backgroundColor = UIColor.clear
            
            let blurEffect = UIBlurEffect(style: style)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            
            let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
            let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
            blurEffectView.contentView.addSubview(vibrancyView)
            
            blurEffectView.alpha = blurAlpha
            
            superview.insertSubview(blurEffectView, at: 0)
            
            blurEffectView.addAlignedConstrains()
            vibrancyView.addAlignedConstrains()
            
            self.blur = blurEffectView
            self.blurContentView = blurEffectView.contentView
            self.vibrancyContentView = vibrancyView.contentView
        }
    }
    
    private func addAlignedConstrains() {
        translatesAutoresizingMaskIntoConstraints = false
        addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.top)
        addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.leading)
        addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.trailing)
        addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.bottom)
    }
    
    private func addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute) {
        superview?.addConstraint(
            NSLayoutConstraint(
                item: self,
                attribute: attribute,
                relatedBy: NSLayoutConstraint.Relation.equal,
                toItem: superview,
                attribute: attribute,
                multiplier: 1,
                constant: 0
            )
        )
    }
}



extension Date {

      func isEqualTo(_ date: Date) -> Bool {
        return self == date
      }

      func isGreaterThan(_ date: Date) -> Bool {
         return self > date
      }

      func isSmallerThan(_ date: Date) -> Bool {
         return self < date
      }
    func getDayShort() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.dateFormat = "EE"
        return formatter.string(from: self)
    }
    func getMonthFullname() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.dateFormat = "MMMM"
        return formatter.string(from: self)
    }
    func getMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.dateFormat = "MM"
        return formatter.string(from: self)
    }
    func getDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.dateFormat = "dd"
        return formatter.string(from: self)
    }
    func getYear() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.dateFormat = "yyyy"
        return formatter.string(from: self)
    }
    func getFullDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: self)
    }
    func getDateinMyFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.dateFormat = "dd MMM, yyyy"
        return formatter.string(from: self)
    }
   func getElapsedInterval() -> String {

       var calendar = Calendar.current
       calendar.locale = Locale(identifier: Bundle.main.preferredLocalizations[0])
   // IF THE USER HAVE THE PHONE IN SPANISH BUT YOUR APP ONLY SUPPORTS I.E. ENGLISH AND GERMAN
   // WE SHOULD CHANGE THE LOCALE OF THE FORMATTER TO THE PREFERRED ONE
   // (IS THE LOCALE THAT THE USER IS SEEING THE APP), IF NOT, THIS ELAPSED TIME
   // IS GOING TO APPEAR IN SPANISH

       let formatter = DateComponentsFormatter()
       formatter.unitsStyle = .full
       formatter.maximumUnitCount = 1
       formatter.calendar = calendar

       var dateString: String?

       let interval = calendar.dateComponents([.year, .month, .weekOfYear, .day], from: self, to: Date())

       if let year = interval.year, year > 0 {
           formatter.allowedUnits = [.year] //2 years
       } else if let month = interval.month, month > 0 {
           formatter.allowedUnits = [.month] //1 month
       } else if let week = interval.weekOfYear, week > 0 {
           formatter.allowedUnits = [.weekOfMonth] //3 weeks
       } else if let day = interval.day, day > 0 {
           formatter.allowedUnits = [.day] // 6 days
       } else {
           let dateFormatter = DateFormatter()
           dateFormatter.locale = Locale(identifier: Bundle.main.preferredLocalizations[0]) //--> IF THE USER HAVE THE PHONE IN SPANISH BUT YOUR APP ONLY SUPPORTS I.E. ENGLISH AND GERMAN WE SHOULD CHANGE THE LOCALE OF THE FORMATTER TO THE PREFERRED ONE (IS THE LOCALE THAT THE USER IS SEEING THE APP), IF NOT, THIS ELAPSED TIME IS GOING TO APPEAR IN SPANISH
           dateFormatter.dateStyle = .medium
           dateFormatter.doesRelativeDateFormatting = true

           dateString = dateFormatter.string(from: self) // IS GOING TO SHOW 'TODAY'
       }

       if dateString == nil {
           dateString = formatter.string(from: self, to: Date())
       }

       return dateString!
   }
    var yearmonthday: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self as Date)
    }
    func startOfMonth() -> Date {
           return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
       }

       func endOfMonth() -> Date {
           return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
       }
}
extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}
extension UIScrollView {
    func scrollToBottom(animated: Bool) {
         if self.contentSize.height < self.bounds.size.height { return }
         let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
         self.setContentOffset(bottomOffset, animated: animated)
      }
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
   }
}


extension String {
   func localToUTC() -> String {
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "h:mm a"
       dateFormatter.calendar = NSCalendar.current
       dateFormatter.timeZone = TimeZone.current

       let dt = dateFormatter.date(from: self)
       dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
       dateFormatter.dateFormat = "H:mm:ss"

       return dateFormatter.string(from: dt!)
   }

   func UTCToLocal() -> String {
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
       dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

       let dt = dateFormatter.date(from: self)
       dateFormatter.timeZone = TimeZone.current
       dateFormatter.dateFormat = "yyyy-MM-dd"

       return dateFormatter.string(from: dt!)
   }
    func toDate(withFormat format: String )-> Date?{

           let dateFormatter = DateFormatter()
         //  dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
        //   dateFormatter.locale = Locale(identifier: "fa-IR")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
           dateFormatter.dateFormat = format
        
           let date = dateFormatter.date(from: self)
           return date

       }
    func convertDateFormater(_ date: String,from:String,to:String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = from
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = to
        return  dateFormatter.string(from: date ?? Date())

    }
    public func toDouble() -> Double?
       {
          if let num = NumberFormatter().number(from: self) {
                   return num.doubleValue
               } else {
                   return nil
               }
        }
//    var localized: String {
//        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
//    }
}
extension UIDevice {
    @available(iOS 11.0, *)
    var hasTopNotch: Bool {
        if #available(iOS 13.0,  *) {
            return UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0 > 20
        }else{
         return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }

        return false
    }
}

extension String {
    var StrTobool: Bool? {
        switch self.lowercased() {
        case "true", "t", "yes", "y", "1":
            return true
        case "false", "f", "no", "n", "0":
            return false
        default:
            return nil
        }
    }
var boolValue: Bool {
    
    return (self as NSString).boolValue
}}
public enum UIButtonBorderSide {
    case Top, Bottom, Left, Right
}

extension UIButton {
    
    public func addBorder(side: UIButtonBorderSide, color: UIColor, width: CGFloat,selected:UIColor) {
        let border = CALayer()
        border.backgroundColor = selected.cgColor
        
        switch side {
        case .Top:
            border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: width)
        case .Bottom:
            border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        case .Left:
            border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        case .Right:
            border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        }
        
        self.layer.addSublayer(border)
    }
}
extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { return prefix(1).capitalized + dropFirst() }
}
extension UILabel {
    func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
}
extension UILabel {

    var isTruncated: Bool {

        guard let labelText = text else {
            return false
        }

        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil).size

        return labelTextSize.height > bounds.size.height
    }
}
extension Double {
    /// Rounds the double to decimal places value
    func roundedValues(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
extension NSAttributedString {

    convenience init?(withLocalizedHTMLString: String) {

        guard let stringData = withLocalizedHTMLString.data(using: String.Encoding.utf8) else {
            return nil
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html as Any,
            NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue
        ]

        try? self.init(data: stringData, options: options, documentAttributes: nil)
    }
}
