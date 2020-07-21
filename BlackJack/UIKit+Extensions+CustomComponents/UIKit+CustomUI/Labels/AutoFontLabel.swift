//
//  AutoFontLabel.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 12/25/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import UIKit

///SET Number of lines = 0
open class AutoFontLabel: UILabel {
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        adjustFont()
    }
    
    private func adjustFont() {
        guard let wordsArray = text?.split(separator: " ").flatMap({$0.split(separator: "\n")}) else { return }
        
        var fontSize = self.font.pointSize
        
        //find max size of word
        while true {
            var size = CGSize.zero
            for (_, item) in wordsArray.enumerated() {
                let s = NSString(string: String(item)).size(withAttributes: [NSAttributedString.Key.font: self.font.withSize(fontSize)])
                if s.width >= size.width {
                    size = s
                }
            }
            if size.width >= bounds.width || size.height >= bounds.height {
                fontSize -= 1
            } else {
                break
            }
        }
        //debugPrint(fontSize)
        var flag = false
        var str = ""
        while true {
            str = String(wordsArray.first ?? "")
            
            if wordsArray.count == 1 {
                flag = true
            }
            
            for i in 1..<wordsArray.count {
                var s = NSString(string: String(str + " " + wordsArray[i])).size(withAttributes: [NSAttributedString.Key.font: self.font.withSize(fontSize)])
                if s.width >= bounds.width {
                    s = NSString(string: String(str + "\n" + wordsArray[i])).size(withAttributes: [NSAttributedString.Key.font: self.font.withSize(fontSize)])
                    if s.height >= bounds.height {
                        fontSize -= 1
                        break
                    } else {
                        str = str + "\n" + wordsArray[i]
                    }
                } else {
                    str = str + " " + wordsArray[i]
                }
                
                //Out from external loop if walk throw the all items
                if i == wordsArray.count - 1 {
                    flag = true
                }
            }
            
            if flag == true {
                break
            }
        }
        
        font = self.font.withSize(fontSize)
        text = str
    }
}
