//
//  Accaunt.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 2/11/20.
//  Copyright © 2020 YuriyFpc. All rights reserved.
//

protocol Accaunt {
    func saveTelephon(number: String)
    func loadTelephonNumber() -> String?
    func saveWalletIds(ids: [String])
    func loadWalletIds() -> [String]?
    func saveWalletStatuses(statuses: [String])
    func loadWalletStatuses() -> [String]?
}
