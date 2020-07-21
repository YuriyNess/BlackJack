//
//  Roboto.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 1/4/20.
//  Copyright © 2020 YuriyFpc. All rights reserved.
//
import UIKit

extension UIFont {
    public enum Roboto {
        public static func regular(size: CGFloat) -> UIFont? {
            return UIFont(name: "Roboto-Regular", size: size)
        }
        
        public static func light(size: CGFloat) -> UIFont? {
            return UIFont(name: "Roboto-Light", size: size)
        }
        
        public static func bold(size: CGFloat) -> UIFont? {
            return UIFont(name: "Roboto-Bold", size: size)
        }
        
        public static func medium(size: CGFloat) -> UIFont? {
            return UIFont(name: "Roboto-Medium", size: size)
        }
    }
}


