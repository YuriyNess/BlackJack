//
//  TableKeyboardObserver.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 2/5/20.
//  Copyright © 2020 YuriyFpc. All rights reserved.
//


import UIKit

final class TableKeyboardObserver {
    let tableView: UITableView
    var savedInset: UIEdgeInsets?
    
    init(tableView: UITableView) {
        self.tableView = tableView
        setupObservers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func keyboardWillShow(notification:NSNotification){
        
        let userInfo = notification.userInfo!
        let keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        savedInset = tableView.contentInset
        var contentInset:UIEdgeInsets = tableView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 30
        tableView.contentInset = contentInset
        
        guard let index = tableView.indexPathsForVisibleRows?.sorted().last else { return }
        tableView.scrollToRow(at: index, at: .bottom, animated: false)
//        let bottomOffset = CGPoint(x: 0, y: self.tableView.contentSize.height - self.tableView.bounds.size.height + self.tableView.contentInset.bottom)
//
//        tableView.setContentOffset(bottomOffset, animated: false)
    }
    
    @objc
    func keyboardWillHide(notification:NSNotification){
        tableView.contentInset = savedInset ?? UIEdgeInsets.zero
    }
}
