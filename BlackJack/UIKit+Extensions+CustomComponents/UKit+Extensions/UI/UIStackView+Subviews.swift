//
//  UIStackView+Subviews.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 3/3/20.
//  Copyright © 2020 YuriyFpc. All rights reserved.
//

import UIKit

extension UIStackView {
    open func removeAllArrangedSubviews() {
        arrangedSubviews.forEach({$0.removeFromSuperview()})
    }
}
