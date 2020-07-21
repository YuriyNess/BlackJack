//
//  UIViewController.swift
//  SwipeMatchFireBase
//
//  Created by YuriyFpc on 6/28/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import UIKit

extension UIViewController {
    open func properAddingOfChild(controller: UIViewController, toView: UIView? = nil) {
        let parentView = toView == nil ? self.view : toView
        self.addChild(controller)
        parentView?.addSubview(controller.view)
        controller.didMove(toParent: self)
    }
    
    open func properAddingOfChild(controller: UIViewController, toStackView: UIStackView) {
        self.addChild(controller)
        toStackView.addArrangedSubview(controller.view)
        controller.didMove(toParent: self)
    }
}
