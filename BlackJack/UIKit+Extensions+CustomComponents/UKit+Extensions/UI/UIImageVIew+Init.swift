//
//  UIImageVIew.swift
//  SwipeMatchFireBase
//
//  Created by YuriyFpc on 6/25/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import UIKit

extension UIImageView {
    convenience public init(image: UIImage?, contentMode: UIView.ContentMode = .scaleAspectFill) {
        self.init(image: image)
        self.contentMode = contentMode
        self.clipsToBounds = true
    }
}
