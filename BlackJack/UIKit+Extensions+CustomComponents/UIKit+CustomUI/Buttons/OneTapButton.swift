//
//  OneTapButton.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 4/17/20.
//  Copyright © 2020 YuriyFpc. All rights reserved.
//

import UIKit

open class OneTapButton: UIButton {
    open override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        isUserInteractionEnabled = false
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleActiveButton), userInfo: nil, repeats: false)
        return super.beginTracking(touch, with: event)
    }
    
    @objc private func handleActiveButton() {
        isUserInteractionEnabled = true
    }
}
