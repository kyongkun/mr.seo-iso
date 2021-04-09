//
//  FondHelper.swift
//  Estalim
//
//  Created by Mac on 06/11/20.
//  Copyright © 2020 ZestBrains PVT LTD. All rights reserved.
//

import Foundation
import UIKit
// Usage Examples
let system12            = Font(.system, size: .standard(.S12)).instance
let NotoSans_Regular1        = Font(.installed(.NotoSans_Regular), size: .standard(.S1)).instance
let NotoSans_Regular12        = Font(.installed(.NotoSans_Regular), size: .standard(.S12)).instance
let NotoSans_Regular13        = Font(.installed(.NotoSans_Regular), size: .standard(.S13)).instance
let NotoSans_Regular14        = Font(.installed(.NotoSans_Regular), size: .standard(.S14)).instance
let NotoSans_Regular15        = Font(.installed(.NotoSans_Regular), size: .standard(.S15)).instance
let NotoSans_Regular16        = Font(.installed(.NotoSans_Regular), size: .standard(.S16)).instance
let NotoSans_Regular20        = Font(.installed(.NotoSans_Regular), size: .standard(.S20)).instance
//Medium
let NotoSans_Medium14        = Font(.installed(.NotoSans_Medium), size: .standard(.S14)).instance

let NotoSans_Medium15        = Font(.installed(.NotoSans_Medium), size: .standard(.S15)).instance
let NotoSans_SemiBold20        = Font(.installed(.NotoSans_SemiBold), size: .standard(.S20)).instance

//Bold
let NotoSans_Bold16        = Font(.installed(.NotoSans_Bold), size: .standard(.S16)).instance
let NotoSans_Bold14        = Font(.installed(.NotoSans_Bold), size: .standard(.S14)).instance
let NotoSans_Bold13        = Font(.installed(.NotoSans_Bold), size: .standard(.S13)).instance

let NotoSans_Bold15        = Font(.installed(.NotoSans_Bold), size: .standard(.S15)).instance

//semi bold
struct Font {

    enum FontType {
        case installed(FontName)
        case custom(String)
        case system
        case systemBold
        case systemItatic
        case systemWeighted(weight: Double)
        case monoSpacedDigit(size: Double, weight: Double)
    }
    enum FontSize {
        case standard(StandardSize)
        case custom(Double)
        var value: Double {
            switch self {
            case .standard(let size):
                return size.rawValue
            case .custom(let customSize):
                return customSize
            }
        }
    }
    enum FontName: String {
        case NotoSans_Light            = "NotoSans-Light"
        case NotoSans_Regular      = "NotoSans-Regular"
        case NotoSans_Medium          = "NotoSans-Medium"
        case NotoSans_SemiBold          = "NotoSans-SemiBold"
        case NotoSans_Bold          = "NotoSans-Bold"

    }
    enum StandardSize: Double {
        case S22 = 22.0
        case S21 = 21.0
        case S20 = 20.0
        case S19 = 19.0
        case S18 = 18.0
        case S17 = 17.0
        case S16 = 16.0
        case S15 = 15.0
        case S14 = 14.0
        case S13 = 13.0
        case S12 = 12.0
        case S11 = 11.0
        case S10 = 10.0
        case S1 = 1.0
    }

    
    var type: FontType
    var size: FontSize
    init(_ type: FontType, size: FontSize) {
        self.type = type
        self.size = size
    }
}

extension Font {
    
    var instance: UIFont {
        
        var instanceFont: UIFont!
        switch type {
        case .custom(let fontName):
            guard let font =  UIFont(name: fontName, size: CGFloat(size.value)) else {
                fatalError("\(fontName) font is not installed, make sure it added in Info.plist and logged with Utility.logAllAvailableFonts()")
            }
            instanceFont = font
        case .installed(let fontName):
            guard let font =  UIFont(name: fontName.rawValue, size: CGFloat(size.value)) else {
                fatalError("\(fontName.rawValue) font is not installed, make sure it added in Info.plist and logged with Utility.logAllAvailableFonts()")
            }
            instanceFont = font
        case .system:
            instanceFont = UIFont.systemFont(ofSize: CGFloat(size.value))
        case .systemBold:
            instanceFont = UIFont.boldSystemFont(ofSize: CGFloat(size.value))
        case .systemItatic:
            instanceFont = UIFont.italicSystemFont(ofSize: CGFloat(size.value))
        case .systemWeighted(let weight):
            instanceFont = UIFont.systemFont(ofSize: CGFloat(size.value),
                                             weight: UIFont.Weight(rawValue: CGFloat(weight)))
        case .monoSpacedDigit(let size, let weight):
            instanceFont = UIFont.monospacedDigitSystemFont(ofSize: CGFloat(size),
                                                            weight: UIFont.Weight(rawValue: CGFloat(weight)))
        }
        return instanceFont
    }
}
class Utility {
    /// Logs all available fonts from iOS SDK and installed custom font
    class func logAllAvailableFonts() {
        for family in UIFont.familyNames {
            print("\(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("   \(name)")
            }
        }
    }
}
