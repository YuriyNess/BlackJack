//
//  Navigo.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 1/7/20.
//  Copyright © 2020 YuriyFpc. All rights reserved.
//

import UIKit

extension UIFont {
    public enum Navigo {
        public static func bold(size: CGFloat) -> UIFont? {
            return UIFont(name: "Navigo-Bold", size: size)
        }
        
        public static func light(size: CGFloat) -> UIFont? {
            return UIFont(name: "Navigo-Light", size: size)
        }
        
        public static func medium(size: CGFloat) -> UIFont? {
            return UIFont(name: "Navigo-Medium", size: size)
        }
        
        public static func regular(size: CGFloat) -> UIFont? {
            return UIFont(name: "Navigo-Regular", size: size)
        }
    }
}
