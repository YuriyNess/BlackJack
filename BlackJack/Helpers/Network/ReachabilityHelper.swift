//
//  ReachabilityHelper.swift
//  RubetekEvo
//
//  Created by Mihail Konoplitskyi on 12/14/18.
//

import Foundation
import Alamofire

/**
    Используется для проверки интернет соединения
**/
@objc class ReachabilityHelper: NSObject {
    static let shared = ReachabilityHelper()
    
    var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable == true
    }
    
    private override init() {
        super.init()
    }
}
