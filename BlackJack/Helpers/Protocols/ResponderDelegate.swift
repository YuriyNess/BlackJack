//
//  ResponderDelegate.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 12/31/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import UIKit

protocol ResponderStateDelegate: AnyObject {
    func becomeFirstResponderEventOccured(sender: ResponderDelegate)
    func resignFirstResponderEventOccured(sender: ResponderDelegate)
}

protocol ResponderDelegate: UIView {
    var stateDelegate: ResponderStateDelegate? {get set}
    func becomeFirstResponder() -> Bool // override to invoke delegate
    func resignFirstResponder() -> Bool // override to invoke delegate
}
