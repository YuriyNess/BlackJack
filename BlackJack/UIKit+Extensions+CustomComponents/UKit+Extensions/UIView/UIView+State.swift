//
//  UITableViewCell+State.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 2/25/20.
//  Copyright © 2020 YuriyFpc. All rights reserved.
//

import UIKit

extension UIView {
    @objc open func setUserInteractionActiveState() {
        self.isUserInteractionEnabled = true
    }
    
    @objc open func setUserInteractionPassiceState() {
        self.isUserInteractionEnabled = false
    }
}
