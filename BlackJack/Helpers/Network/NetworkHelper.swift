//
//  NetworkHelper.swift
//  Thor
//
//  Created by Mihail Konoplitskyi on 10/18/17.
//  Copyright © 2017 Mihail Konoplitskyi. All rights reserved.
//

import Foundation
import Alamofire

final class RequestIdentifire {
    static func create(url: String, params: [String: Any]) -> String {
        var id = url
        let sortedKeys = params.keys.sorted()
        for (_,key) in sortedKeys.enumerated() {
            id += "+\(key)+\(params[key] ?? "")"
        }
        return id
    }
}

class NetworkHelper: NSObject {
    
    static let dateFormat = "dd.MM.yyyy HH:mm:ss"
    static let sharedUrl = "https://money.a-mobile.biz:11443/amw.aspx"
    static let sharedIconsUrl = "https://money.a-mobile.biz:11443" ///icons/"
    static let key = "ZhEOGoYCubEnJ34yl0yBeF40rHX3sCErKUJaTAZqj8NYSmkQqb2KxUi9xB6rMUCc"
    
    fileprivate let url = "https://money.a-mobile.biz:11443/amw.aspx"
    private var activeRequests = [String: DataRequest]()
    
    func post(params: [String:Any]?, headers: [String:String]?, shouldCancel: Bool = false, stopDoubledRequests: Bool = false, failure: ((Error) -> Void)?, success: @escaping (Any?) -> Void) {
        let headers = headers != nil ? HTTPHeaders(headers!) : HTTPHeaders()
        
        let requestId = RequestIdentifire.create(url: url, params: params ?? [:])
        
        if stopDoubledRequests, self.activeRequests[requestId] != nil  {
            return
        }
        
        if shouldCancel {
            let savedRequest = self.activeRequests[requestId]
            savedRequest?.cancel()
            if savedRequest != nil {
                debugPrint("CANCEL")
            }
        }
        
        let request = AF.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers).responseData { [weak self] (response) in

            self?.activeRequests[requestId] = nil
            
            switch response.result {
            case .success:
                debugPrint("NetworkHelper Validation Successful")
                if let data = response.value {
                    let str = String(data: data, encoding: .utf8)
                    debugPrint(str ?? "-nil StringData")
                    success(data)
                }
            case let .failure(error):
                debugPrint("NetworkHelper FAILURE: ")
                debugPrint(error)
                if error.isExplicitlyCancelledError == false { // -999 canceled request
                    failure?(error)
                } else {
                    debugPrint("ErrCancelResponse")
                }
            }
        }
        
        //save request
        activeRequests[requestId] = request
    }
    
    func get(method: String, params: [String:String]?, headers: [String:String]?, shouldCancel: Bool = false, stopDoubledRequests: Bool = false, failure: ((Error) -> Void)?, success: @escaping (Any?) -> Void) {
        let headers = headers != nil ? HTTPHeaders(headers!) : HTTPHeaders()
        let url = self.url(method: method, params: params)!
        
        let requestId = RequestIdentifire.create(url: url.absoluteString, params: params ?? [:])
        
        if stopDoubledRequests, self.activeRequests[requestId] != nil  {
            return
        }
        
        if shouldCancel {
            let savedRequest = self.activeRequests[requestId]
            savedRequest?.cancel()
        }
        
        let request = AF.request(url, method: .get, parameters: params, encoding: URLEncoding.httpBody, headers: headers).responseData { [weak self] (response) in
            
            self?.activeRequests[requestId] = nil
            
            switch response.result {
            case .success:
                debugPrint("NetworkHelper Validation Successful")
                if let data = response.value {
                    let str = String(data: data, encoding: .utf8)
                    debugPrint(str ?? "-nil StringData")
                    success(data)
                }
            case let .failure(error):
                debugPrint("NetworkHelper FAILURE: ")
                debugPrint(error)
                if error.isExplicitlyCancelledError == false { // -999 canceled request
                    failure?(error)
                } else {
                    debugPrint("ErrCancelResponse")
                }
            }
        }
        
        //save request
        activeRequests[requestId] = request
    }
    
    // MARK: - Private
    private func url(method: String, params: [String: String]?) -> URL? {
        guard let params = params else { return URL(string: method) }
        var paramsString = "?"
        let stringUrl = method
        for (index, key) in params.keys.enumerated() {
            if index > 0 {
                paramsString = paramsString + "&"
            }
            if let value = params[key] {
                paramsString = paramsString + key + "=" + "\(value)"
            }
        }
        let resultString = stringUrl + paramsString
        return URL(string: resultString)
    }

}
