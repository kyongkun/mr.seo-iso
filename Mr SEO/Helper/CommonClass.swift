//
//  CommonClass.swift
//  Estalim
//
//  Created by Mac on 04/11/20.
//  Copyright © 2020 ZestBrains PVT LTD. All rights reserved.
//

//
//  CommonClass.swift
//  Badi
//
//  Created by Mac on 03/10/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import Alamofire


private let _sharedInstance = CommonClass()

let BASE_URL:String = "http://zestbrains4u.site/LyftED/ws/v1/"
let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)


let appDelObj : AppDelegate = UIApplication.shared.delegate as! AppDelegate

let PlaceholderImage = UIImage(named: "ic_logo")



class CommonClass: NSObject {
    
    class var sharedInstance: CommonClass {
        return _sharedInstance
    }
    
    static let myAppDel : AppDelegate = UIApplication.shared.delegate as! AppDelegate

    
    func API(Join:String) -> String {
        return BASE_URL + Join
    }
    
    func isValidEmail(testStr:String) -> Bool
      {
          let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
          let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
          let result = emailTest.evaluate(with: testStr)
          return result
      }
    
    func getCurrentTimeZone() -> String{
        
        return String (TimeZone.current.identifier)
    }
    
    func isReachable() -> Bool
       {
           let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
           return (reachabilityManager?.isReachable)!
       }
    
    func localToUTC(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy hh:mm a"
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "MM-dd-yyyy hh:mm a"
        
        return dateFormatter.string(from: dt!)
    }
    
    func getCurrentTime() -> String{
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let result = formatter.string(from: date)
        return result
    }
    
//    func setupTextView(str:String,txtfldView:UITextView)
//    {
//        txtfldView.isEditable = false
//        txtfldView.dataDetectorTypes = .all
//        let style = NSMutableParagraphStyle()
//        style.lineSpacing = 4
//
//        let attributes = [NSAttributedString.Key.paragraphStyle : style,NSAttributedString.Key.font:UIFont(name: "Metropolis-Regular", size: 13.0)!,NSAttributedString.Key.foregroundColor:UIColor.init(hexString: "2E2E2E"),NSAttributedString.Key.kern: 0.3] as [NSAttributedString.Key : Any]
//        txtfldView.attributedText = NSAttributedString(string: str, attributes: attributes as [NSAttributedString.Key : Any])
//        txtfldView.adjustUITextViewHeight()
//    }
    func NewLineHtml(str:String) -> String
       {
            let newText = str.replacingOccurrences(of: "\n", with: "<br>")
              return newText
       }
    /*
    func isReachable() -> Bool
    {
        let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
        return (reachabilityManager?.isReachable)!
    }
 */
    
    func setShadow(obj:Any, cornurRadius:CGFloat, ClipToBound:Bool, masksToBounds:Bool, shadowColor:String, shadowOpacity:Float, shadowOffset:CGSize, shadowRadius:CGFloat, shouldRasterize:Bool, shadowPath:CGRect) {
        if obj is UIView {
            let tempView:UIView = obj as! UIView
            tempView.clipsToBounds = ClipToBound
            tempView.layer.cornerRadius = cornurRadius
            tempView.layer.shadowOffset = shadowOffset
            tempView.layer.shadowOpacity = shadowOpacity
            tempView.layer.shadowRadius = shadowRadius
            tempView.layer.shadowColor = self.getColorIntoHex(Hex: shadowColor).cgColor
            tempView.layer.masksToBounds =  masksToBounds
            tempView.layer.shouldRasterize = shouldRasterize
            tempView.layer.shadowPath = UIBezierPath(roundedRect: tempView.bounds, cornerRadius: cornurRadius).cgPath
        }
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    
    
    // For Get Color Using HexCode
    func getColorIntoHex(Hex:String) -> UIColor {
        if Hex.isEmpty {
            return UIColor.clear
        }
        let scanner = Scanner(string: Hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        return UIColor.init(red: CGFloat(r) / 0xff, green: CGFloat(g) / 0xff, blue: CGFloat(b) / 0xff, alpha: 1)
    }
    
    
    func imageOrientation(_ src:UIImage)->UIImage {
        if src.imageOrientation == UIImage.Orientation.up {
            return src
        }
        var transform: CGAffineTransform = CGAffineTransform.identity
        switch src.imageOrientation {
        case UIImage.Orientation.down, UIImage.Orientation.downMirrored:
            transform = transform.translatedBy(x: src.size.width, y: src.size.height)
            transform = transform.rotated(by: CGFloat(M_PI))
            break
        case UIImage.Orientation.left, UIImage.Orientation.leftMirrored:
            transform = transform.translatedBy(x: src.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(M_PI_2))
            break
        case UIImage.Orientation.right, UIImage.Orientation.rightMirrored:
            transform = transform.translatedBy(x: 0, y: src.size.height)
            transform = transform.rotated(by: CGFloat(-M_PI_2))
            break
        case UIImage.Orientation.up, UIImage.Orientation.upMirrored:
            break
        @unknown default:
            break
        }
        
        switch src.imageOrientation {
        case UIImage.Orientation.upMirrored, UIImage.Orientation.downMirrored:
            transform.translatedBy(x: src.size.width, y: 0)
            transform.scaledBy(x: -1, y: 1)
            break
        case UIImage.Orientation.leftMirrored, UIImage.Orientation.rightMirrored:
            transform.translatedBy(x: src.size.height, y: 0)
            transform.scaledBy(x: -1, y: 1)
        case UIImage.Orientation.up, UIImage.Orientation.down, UIImage.Orientation.left, UIImage.Orientation.right:
            break
        @unknown default:
            break
        }
        
        let ctx:CGContext = CGContext(data: nil, width: Int(src.size.width), height: Int(src.size.height), bitsPerComponent: (src.cgImage)!.bitsPerComponent, bytesPerRow: 0, space: (src.cgImage)!.colorSpace!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        
        ctx.concatenate(transform)
        
        switch src.imageOrientation {
        case UIImage.Orientation.left, UIImage.Orientation.leftMirrored, UIImage.Orientation.right, UIImage.Orientation.rightMirrored:
            ctx.draw(src.cgImage!, in: CGRect(x: 0, y: 0, width: src.size.height, height: src.size.width))
            break
        default:
            ctx.draw(src.cgImage!, in: CGRect(x: 0, y: 0, width: src.size.width, height: src.size.height))
            break
        }
        
        let cgimg:CGImage = ctx.makeImage()!
        let img:UIImage = UIImage(cgImage: cgimg)
        
        return img
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    func UTCToLocal(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: dt!)
    }
    
    func getDate(date:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: date) // replace Date String
    }
    
    func roundCorners(view :UIView, corners: UIRectCorner, radius: CGFloat){
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
   
    }
    func roundDifferentCorners(view :UIView,topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0,borderColor:UIColor) {//(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
        let topLeftRadius = CGSize(width: topLeft, height: topLeft)
        let topRightRadius = CGSize(width: topRight, height: topRight)
        let bottomLeftRadius = CGSize(width: bottomLeft, height: bottomLeft)
        let bottomRightRadius = CGSize(width: bottomRight, height: bottomRight)
        let maskPath = UIBezierPath(shouldRoundRect: view.bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        view.layer.mask = shape
        // Add border
        let borderLayer = CAShapeLayer()
        borderLayer.lineWidth = 1.0
        borderLayer.frame = view.bounds
        borderLayer.path = shape.path // Reuse the Bezier path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        view.layer.addSublayer(borderLayer)
        view.dropShadow()
        
    }
    func AppTextFieldStyle(view :UIView, corners: UIRectCorner, radius: CGFloat,borderColor:UIColor){
         let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
       
        // Add border
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path // Reuse the Bezier path
        borderLayer.backgroundColor = borderColor.cgColor
        borderLayer.fillColor = UIColor.white.cgColor
        borderLayer.borderColor = UIColor.lightText.cgColor
        borderLayer.borderWidth = 1.0
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.frame = view.bounds
       // view.addShadowView()
        
        view.layer.addSublayer(borderLayer)
        
    }
    func AppButtonStyle(view :UIView, corners: UIRectCorner, radius: CGFloat,borderColor:UIColor){
         let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
        view.layer.mask = mask
        
        // Add border
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path // Reuse the Bezier path
        borderLayer.backgroundColor = borderColor.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.frame = view.bounds
        view.layer.insertSublayer(borderLayer, at: 0)
    }
    func roundCornersWithBoarderReverce(view :UIView, corners: UIRectCorner, radius: CGFloat,borderColor:UIColor){
         let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
        view.layer.mask = mask
        
        // Add border
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path // Reuse the Bezier path
        borderLayer.fillColor = UIColor.AppDefaultBlue.cgColor
        borderLayer.strokeColor = UIColor.white.cgColor
        borderLayer.lineWidth = 0
//        borderLayer.borderWidth = 1
//        borderLayer.borderColor = borderColor.cgColor
        borderLayer.frame = view.bounds
        view.layer.addSublayer(borderLayer)
    }
    func roundCornersWithBoarder(view :UIView, corners: UIRectCorner, radius: CGFloat,borderColor:UIColor){
         let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
        view.layer.mask = mask
        
        // Add border
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path // Reuse the Bezier path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = 3
//        borderLayer.borderWidth = 1
//        borderLayer.borderColor = borderColor.cgColor
        borderLayer.frame = view.bounds
        view.layer.addSublayer(borderLayer)
    }
    func shadowWithCornerAndWidth(view :UIView, corners: UIRectCorner, radius: CGFloat,borderColor:UIColor,width: CGFloat){
        
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
        view.layer.mask = mask
        
       // view.layer.shadowColor = UIColor.black.cgColor;
        //view.layer.shadowOpacity = 0.5;
        //view.layer.shadowOffset  = CGSize(width :0, height :1)
        //view.layer.masksToBounds = false;
        
        view.layer.borderWidth   = width
        view.backgroundColor     = UIColor.white;
    }
    
    func shadowWithCorner(view :UIView, corners: UIRectCorner, radius: CGFloat,borderColor:UIColor){
        
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
        view.layer.mask = mask
        view.layer.shadowPath = path.cgPath
        
        view.layer.shadowColor = UIColor.black.cgColor;
        view.layer.shadowOpacity = 0.7;
        view.layer.shadowOffset  =  CGSize(width :1, height :1)
        view.layer.masksToBounds = false;
        view.layer.borderColor = borderColor.cgColor
        view.layer.borderWidth   = 1.8;
        view.backgroundColor     = UIColor.white;
    }
    
    
//    func openSideMenu()
//    {
//        let storyboard:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
//
//        SideMenuManager.menuRightNavigationController = storyboard.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
//        //MenuPushStyle
//        SideMenuManager.menuFadeStatusBar = false
//        SideMenuManager.menuWidth = 275;
//
//    }
//    func openLeftSideMenu()
//    {
//        let storyboard:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
//
//              SideMenuManager.menuLeftNavigationController = storyboard.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
//              //MenuPushStyle
//        SideMenuManager.menuBlurEffectStyle = .dark
//              SideMenuManager.menuFadeStatusBar = false
//              SideMenuManager.menuWidth = 275;
//    }
    
    func ConverDateFromString(datestring:String) -> Date?
    {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let s = dateFormatter.date(from: datestring)
        
        return s
    }
    
    func convertDateFormatter(date: String) -> String
    {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"//this your string date format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"///this is what you want to convert format
        dateFormatter.timeZone = TimeZone.current
        let timeStamp = dateFormatter.string(from: date!)
        
        
        return timeStamp
    }
    
    func convertDateFormatter1(date: String) -> String
    {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MM dd,yyyy"//this your string date format
        
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd MMM yyyy"///this is what you want to convert format
        dateFormatter.timeZone = TimeZone.current
        let timeStamp = dateFormatter.string(from: date!)
        
        
        return timeStamp
    }
    
    func convertDateFormatter123(date: String) -> String
    {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MM dd,yyyy"//this your string date format
        
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd MMM yyyy"///this is what you want to convert format
        dateFormatter.timeZone = TimeZone.current
        let timeStamp = dateFormatter.string(from: date!)
        
        
        return timeStamp
    }
    
    func convertDateFormatter12(date: String) -> String
       {
           
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "E, MM dd,yyyy"//this your string date format
           
           let date = dateFormatter.date(from: date)
           dateFormatter.dateFormat = "dd MMMM yyyy"///this is what you want to convert format
           dateFormatter.timeZone = TimeZone.current
           let timeStamp = dateFormatter.string(from: date!)
           
           
           return timeStamp
       }
    
    func convertOnlyDateFormatter1(date: String) -> String
    {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm a"//this your string date format
        
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd-MM-yyyy"///this is what you want to convert format
        dateFormatter.timeZone = TimeZone.current
        let timeStamp = dateFormatter.string(from: date!)
        
        
        return timeStamp
    }
    
    func convertOnlyTimeFormatter1(date: String) -> String
    {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm a"//this your string date format
        
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "hh:mm a"///this is what you want to convert format
        dateFormatter.timeZone = TimeZone.current
        let timeStamp = dateFormatter.string(from: date!)
        
        
        return timeStamp
    }
    
    func UTCToLocalAM(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "hh:mm a"
        
        return dateFormatter.string(from: dt!)
    }
    
    
    
    func UTCToLocalOnlyDate(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "dd  MMM  yyyy"
        
        return dateFormatter.string(from: dt!)
    }
    
}



//MAR:- Extension view
extension UIView {

  // OUTPUT 1
  func dropShadow(scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.5
    layer.shadowOffset = CGSize(width: -1, height: 1)
    layer.shadowRadius = 1

    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }

  // OUTPUT 2
  func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
//    layer.shadowRadius = radius

    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}


extension Date
{
    mutating func addDays(n: Int)
    {
        let cal = Calendar.current
        self = cal.date(byAdding: .day, value: n, to: self)!
    }

    func firstDayOfTheMonth() -> Date {
        return Calendar.current.date(from:
            Calendar.current.dateComponents([.year,.month], from: self))!
    }

//    func getAllDays() -> [String]
//    {
//        var strDate = [String]()
//
//        var days = [Date]()
//
//        let calendar = Calendar.current
//
//        let range = calendar.range(of: .day, in: .month, for: self)!
//
//        var day = firstDayOfTheMonth()
//
//        for _ in 1...range.count
//        {
//            strDate.append(Utility.stringFromDate(date: day, strFormatter: "E, dd MMM"))
//            days.append(day)
//            day.addDays(n: 1)
//        }
//        return strDate
//    }
    
//    func getAllDaysOfTheCurrentWeek() -> [String] {
//        var strDate = [String]()
//        var dates: [Date] = []
//        guard let dateInterval = Calendar.current.dateInterval(of: .weekOfYear,
//                                                               for: Date()) else {
//                                                                return strDate
//        }
//
//        Calendar.current.enumerateDates(startingAfter: dateInterval.start,
//                                        matching: DateComponents(hour:0),
//                                        matchingPolicy: .nextTime) { date, _, stop in
//                                            guard let date = date else {
//                                                return
//                                            }
//                                            if date < dateInterval.end || date == dateInterval.end {
//                                                dates.append(date)
//                                                strDate.append(Utility.stringFromDate(date: date, strFormatter: "E, dd MMM"))
//                                            } else {
//                                                stop = true
//                                            }
//        }
//        return strDate
//    }
    
//    func getFilterDaysOfTheCurrentWeek() -> [String] {
//        var strDate = [String]()
//        var dates: [Date] = []
//        guard let dateInterval = Calendar.current.dateInterval(of: .weekOfYear,
//                                                               for: Date()) else {
//                                                                return strDate
//        }
//
//        Calendar.current.enumerateDates(startingAfter: dateInterval.start,
//                                        matching: DateComponents(hour:0),
//                                        matchingPolicy: .nextTime) { date, _, stop in
//                                            guard let date = date else {
//                                                return
//                                            }
//                                            if date < dateInterval.end || date == dateInterval.end {
//                                                dates.append(date)
//                                                strDate.append(Utility.stringFromDate(date: date, strFormatter: "yyyy-MM-dd"))
//                                            } else {
//                                                stop = true
//                                            }
//        }
//        return strDate
//    }
    
//    func getAllFilterDays() -> [String]
//        {
//            var strDate = [String]()
//
//            var days = [Date]()
//
//            let calendar = Calendar.current
//
//            let range = calendar.range(of: .day, in: .month, for: self)!
//
//            var day = firstDayOfTheMonth()
//
//            for _ in 1...range.count
//            {
//                strDate.append(Utility.stringFromDate(date: day, strFormatter: "yyyy-MM-dd"))
//                days.append(day)
//                day.addDays(n: 1)
//            }
//            return strDate
//        }
//

//    func getAllDaysOfTheCurrentYear() -> [String] {
//        var strDate = [String]()
//        var days = [Date]()
//
//        let calendar = Calendar.current
//
//        let range = calendar.range(of: .day, in: .year, for: self)!
//
//        var day = Date()
//
//        for _ in 1...range.count
//        {
//            //                      strDate.append(Utility.stringFromDate(date: day, strFormatter: "yyyy-MM-dd"))
//            strDate.append(Utility.stringFromDate(date: day, strFormatter: "E, dd MMM"))
//
//            days.append(day)
//            day.addDays(n: -1)
//        }
//
//
//        return strDate.reversed()
//    }
    
//    func getAllFilteredDaysOfTheCurrentYear(filterFormate: String) -> [String] {
//        var strDate = [String]()
//        var days = [Date]()
//
//        let calendar = Calendar.current
//
//        let range = calendar.range(of: .day, in: .year, for: self)!
//
//        var day = Date()
//
//        for _ in 1...range.count
//        {
//            //                      strDate.append(Utility.stringFromDate(date: day, strFormatter: "yyyy-MM-dd"))
//            strDate.append(Utility.stringFromDate(date: day, strFormatter: filterFormate))
//
//            days.append(day)
//            day.addDays(n: -1)
//        }
//
//
//        return strDate.reversed()
//    }
}



extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let graphYellowColor = UIColor(red: 246/255, green: 158/255, blue: 41/255, alpha: 1.0)
    static let graphRedColor = UIColor(red: 226/255, green: 55/255, blue: 68/255, alpha: 1.0)
    static let selectedGreenColor = UIColor(red: 2/255, green: 145/255, blue: 28/255, alpha: 1.0)
    static let shadowColor = UIColor(displayP3Red: 0/255, green: 0/255, blue: 0/255, alpha: 0.07)
}

extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
extension UIView {
    
    func addShadowWithBorderAndCorner(shadowColor: UIColor, offSet: CGSize, opacity: Float, shadowRadius: CGFloat, cornerRadius: CGFloat, corners: UIRectCorner, fillColor: UIColor = .clear) {
        
        let shadowLayer = CAShapeLayer()
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let cgPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size).cgPath //1
        shadowLayer.path = cgPath //2
        shadowLayer.fillColor = fillColor.cgColor //3
        shadowLayer.shadowColor = shadowColor.cgColor //4
        shadowLayer.shadowPath = cgPath
        shadowLayer.shadowOffset = offSet //5
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = shadowRadius
        self.layer.addSublayer(shadowLayer)
    }
}
extension UIView {
    
    func round(corners: UIRectCorner, cornerRadius: Double) {
        
        self.layer.masksToBounds = false
        
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let bezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size)
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = bezierPath.cgPath
        
        
        shapeLayer.shadowColor = UIColor.blue.cgColor
        shapeLayer.shadowPath = bezierPath.cgPath
        shapeLayer.shadowOffset = CGSize(width: 1, height: 1)  //offSet //5
        shapeLayer.shadowOpacity = 0.5
        shapeLayer.shadowRadius = 23
        
        
        self.layer.mask = shapeLayer
    }
}
extension UIView {
//    var parentViewController: UIViewController? {
//        var parentResponder: UIResponder? = self
//        while parentResponder != nil {
//            parentResponder = parentResponder!.next
//            if let viewController = parentResponder as? UIViewController {
//                return viewController
//            }
//        }
//        return nil
//    }
}
extension UIViewController {

    func getPreviousViewController() -> UIViewController? {
        guard let _ = self.navigationController else {
            return nil
        }

        guard let viewControllers = self.navigationController?.viewControllers else {
            return nil
        }

        guard viewControllers.count >= 2 else {
            return nil
        }
        return viewControllers[viewControllers.count - 2]
    }
    
}
extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
         return topViewController?.preferredStatusBarStyle ?? .default
      }
   func backToViewController(vc: Any) {
      // iterate to find the type of vc
      for element in viewControllers as Array {
        if "\(type(of: element)).Type" == "\(type(of: (vc as AnyObject)))" {
            self.popToViewController(element, animated: true)
            break
         }
      }
   }

}

extension UIBezierPath {
    convenience init(shouldRoundRect rect: CGRect, topLeftRadius: CGSize = .zero, topRightRadius: CGSize = .zero, bottomLeftRadius: CGSize = .zero, bottomRightRadius: CGSize = .zero){

        self.init()

        let path = CGMutablePath()

        let topLeft = rect.origin
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)

        if topLeftRadius != .zero{
            path.move(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.move(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }

        if topRightRadius != .zero{
            path.addLine(to: CGPoint(x: topRight.x-topRightRadius.width, y: topRight.y))
            path.addCurve(to:  CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height), control1: CGPoint(x: topRight.x, y: topRight.y), control2:CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height))
        } else {
             path.addLine(to: CGPoint(x: topRight.x, y: topRight.y))
        }

        if bottomRightRadius != .zero{
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y-bottomRightRadius.height))
            path.addCurve(to: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y), control1: CGPoint(x: bottomRight.x, y: bottomRight.y), control2: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y))
        } else {
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y))
        }

        if bottomLeftRadius != .zero{
            path.addLine(to: CGPoint(x: bottomLeft.x+bottomLeftRadius.width, y: bottomLeft.y))
            path.addCurve(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height), control1: CGPoint(x: bottomLeft.x, y: bottomLeft.y), control2: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height))
        } else {
            path.addLine(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y))
        }

        if topLeftRadius != .zero{
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y+topLeftRadius.height))
            path.addCurve(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y) , control1: CGPoint(x: topLeft.x, y: topLeft.y) , control2: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }

        path.closeSubpath()
        cgPath = path
    }
}
