//
//  EMButton.swift
//  Estalim
//
//  Created by Mac on 06/11/20.
//  Copyright © 2020 ZestBrains PVT LTD. All rights reserved.
//


import UIKit

enum buttonType {
    case normal
    case Submit
    case Link
    case SmallGray
    case SmallBlue
    case ChatButton
    case BorderButton
    
}

class EMButton: UIButton {
    
    var btnType:buttonType = .normal
    //INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit()
    {
        self.titleLabel?.font = NotoSans_Regular14
        self.isExclusiveTouch = true
        switch btnType {
        case .normal:
            self.layer.cornerRadius = 0
            self.clipsToBounds = true
    
//            DispatchQueue.main.async {
//                CommonClass.sharedInstance.AppButtonStyle(view: self, corners: [.bottomLeft,.bottomRight,.topRight], radius: 10, borderColor: .AppDefaultBlue)
//            }
            break
        case .BorderButton:
            self.backgroundColor = .white
            self.titleLabel?.font = NotoSans_SemiBold20
            self.layer.cornerRadius = 3
            self.clipsToBounds = true
            
            self.setTitleColor(hexStringToUIColor(hex: "838383"), for: .normal)
            self.setTitleColor(hexStringToUIColor(hex: "838383"), for: .selected)
            self.layer.cornerRadius = 8
            self.layer.masksToBounds = false
            self.layer.borderWidth = 1
            self.layer.borderColor = hexStringToUIColor(hex: "838383").cgColor
        case .ChatButton:
            self.backgroundColor = .AppDefaultBlue
            self.titleLabel?.font = NotoSans_Medium14
            self.layer.cornerRadius = 3
            self.clipsToBounds = true
            self.setTitleColor(UIColor.white, for: .normal)
            self.setTitleColor(UIColor.white, for: .selected)
            self.layer.cornerRadius = 3
            self.layer.masksToBounds = false
            self.layer.borderWidth = 0
            //background: 101,180,246,1;

            self.layer.shadowColor = UIColor.init(red: 101.0/255, green: 180.0/255, blue: 246.0/255, alpha: 0.5).cgColor
            self.layer.shadowOpacity = 0.8;
            self.layer.shadowRadius = 6;
            self.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
            self.layer.zPosition = -1
            break
        case .Submit:
            self.backgroundColor = .AppDefaultBlue
            self.titleLabel?.font = NotoSans_SemiBold20
            self.layer.cornerRadius = 5
            self.clipsToBounds = true
            self.setTitleColor(UIColor.white, for: .normal)
            self.setTitleColor(UIColor.white, for: .selected)
            self.layer.cornerRadius = 8
            self.layer.masksToBounds = false
            self.layer.borderWidth = 0
            //background: 101,180,246,1;

            self.layer.shadowColor = UIColor.init(red: 101.0/255, green: 180.0/255, blue: 246.0/255, alpha: 0.5).cgColor
            self.layer.shadowOpacity = 0.8;
            self.layer.shadowRadius = 6;
            self.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
            self.layer.zPosition = -1
            break

        case .Link:
            self.backgroundColor = .white
            self.titleLabel?.font = NotoSans_Regular14
            self.layer.cornerRadius = 5
            self.clipsToBounds = true
            self.setTitleColor(.AppDefaultBlue, for: .normal)
            self.setTitleColor(.AppDefaultBlue, for: .selected)
            break

        case .SmallGray:
            self.backgroundColor = .white
            self.titleLabel?.font = NotoSans_Regular14
            self.layer.cornerRadius = 5
            self.clipsToBounds = true
            self.setTitleColor(.AppPlaceHolder, for: .normal)
            self.setTitleColor(.AppPlaceHolder, for: .selected)
            self.tintColor = .AppPlaceHolder
            break

        case .SmallBlue:
            self.backgroundColor = .white
            self.titleLabel?.font = NotoSans_Regular14
            self.layer.cornerRadius = 5
            self.clipsToBounds = true
            self.setTitleColor(.AppDefaultBlue, for: .normal)
            self.setTitleColor(.AppDefaultBlue, for: .selected)
            break

        }
    }
    
    
 
    
//    func makeSelected() -> Void{
//        self.titleLabel?.font = NotoSans_Regular14
//        //        self.titleLabel?.font = UIFont.appFont_AvenirRegular(Size: 15)
//        self.layer.borderWidth = 0.0
//        self.setTitleColor(UIColor.white, for: UIControl.State.normal)
//
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [UIColor.white.cgColor , UIColor.white.cgColor]
//
//        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
//        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
//        gradientLayer.frame = self.bounds
//        self.layer.cornerRadius = 6
//
//        self.layer.insertSublayer(gradientLayer, at:0)
//
//    }
    
//    func makeDeSelected() -> Void{
//
//        self.titleLabel?.font = NotoSans_Regular14
//        self.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
//        self.layer.borderColor = UIColor.lightGray.cgColor
//        self.layer.borderWidth = 1.0
//        self.layer.cornerRadius = 6
//        self.backgroundColor = UIColor.white
//
//        if (self.layer.sublayers?[0] as? CAGradientLayer) != nil {
//            self.layer.sublayers?.removeFirst()
//        }
//    }
}
