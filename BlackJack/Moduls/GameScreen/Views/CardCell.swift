//
//  CardCell.swift
//  BlackJack
//
//  Created by YuriyFpc on 21.07.2020.
//  Copyright © 2020 YuriyFpc. All rights reserved.
//

import UIKit
import SnapKit

final class CardCell: UICollectionViewCell {
    
    let topValue: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.font = UIFont.systemFont(ofSize: SizeHelper.sizeW(17), weight: .medium)
        obj.textColor = .black
        obj.text = ""
        obj.textAlignment = .left
        obj.adjustsFontSizeToFitWidth = true
        obj.minimumScaleFactor = 0.6
        return obj
    }()
    
    let suitImage: UIImageView = {
        let obj = UIImageView(image: UIImage(named: ""))
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.contentMode = .scaleAspectFill
        obj.clipsToBounds = true
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        addSubview(topValue)
        addSubview(suitImage)
        
        topValue.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(SizeHelper.sizeW(4))
            make.leading.equalToSuperview().offset(SizeHelper.sizeW(4))
            make.trailing.equalToSuperview().offset(SizeHelper.sizeW(-4))
        }
        
        suitImage.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(SizeHelper.sizeH(-16))
            make.centerX.equalToSuperview()
            make.width.height.equalTo(SizeHelper.sizeW(44))
        }
    }
}
