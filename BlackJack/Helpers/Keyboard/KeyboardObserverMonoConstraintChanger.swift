//
//  KeyboardObserverMonoConstraintChanger.swift
//  HideMy.name VPN
//
//  Created by YuriyFpc on 17.05.2020.
//  Copyright © 2020 MeGaPk. All rights reserved.
//

import UIKit
import SnapKit

protocol KeyboardConstraintEntyty: AnyObject {
    func getConstraint() -> NSLayoutConstraint
}

extension NSLayoutConstraint: KeyboardConstraintEntyty {
    func getConstraint() -> NSLayoutConstraint {
        return self
    }
}

//SnapKit constraint
extension Constraint: KeyboardConstraintEntyty {
    func getConstraint() -> NSLayoutConstraint {
        if let nsConstraint = layoutConstraints.first {
            return nsConstraint
        } else {
            let dummyConstraint = NSLayoutConstraint()
            return dummyConstraint
        }
    }
}

///Change all given cosntraints on keyboard height value
final class KeyboardObserverMonoConstraintChanger {
    
    private final class ObservedEntity {
        let constraint: NSLayoutConstraint
        /// -1 or 1 direction of moving
        let direction: CGFloat
        let initialConstantValue: CGFloat
        
        init(constraint: NSLayoutConstraint, direction: CGFloat, initialConstantValue: CGFloat) {
            self.constraint = constraint
            self.direction = direction
            self.initialConstantValue = initialConstantValue
        }
    }
    
    private let changebleConstraintEntyties: [ObservedEntity]
    private var initialConstantValue: CGFloat = 0
    private let view: UIView
    
    ///changebleConstraints( #1 KeyboardConstraintEntyty, #2 directionOfChange)
    init(changebleConstraints: [(KeyboardConstraintEntyty, CGFloat)], inView: UIView) {
        self.view = inView
        
        self.changebleConstraintEntyties = changebleConstraints.compactMap({ obj -> ObservedEntity in
            let constraint = obj.0.getConstraint()
            return ObservedEntity(constraint: constraint, direction: obj.1, initialConstantValue: constraint.constant)
        })
        setupObservers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        
        let userInfo = notification.userInfo!
        let keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let height = keyboardFrame.height
        
        changebleConstraintEntyties.forEach { (entity) in
            entity.constraint.constant = height * entity.direction + entity.initialConstantValue
        }
        animatConstraintChange()
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        changebleConstraintEntyties.forEach { (entity) in
            entity.constraint.constant = entity.initialConstantValue
        }
        animatConstraintChange()
    }
    
    private func animatConstraintChange() {
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}
