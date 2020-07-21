//
//  ImageViewLoader.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 10.06.2020.
//  Copyright © 2020 YuriyFpc. All rights reserved.
//

import UIKit
import SkeletonView
import Kingfisher


final class ImageViewLoader {
    
    static let placeholderImage: UIImage = {
       let renderer = UIGraphicsImageRenderer(size: CGSize(width: 220, height: 220))

       let img = renderer.image { ctx in
           let rectangle = CGRect(x: 0, y: 0, width: 220, height: 220)

           ctx.cgContext.setFillColor(UIColor.rgb(red: 220, green: 220, blue: 221).cgColor)
           ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fill)
       }
        return img
    }()
    
    static func loadImageWithSkeletonActivityFor(_ imageView: UIImageView, url: String, animated: Bool = true, shouldCancelActiveLoading: Bool = false) {
        let urlName = (url as NSString).replacingOccurrences(of: " ", with: "%20") // (" " =  %20) ASCI for urls
        guard let url = URL(string: urlName) else { return }
        if shouldCancelActiveLoading == true {
            imageView.kf.cancelDownloadTask()
        }
        if ImageCache.default.isCached(forKey: url.absoluteString, processorIdentifier: DefaultImageProcessor.default.identifier) {
            imageView.kf.setImage(with: url, placeholder: nil)
        } else {
            if imageView.isSkeletonActive == false, animated == true {
                imageView.showSkeleton()
                imageView.startSkeletonAnimation()
            }
            imageView.kf.setImage(with: url, placeholder: placeholderImage) { (result) in
                switch result {
                case .success(_):
                    imageView.hideSkeleton()
                    imageView.stopSkeletonAnimation()
                case .failure(_):
                    break
                }
            }
        }
    }
    
    static func loadImageWithSkeletonActivityFor(_ button: UIButton, url: String, animated: Bool = true, shouldCancelActiveLoading: Bool = false) {
        let urlName = (url as NSString).replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: urlName) else { return }
        if shouldCancelActiveLoading == true {
            button.kf.cancelImageDownloadTask()
        }
        if ImageCache.default.isCached(forKey: url.absoluteString, processorIdentifier: DefaultImageProcessor.default.identifier) {
            button.kf.setImage(with: url, for: .normal)
        } else {
            button.startSkeletonAnimation()
            if button.isSkeletonActive == false, animated == true {
                button.showSkeleton()
                button.startSkeletonAnimation()
            }
            button.kf.setImage(with: url, for: .normal) { (result) in
                switch result {
                case .success(_):
                    button.hideSkeleton()
                    button.stopSkeletonAnimation()
                case .failure(_):
                    break
                }
            }
        }
    }
}
