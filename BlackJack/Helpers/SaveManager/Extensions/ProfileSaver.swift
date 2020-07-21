//
//  SaveProfileProtocol.swift
//  ProductsTestApp
//
//  Created by YuriyFpc on 8/28/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import Foundation
import UIKit

enum ProfileKeys: String, SaveManagerKeys {
    func key() -> String {
        return self.rawValue
    }
    
    case firstName
    case lastName
    case avatar
    case password
}

extension SaveManager: ProfileSaver {
    func savePassword(_ password: String) {
        save(object: password, key: ProfileKeys.password)
    }
    
    func loadPassword() -> String? {
        return get(key: ProfileKeys.password) as? String
    }
    
    func saveFirstName(_ first: String) {
        save(object: first, key: ProfileKeys.firstName)
    }
    
    func loadFirstName() -> String? {
        return get(key: ProfileKeys.firstName) as? String
    }
    
    func saveLastName(_ last: String) {
        save(object: last, key: ProfileKeys.lastName)
    }
    
    func loadlastName() -> String? {
        return get(key: ProfileKeys.lastName) as? String
    }
    
    func saveAvatar(image: UIImage) {
        do {
            try urchive(object: image, key: ProfileKeys.avatar)
        } catch {
            print(error)
        }
    }
    
    func loadAvatar() -> UIImage? {
        do {
            return try unurchive(key: ProfileKeys.avatar)
        } catch {
            print(error)
            return nil
        }
    }
    
}
