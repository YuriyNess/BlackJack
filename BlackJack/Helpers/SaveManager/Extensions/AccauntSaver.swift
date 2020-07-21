//
//  AccauntSaver.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 2/11/20.
//  Copyright © 2020 YuriyFpc. All rights reserved.
//

enum AccauntKeys: String, SaveManagerKeys {
    func key() -> String {
        return self.rawValue
    }
    
    case telephoneNumber
    case walletIds
    case walletStatuses
    case walletStatusesId
    case isUserHasPhoneCard
    case isUserHasWalletCard
    case minPaymentAmount
    case maxPaymentAmount
}

extension SaveManager: Accaunt {
    func saveMaxPaymentAmount(_ amount: String) {
        save(object: amount, key: AccauntKeys.maxPaymentAmount)
    }
    
    func loadMaxPaymentAmount() -> String? {
        if let amount = get(key: AccauntKeys.maxPaymentAmount) as? String {
            return amount
        }
        return nil
    }
    
    func saveMinPaymentAmount(_ amount: String) {
        save(object: amount, key: AccauntKeys.minPaymentAmount)
    }
    
    func loadMinPaymentAmount() -> String? {
        if let amount = get(key: AccauntKeys.minPaymentAmount) as? String {
            return amount
        }
        return nil
    }
    
    func saveIsUserHasPhoneCard(_ flag: Bool) {
        save(object: flag, key: AccauntKeys.isUserHasPhoneCard)
    }
    
    func loadIsUserHasPhoneCard() -> Bool? {
        if let flag = get(key: AccauntKeys.isUserHasPhoneCard) as? Bool {
            return flag
        }
        return nil
    }
    
    func saveIsUserHasWalletCard(_ flag: Bool) {
        save(object: flag, key: AccauntKeys.isUserHasWalletCard)
    }
    
    func loadIsUserHasWalletCard() -> Bool? {
        if let flag = get(key: AccauntKeys.isUserHasWalletCard) as? Bool {
            return flag
        }
        return nil
    }
    
    func saveWalletStatuses(statuses: [String]) {
        save(object: statuses, key: AccauntKeys.walletStatuses)
    }
    
    func loadWalletStatuses() -> [String]? {
        if let ids = get(key: AccauntKeys.walletStatuses) as? [String] {
            return ids
        }
        return nil
    }
    
    func saveWalletStatusesId(statuses: [String]) {
        save(object: statuses, key: AccauntKeys.walletStatusesId)
    }
    
    func loadWalletStatusesId() -> [String]? {
        if let ids = get(key: AccauntKeys.walletStatusesId) as? [String] {
            return ids
        }
        return nil
    }
    
    func saveWalletIds(ids: [String]) {
        save(object: ids, key: AccauntKeys.walletIds)
    }
    
    func loadWalletIds() -> [String]? {
        if let ids = get(key: AccauntKeys.walletIds) as? [String] {
            return ids
        }
        return nil
    }
    
    func saveTelephon(number: String) {
        save(object: number, key: AccauntKeys.telephoneNumber)
    }
    
    func loadTelephonNumber() -> String? {
        if let number = get(key: AccauntKeys.telephoneNumber) as? String {
            return number
        }
        return nil
    }
}
