//
//  AuthState.swift
//  ProductsTestApp
//
//  Created by YuriyFpc on 8/29/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import Foundation

protocol AuthState {
    func saveAuthState(_ isAuth: Bool)
    func loadAuthState() -> Bool
    func saveBiometricAuthState(_ isAuth: Bool)
    func loadBiometricAuthState() -> Bool
}
