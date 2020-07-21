//
//  CollectionKeyboardObserver.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 12/30/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import UIKit

final class CollectionKeyboardObserver {
    let collectionView: UICollectionView
    var savedInset: UIEdgeInsets?
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
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
        
        savedInset = collectionView.contentInset
        var contentInset:UIEdgeInsets = collectionView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        collectionView.contentInset = contentInset
        
        guard let index = collectionView.indexPathsForVisibleItems.sorted().last else { return }
        collectionView.scrollToItem(at: index, at: .bottom, animated: false)
    }
    
    @objc
    func keyboardWillHide(notification:NSNotification){
        collectionView.contentInset = savedInset ?? UIEdgeInsets.zero
    }
}
