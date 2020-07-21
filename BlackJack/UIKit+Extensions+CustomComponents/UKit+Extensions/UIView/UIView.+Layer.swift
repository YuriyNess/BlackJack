//
//  UIView.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 12/26/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import UIKit

extension UIView {
    @discardableResult
    open func roundShape() -> Self {
        clipsToBounds = true
        layer.cornerRadius = frame.width / 2
        return self
    }
    
    @discardableResult
    open func roundHeight() -> Self {
        clipsToBounds = true
        layer.cornerRadius = frame.height / 2
        return self
    }
    
    open var cornerRadius: CGFloat {
        set {layer.cornerRadius = newValue}
        get {return layer.cornerRadius}
    }
    
    open func setupShadow(opacity: Float = 0, radius: CGFloat = 0, offset: CGSize = .zero, color: UIColor = .black) {
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
    }
}
