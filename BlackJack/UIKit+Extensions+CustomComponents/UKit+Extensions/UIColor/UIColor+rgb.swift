//
//  UIColor.swift
//  SwipeMatchFireBase
//
//  Created by YuriyFpc on 6/25/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import UIKit

extension UIColor {
    public static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    public static func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        let maxValue: CGFloat = 255
        return UIColor(red: r / maxValue, green: g / maxValue, blue: b / maxValue, alpha: a)
    }
}
