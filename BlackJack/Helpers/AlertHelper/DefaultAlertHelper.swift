//
//  DefaultAlertHelper.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 2/3/20.
//  Copyright © 2020 YuriyFpc. All rights reserved.
//

import UIKit

class DefaultAlertHelper {
    
    static let shared = DefaultAlertHelper()
    var appInvalidTokenGoOutCompletion: (()->Void)?
    var isAlertOnWindow = false
    private init() {}
    
    func showAlertWith(controller: UIViewController, error: Error, compltetion: (()->Void)? = nil) {
        guard isAlertOnWindow == false else {return}
        isAlertOnWindow = true
        let alert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] action in
            self?.isAlertOnWindow = false
            
            let err = error as NSError
            if err.code == 1, let outCompletion = self?.appInvalidTokenGoOutCompletion { // invalid token
                outCompletion()
            } else {
                compltetion?()
            }
        }))
        controller.present(alert, animated: true, completion: nil)
    }
    
    func showAlertOnTopViewController(error: Error, compltetion: (()->Void)? = nil) {
        guard isAlertOnWindow == false else {return}
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }

            isAlertOnWindow = true
            let alert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] action in
                self?.isAlertOnWindow = false
                
                let err = error as NSError
                if err.code == 1, let outCompletion = self?.appInvalidTokenGoOutCompletion { // invalid token
                    outCompletion()
                } else {
                    compltetion?()
                }
            }))
            topController.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func showAlertWith(controller: UIViewController,title: String, message: String, compltetion: (()->Void)? = nil) {
        guard isAlertOnWindow == false else {return}
        isAlertOnWindow = true
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.isAlertOnWindow = false
            compltetion?()
        }))
        controller.present(alert, animated: true, completion: nil)
    }
    
    func showOKCancelAlertWith(controller: UIViewController,title: String, message: String, compltetion: (()->Void)? = nil, cancelCompltetion: (()->Void)? = nil) {
        guard isAlertOnWindow == false else {return}
        isAlertOnWindow = true
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.isAlertOnWindow = false
            compltetion?()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .default, handler: { action in
            self.isAlertOnWindow = false
            cancelCompltetion?()
        }))
        controller.present(alert, animated: true, completion: nil)
    }
}
