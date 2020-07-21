//
//  UIVIew+Dimmed.swift
//  DimmedView
//
//  Created by YuriyFpc on 26.06.2020.
//  Copyright © 2020 YuriyFpc. All rights reserved.
//

import UIKit

extension UIView {
    
    public enum UIViewFadeStyle {
        case bottom
        case top
        case left
        case right

        case vertical
        case horizontal
    }
    
    ///need to refactor
    ///percentage == 0.1 - means 10% of view will be gradiented
    open func fadeView(style: UIViewFadeStyle = .bottom, percentage: Double = 0.1) {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.clear.cgColor]
        
        let startLocation = percentage
        let endLocation = 1 - percentage
        
        switch style {
        case .bottom:
            gradient.startPoint = CGPoint(x: 0.5, y: endLocation)
            gradient.endPoint = CGPoint(x: 0.5, y: 1)
        case .top:
            gradient.startPoint = CGPoint(x: 0.5, y: startLocation)
            gradient.endPoint = CGPoint(x: 0.5, y: 0.0)
        case .vertical:
            gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
            gradient.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
            gradient.locations = [0.0, startLocation, endLocation, 1.0] as [NSNumber]

        case .left:
            gradient.startPoint = CGPoint(x: startLocation, y: 0.5)
            gradient.endPoint = CGPoint(x: 0.0, y: 0.5)
        case .right:
            gradient.startPoint = CGPoint(x: endLocation, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 0.5)
        case .horizontal:
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
            gradient.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
            gradient.locations = [0.0, startLocation, endLocation, 1.0] as [NSNumber]
        }
        
        layer.mask = gradient
    }
    
    ///percentage == 0.1 - means 10% of view will be gradiented , always below/equal 1
    ///endPointDimmiedPower - alpa value which will be in end point default = 0.2, always below/equal 1
    ///endPointDimmedDecelerationRange - range of finish step bluring from endPointDimmiedPower to 0 , always below/equal 1
    ///should be invoked func adjustDimmedOverlapGradientLayerFrameInLayoutSubviews in layoutSubviews
    open func dimmedViewByOverlaping(style: UIViewFadeStyle = .bottom, percentage: CGFloat = 0.1, endPointDimmedPower: CGFloat = 0.2, endPointDimmedDecelerationRange: CGFloat = 0.1) {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        let whiteColor = UIColor.white
        
        switch style {
        case .bottom:
            let startLocation: CGFloat = 1 - percentage
            let endLocation: CGFloat = 1.0
            let decelarationRange = startLocation - endPointDimmedDecelerationRange
            gradient.colors = [whiteColor.withAlphaComponent(0.0).cgColor,
                               whiteColor.withAlphaComponent(0.0).cgColor,
                               whiteColor.withAlphaComponent(endPointDimmedPower).cgColor,
                               whiteColor.withAlphaComponent(1.0).cgColor]
            gradient.locations = [0.0, decelarationRange, startLocation, endLocation] as [NSNumber]
            gradient.startPoint = CGPoint(x: 0.5, y: startLocation)
            gradient.endPoint = CGPoint(x: 0.5, y: endLocation)
        case .top:
            let startLocation: CGFloat = 0.0
            let endLocation: CGFloat = percentage
            let decelarationRange = endLocation + endPointDimmedDecelerationRange
            gradient.colors = [whiteColor.withAlphaComponent(1.0).cgColor,
                               whiteColor.withAlphaComponent(endPointDimmedPower).cgColor,
                               whiteColor.withAlphaComponent(0.0).cgColor,
                               whiteColor.withAlphaComponent(0.0).cgColor]
            gradient.locations = [startLocation, endLocation, decelarationRange, 1.0] as [NSNumber]
            gradient.startPoint = CGPoint(x: 0.5, y: startLocation)
            gradient.endPoint = CGPoint(x: 0.5, y: endLocation)
        case .left:
            let startLocation: CGFloat = 0.0
            let endLocation: CGFloat = percentage
            let decelarationRange = endLocation + endPointDimmedDecelerationRange
            gradient.colors = [whiteColor.withAlphaComponent(1.0).cgColor,
                               whiteColor.withAlphaComponent(endPointDimmedPower).cgColor,
                               whiteColor.withAlphaComponent(0.0).cgColor,
                               whiteColor.withAlphaComponent(0.0).cgColor]
            gradient.locations = [startLocation, endLocation, decelarationRange, 1.0] as [NSNumber]
            gradient.startPoint = CGPoint(x: startLocation, y: 0.5)
            gradient.endPoint = CGPoint(x: endLocation, y: 0.5)
        case .right:
            let startLocation: CGFloat = 1 - percentage
            let endLocation: CGFloat = 1.0
            let decelarationRange = startLocation - endPointDimmedDecelerationRange
            gradient.colors = [whiteColor.withAlphaComponent(0.0).cgColor,
                               whiteColor.withAlphaComponent(0.0).cgColor,
                               whiteColor.withAlphaComponent(endPointDimmedPower).cgColor,
                               whiteColor.withAlphaComponent(1.0).cgColor]
            gradient.locations = [0.0, decelarationRange, startLocation, endLocation] as [NSNumber]
            gradient.startPoint = CGPoint(x: startLocation, y: 0.5)
            gradient.endPoint = CGPoint(x: endLocation, y: 0.5)
        default:
            break
        }
        
        layer.addSublayer(gradient)
    }

    
    ///Invoke this method in layoutsubviews to adjist dimmed gradient layers frame
    open func adjustDimmedOverlapGradientLayerFrameInLayoutSubviews() {
        let gradientLayers = layer.sublayers?.compactMap({ (sublayer) -> CAGradientLayer? in
            if let gradientLayer = sublayer as? CAGradientLayer {
                return gradientLayer
            } else {
                return nil
            }
        })
        
        gradientLayers?.forEach({$0.frame = self.bounds})
    }
}
