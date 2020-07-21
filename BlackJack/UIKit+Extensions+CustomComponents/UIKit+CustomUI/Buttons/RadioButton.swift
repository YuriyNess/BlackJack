//
//  RadioButton.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 2/10/20.
//  Copyright © 2020 YuriyFpc. All rights reserved.
//

import UIKit

open class RadioButton: UIButton {
    open var selectedColor: UIColor = .red
    
    open override var isSelected: Bool {
        didSet {
            setNeedsDisplay()
        }
    }
    
    open override func draw(_ rect: CGRect) {
        if isSelected {
            let ovalPath = UIBezierPath(ovalIn: rect.insetBy(dx: rect.width/4, dy: rect.height/4))
            selectedColor.setFill()
            ovalPath.fill()
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        tintColor = .clear
        roundShape()
    }
}
