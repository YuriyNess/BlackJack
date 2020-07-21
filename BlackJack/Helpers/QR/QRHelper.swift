//
//  QRHelper.swift
//  AMobile
//
//  Created by Mihail Konoplitskyi on 1/29/19.
//  Copyright © 2019 Mihail Konoplitskyi. All rights reserved.
//

import Foundation
import UIKit

class QRHelper: NSObject {
    static let shared = QRHelper()
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
}
