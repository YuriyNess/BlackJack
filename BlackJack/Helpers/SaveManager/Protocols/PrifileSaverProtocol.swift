//
//  PrifileSaver.swift
//  ProductsTestApp
//
//  Created by YuriyFpc on 8/29/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import UIKit

protocol ProfileSaver {
    func saveFirstName(_ first: String)
    func saveLastName(_ last: String)
    func saveAvatar(image: UIImage)
    func savePassword(_ password: String)
    
    func loadFirstName() -> String?
    func loadlastName() -> String?
    func loadAvatar() -> UIImage?
    func loadPassword() -> String?
}
