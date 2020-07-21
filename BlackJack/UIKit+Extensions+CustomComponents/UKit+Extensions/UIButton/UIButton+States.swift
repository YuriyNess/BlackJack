//
//  UIButton+States.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 2/1/20.
//  Copyright © 2020 YuriyFpc. All rights reserved.
//

import UIKit

extension UIButton {
    open func setDisabledState() {
        isEnabled = false
        backgroundColor = .gray
    }
}
