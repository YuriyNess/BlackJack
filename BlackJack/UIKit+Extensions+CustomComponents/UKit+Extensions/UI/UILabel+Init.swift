//
//  UILabel.swift
//  SwipeMatchFireBase
//
//  Created by YuriyFpc on 6/25/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import UIKit

extension UILabel {
    convenience public init(text: String?, font: UIFont? = UIFont.systemFont(ofSize: 14), textColor: UIColor = .black, textAlignment: NSTextAlignment = .left, numberOfLines: Int = 1) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
}
