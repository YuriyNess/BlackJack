//
//  PaddingLabel.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 12/13/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import UIKit

open class PaddingLabel: UILabel {
    
    open var topInset: CGFloat = 0.0
    open var bottomInset: CGFloat = 0.0
    open var leftInset: CGFloat = 0.0
    open var rightInset: CGFloat = 0.0
    
    open override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    open override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
