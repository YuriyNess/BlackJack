//
//  UIButton+Touches.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 12/26/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import UIKit

extension UIButton {
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isHighlighted = true
        super.touchesBegan(touches, with: event)
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isHighlighted = false
        super.touchesEnded(touches, with: event)
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        isHighlighted = false
        super.touchesCancelled(touches, with: event)
    }
    
}
