//
//  TitleCell.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 1/20/20.
//  Copyright © 2020 YuriyFpc. All rights reserved.
//

import UIKit

open class TitleCell: UITableViewCell {
    
    public let titleLabel: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.textColor = .black
        obj.text = "Text"
        obj.textAlignment = .left
        obj.numberOfLines = 0
        return obj
    }()
    
    public let separator: UIView = {
        let obj = UIView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.backgroundColor = .lightGray
        return obj
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        accessoryType = .disclosureIndicator

        addSubview(titleLabel)
        addSubview(separator)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 21).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -34).isActive = true
        
        separator.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        separator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        separator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}

