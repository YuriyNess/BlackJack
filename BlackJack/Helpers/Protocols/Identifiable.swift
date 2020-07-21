//
//  Identifiable.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 12/26/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//


protocol Identifiable: AnyObject {}

extension Identifiable {
    static var indentifier: String { return String(describing: self) }
}
