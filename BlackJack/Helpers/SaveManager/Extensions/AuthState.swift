//
//  AuthState.swift
//  ProductsTestApp
//
//  Created by YuriyFpc on 8/28/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import Foundation

enum AuthStateKeys: String, SaveManagerKeys {
    func key() -> String {
        return self.rawValue
    }
    
    case authState
    case biometricAuth
    case areInvitationMessagesWereShown
}

extension SaveManager: AuthState {
    func saveAreInvitationMessagesWereShown(_ areShown: Bool) {
        save(object: areShown, key: AuthStateKeys.areInvitationMessagesWereShown)
    }
    
    func loadAreInvitationMessagesWereShown() -> Bool {
        if let state = get(key: AuthStateKeys.areInvitationMessagesWereShown) as? Bool {
            return state
        }
        return false
    }
    
    func saveAuthState(_ isAuth: Bool) {
        save(object: isAuth, key: AuthStateKeys.authState)
    }
    
    func loadAuthState() -> Bool {
        if let state = get(key: AuthStateKeys.authState) as? Bool {
            return state
        }
        return false
    }
    
    func saveBiometricAuthState(_ isAuth: Bool) {
        save(object: isAuth, key: AuthStateKeys.biometricAuth)
    }
    
    func loadBiometricAuthState() -> Bool {
        if let state = get(key: AuthStateKeys.biometricAuth) as? Bool {
            return state
        }
        return false
    }
}

