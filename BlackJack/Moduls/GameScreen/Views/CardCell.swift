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
    
    let text: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        obj.textColor = .black
        obj.text = "Text"
        obj.textAlignment = .center
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
        addSubview(text)
        text.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
