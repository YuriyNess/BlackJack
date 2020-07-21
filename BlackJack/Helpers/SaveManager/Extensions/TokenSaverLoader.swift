//
//  TokenSaver.swift
//  ProductsTestApp
//
//  Created by YuriyFpc on 8/28/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import Foundation

enum TokenKeys: String, SaveManagerKeys {
    func key() -> String {
        return self.rawValue
    }
    
    case pushToken
    case token
}

extension SaveManager: TokenSaver {
    func saveToken(_ token: String) {
        save(object: token, key: TokenKeys.token)
    }
    
    func savePushToken(_ token: String) {
        save(object: token, key: TokenKeys.pushToken)
    }
}

extension SaveManager: TokenLoader {
    func loadToken() -> String? {
        return get(key: TokenKeys.token) as? String
    }
    
    func loadPushToken() -> String? {
        return get(key: TokenKeys.pushToken) as? String
    }
}
