//
//  UIView+Init.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 12/26/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import UIKit

extension UIView {
    convenience public init(backgroundColor: UIColor = .clear) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
    }
}
