//
//  TokenLoaderProtocol.swift
//  ProductsTestApp
//
//  Created by YuriyFpc on 8/29/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import Foundation

protocol TokenLoader {
    func loadToken() -> String?
}
