//
//  UIResponder.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 1/5/20.
//  Copyright © 2020 YuriyFpc. All rights reserved.
//

import UIKit

extension UIResponder {
    private weak static var _currentFirstResponder: UIResponder? = nil
    
    public static var current: UIResponder? {
        UIResponder._currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(findFirstResponder(sender:)), to: nil, from: nil, for: nil)
        return UIResponder._currentFirstResponder
    }
    
    public static func resignCurrentResponder() {
        guard let responer = current else { return }
        responer.resignFirstResponder()
    }
    
    @objc internal func findFirstResponder(sender: AnyObject) {
        UIResponder._currentFirstResponder = self
    }
}
