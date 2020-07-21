//
//  TriangleView.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 2/12/20.
//  Copyright © 2020 YuriyFpc. All rights reserved.
//

import UIKit

final class TriangleView: UIView {
    var triangleColor = UIColor.gray
    
    override func draw(_ rect: CGRect) {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: rect.minX, y: rect.minY))
        bezierPath.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        bezierPath.addLine(to: CGPoint(x: (rect.maxX / 2.0), y: rect.maxY))
        bezierPath.close()
        triangleColor.set()
        bezierPath.fill()
    }
}
