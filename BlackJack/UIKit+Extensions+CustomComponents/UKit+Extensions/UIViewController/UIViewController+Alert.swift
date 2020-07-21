//
//  UIViewController.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 1/22/20.
//  Copyright © 2020 YuriyFpc. All rights reserved.
//

import UIKit

extension UIViewController {
    open func showAlertWith(error: Error, compltetion: (()->Void)? = nil) {
        let alert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            compltetion?()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    open func showAlertWith(title: String, message: String, compltetion: (()->Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            compltetion?()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    open func showOKCancelAlertWith(title: String, message: String, compltetion: (()->Void)? = nil, cancelCompltetion: (()->Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            compltetion?()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .default, handler: { action in
            cancelCompltetion?()
        }))
        present(alert, animated: true, completion: nil)
    }
}
