//
//  LayoutKeyboardObserver.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 12/13/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import Foundation
import UIKit

///Stack views must be without margins (top/bottom)
///Constraints must be chained
///Calculate is keyboard intersect the bottomView. if its true calculate the distance on which it overlaps the bottom view, change all the constraints in perentage to remove this overlapping
final class LayoutKeyboardObserver {
    var isKeyboardShown = false
    var hideComplition: (()->Void)?
    
    private enum KeyboardState {
        case unknown
        case entering
        case exiting
    }

    private struct MovHeight {
        let inititalHeight: CGFloat
        var finalHeight: CGFloat = 0
        var constraint: NSLayoutConstraint?
        var stackView: UIStackView?
    }
    
    private var heightItems: [MovHeight] = [MovHeight]()
    private var bottomView: UIView
    private var view: UIView
    
    init(bottomView: UIView, constraints: [NSLayoutConstraint], stackViews: [UIStackView], inView: UIView) {
        self.bottomView = bottomView
        self.view = inView
        instantiateHeightItems(constraints: constraints, stackViews: stackViews)
        subscribeForKeyboardNotifications()
    }
    
    func hideKeyboardIfPresent(complition: @escaping ()->Void) {
        if isKeyboardShown {
            hideComplition = complition
            UIResponder.resignCurrentResponder()
        } else {
            complition()
        }
    }
    
    private func instantiateHeightItems(constraints: [NSLayoutConstraint], stackViews: [UIStackView]) {
        let constrArr = constraints.map({MovHeight(inititalHeight: $0.constant, finalHeight: 0, constraint: $0, stackView: nil)})
        heightItems.append(contentsOf: constrArr)
        let stackArr = stackViews.map({MovHeight(inititalHeight: $0.spacing, finalHeight: 0, constraint: nil, stackView: $0)})
        heightItems.append(contentsOf: stackArr)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func subscribeForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    private func keyboardShow(n: Notification) {
        isKeyboardShown = true
        let d = n.userInfo!
        let (state, rnew) = keyboardState(for:d, in:view)
        
        if state == .entering {
            if let rnew = rnew {
                let inset = culculateContentInset(keyboardH: rnew.height)
                calculateFinalHeightForItems(inset: inset)
                setFinalState()
                UIView.animate(withDuration: 0.5) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc
    private func keyboardHide(n: Notification) {
        isKeyboardShown = false
        let d = n.userInfo!
        let (state, _) = keyboardState(for:d, in:view)
        if state == .exiting {
            setInitialState()
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
        hideComplition?()
        hideComplition = nil
    }
    
    private func keyboardState(for d:[AnyHashable:Any], in v:UIView?) -> (KeyboardState, CGRect?) {
        var rold = d[UIResponder.keyboardFrameBeginUserInfoKey] as! CGRect
        var rnew = d[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        var ks : KeyboardState = .unknown
        var newRect : CGRect? = nil
        if let v = v {
            let co = UIScreen.main.coordinateSpace
            rold = co.convert(rold, to:v)
            rnew = co.convert(rnew, to:v)
            newRect = rnew
            if !rold.intersects(v.bounds) && rnew.intersects(v.bounds) {
                ks = .entering
            }
            if rold.intersects(v.bounds) && !rnew.intersects(v.bounds) {
                ks = .exiting
            }
        }
        return (ks, newRect)
    }
    
    private func culculateContentInset(keyboardH: CGFloat) -> CGFloat {
        let lastSpace = view.bounds.height - keyboardH
        
        if lastSpace <= bottomView.frame.maxY + 2 {
            return bottomView.frame.maxY + 2 - lastSpace
        } else {
            return 0
        }
    }
    
    private func setInitialState() {
        heightItems.forEach { (item) in
            if item.constraint != nil {
                item.constraint?.constant = item.inititalHeight
            } else {
                item.stackView?.spacing = item.inititalHeight
            }
        }
    }
    
    private func setFinalState() {
        heightItems.forEach { (item) in
            if item.constraint != nil {
                item.constraint?.constant = item.finalHeight
            } else {
                item.stackView?.spacing = item.finalHeight
            }
        }
    }
    
    private func sumItemsHeight() -> CGFloat {
        return heightItems.map({$0.inititalHeight}).reduce(0,+)
    }
    
    private func calculateFinalHeightForItems(inset: CGFloat) {
        let sumH = sumItemsHeight()
        
        for (i,item) in heightItems.enumerated() {
            let percent = item.inititalHeight * 100 / sumH
            let additionalHeigh = inset * percent / 100
            heightItems[i].finalHeight = item.inititalHeight - additionalHeigh
        }
    }
}

