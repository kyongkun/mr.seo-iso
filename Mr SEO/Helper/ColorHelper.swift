//
//  ColorHelper.swift
//  Estalim
//
//  Created by Mac on 04/11/20.
//  Copyright © 2020 ZestBrains PVT LTD. All rights reserved.
//

import UIKit
extension UIColor{
    static var random: UIColor {
           return UIColor(red: .random(in: 0...1),
                          green: .random(in: 0...1),
                          blue: .random(in: 0...1),
                          alpha: 1.0)
       }

        func as1ptImage() -> UIImage {
            UIGraphicsBeginImageContext(CGSize(width: 2, height: 2))
            let ctx = UIGraphicsGetCurrentContext()!
            self.setFill()
            ctx.fill(CGRect(x: 0, y: 0, width: 2, height: 2))
            let image = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            return image
        }
    
    //Colors are computed class properties. To refrence the class, use self
    
    class var StatusBlue:UIColor{
        return hexStringToUIColor(hex: "4EA3FE")
    }
    class var StatusGreen:UIColor{
        return hexStringToUIColor(hex: "5AD14F")
    }
    class var StatusRed:UIColor{
        return hexStringToUIColor(hex: "EC6161")
    }

    class var NavigationborderGray:UIColor{
        return self.init(red: 232.0/255, green: 236.0/255, blue: 239.0/255, alpha: 0.5)
    }
    class var LineColor:UIColor{
        return self.init(red: 232.0/255, green: 236.0/255, blue: 239.0/255, alpha: 0.5)
    }
    class var BorderColor:UIColor{
        return self.init(red: 232.0/255, green: 236.0/255, blue: 239.0/255, alpha: 1.0)
    }
    class var NavigationGray:UIColor{
        
        return self.init(red: 36.0/255, green: 36.0/255, blue: 36.0/255, alpha: 1.0)
    }
    class var AppDefaultBlue:UIColor{
        return self.init(red: 78.0/255, green: 163.0/255, blue: 254.0/255, alpha: 1.0)
    }
    class var AppPlaceHolder:UIColor{
        return self.init(red: 106.0/255, green: 106.0/255, blue: 106.0/255, alpha: 0.35)
    }
    

    
    class var AppTextFieldText:UIColor{
        return self.init(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 1.0)
    }

    class var AppTextField:UIColor{
        return self.init(red: 216.0/255, green: 216.0/255, blue: 216.0/255, alpha: 1.0)
    }
    class var AppSelectedFont:UIColor{
        return self.init(red: 58.0/255, green: 51.0/255, blue: 53.0/255, alpha: 1.0)
    }
    class var StatusInProgress:UIColor{
        return self.init(red: 236.0/255, green: 197.0/255, blue: 42.0/255, alpha: 1.0)
    }
    class var StatusDelivered:UIColor{
        return self.init(red: 23.0/255, green: 165.0/255, blue: 23.0/255, alpha: 1.0)
    }
//    class var AppFontBlack:UIColor{
//
//        return self.hexColor(17364729, alpha: 1.0)
//    }
    class var AppSelectedFont50Aplaha:UIColor{
        return self.init(red: 33.0/255, green: 33.0/255, blue: 33.0/255, alpha: 0.5)
    }

//    class var crust:UIColor{
//        return self.hexColor(0xe39448, alpha: 1.0)
//    }
//
//    //The hexColor method is a class method taking a UInt32 and alpha value and returns a color. See http://bit.ly/HexColorsWeb onhow it works.
//
//    class func hexColor(_ hexColorNumber:UInt32, alpha: CGFloat) -> UIColor {
//        let red = (hexColorNumber & 0xff0000) >> 16
//        let green = (hexColorNumber & 0x00ff00) >> 8
//        let blue =  (hexColorNumber & 0x0000ff)
//        return self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: alpha)
//    }
}
//extension UIColor {
//   convenience init(r: Int, g: Int, b: Int) {
//       assert(r >= 0 && r <= 255, "Invalid red component")
//       assert(g >= 0 && g <= 255, "Invalid green component")
//       assert(b >= 0 && b <= 255, "Invalid blue component")
//
//       self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
//   }
//
//   convenience init(rgb: Int) {
//       self.init(
//           red: (rgb >> 16) & 0xFF,
//           green: (rgb >> 8) & 0xFF,
//           blue: rgb & 0xFF
//       )
//   }
//}
