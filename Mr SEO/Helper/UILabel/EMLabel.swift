//
//  EMLabel.swift
//  Mitten pets
//
//  Created by Mac on 11/01/21.
//

//
//  KYTLabel.swift
//  KYT
//
//  Created by Kavin Soni on 02/11/19.
//  Copyright © 2019 Kavin Soni. All rights reserved.
//

import UIKit


enum FontStyle {
    case Navigation
    case Navigation_White
}


class EMLabel: UILabel {
    
    var fontStyle:FontStyle = .Navigation
    
    // MARK: PROPERTIES
    public typealias Action = (_ lbl: EMLabel, _ gestureRecognizer: UITapGestureRecognizer) -> Swift.Void
    public private(set) var actionOnTouch: Action?
    open var insets: UIEdgeInsets = .zero
    
    // MARK: INIT
    override open func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    // Override -intrinsicContentSize: for Auto layout code
    override open var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += insets.top + insets.bottom
        contentSize.width += insets.left + insets.right
        return contentSize
    }
    
    // Override -sizeThatFits: for Springs & Struts code
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var contentSize = super.sizeThatFits(size)
        contentSize.height += insets.top + insets.bottom
        contentSize.width += insets.left + insets.right
        return contentSize
    }
    
    // MARK: Tap Action
    
    /// Return you click event on label click
    ///
    /// - Parameter closure: Action
    public func action(_ closure: @escaping Action) {
        print("action did set")
        if actionOnTouch == nil {
            let gesture = UITapGestureRecognizer(
                target: self,
                action: #selector(self.actionOnTouchUpInside))
            gesture.numberOfTapsRequired = 1
            gesture.numberOfTouchesRequired = 1
            self.addGestureRecognizer(gesture)
            self.isUserInteractionEnabled = true
        }
        self.actionOnTouch = closure
    }
    
    /// UILabel Action
    @objc internal func actionOnTouchUpInside(_ gesture: UITapGestureRecognizer) {
        actionOnTouch?(self, gesture)
    }
    
    /// Default methords
    private func commonInit() {
        
        switch fontStyle {
            
        case .Navigation_White:
            self.font = NotoSans_Medium15
            self.textAlignment = .center
            self.textColor = UIColor.white
        case .Navigation:
            self.font = NotoSans_Medium15
            self.textAlignment = .center
            self.textColor = UIColor.NavigationGray
            

//        case .LatoBold:
//            //self.font = UIFont.appFont_LatoBold(Size: self.font.pointSize)
//
//        case .OswaldLight:
//            //self.font = UIFont.appFont_OswaldLight(Size: self.font.pointSize)
//
//        case .SourceSansProSemiBold:
//            //self.font = UIFont.appFont_SourceSansProSemibold(Size: self.font.pointSize)

        }
    }
}
