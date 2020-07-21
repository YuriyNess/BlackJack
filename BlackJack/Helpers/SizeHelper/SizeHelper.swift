//
//  SizeHelper.swift
//  Thor
//
//  Created by Mihail Konoplitskyi on 11/27/17.
//  Copyright © 2017 Mihail Konoplitskyi. All rights reserved.
//

import Foundation
import UIKit

class SizeHelper {
    static let screen = UIScreen.main.bounds
    
    //414,896
    private struct DeviceSizes {
        static let iPhone11ProMax = (width: CGFloat(414), height: CGFloat(896))
        static let iPhoneX = (width: CGFloat(375), height: CGFloat(812))
    }
    
    // MARK: - Size funcs (default - iPhone X screen size, iPad 9.7-inch)
    static func sizeW(_ size: CGFloat, sizeForRotation: CGSize? = nil) -> CGFloat {
        var screenWidth = UIScreen.main.bounds.width
        if let sizeForRotation = sizeForRotation {
            screenWidth = sizeForRotation.width
        }
        
        return (size * screenWidth) / (DeviceHelper.isIPad ? 768 : DeviceSizes.iPhone11ProMax.width)
    }
    
    static func sizeH(_ size: CGFloat, sizeForRotation: CGSize? = nil) -> CGFloat {
        var screenHeight = UIScreen.main.bounds.height
        if let sizeForRotation = sizeForRotation {
            screenHeight = sizeForRotation.height
        }
        
        return (size * screenHeight) / (DeviceHelper.isIPad ? 1024 : DeviceSizes.iPhone11ProMax.height)
    }
}
