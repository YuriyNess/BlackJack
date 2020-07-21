//
//  CheckBox.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 1/4/20.
//  Copyright © 2020 YuriyFpc. All rights reserved.
//

import UIKit
import AudioToolbox

open class CheckBox: UIButton {
    public let checkedImage = UIImage(named: "check-mark")
    
    public let checkImageView: UIImageView = {
        let obj = UIImageView(image: UIImage(named: "check-mark")?.withRenderingMode(.alwaysTemplate))
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.contentMode = .scaleAspectFill
        obj.tintColor = .white
        obj.isHidden = true
        return obj
    }()
    
    open var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                backgroundColor = .red
                checkImageView.isHidden = false
                layer.borderColor = UIColor.red.cgColor
            } else {
                backgroundColor = .clear
                checkImageView.isHidden = true
                layer.borderColor = UIColor.gray.cgColor
            }
        }
    }
    
    public init() {
        super.init(frame: .zero)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    open override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        AudioServicesPlaySystemSoundWithCompletion(1104, nil)
        return super.beginTracking(touch, with: event)
    }
    
    private func setup() {
        adjustsImageWhenHighlighted = false
        tintColor = UIColor.orange
        addTarget(self, action:#selector(buttonClicked(sender:)), for: .touchUpInside)
        isChecked = false
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 3
        
        addSubview(checkImageView)

        checkImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        checkImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        checkImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7, constant: 0).isActive = true
        checkImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7, constant: 0).isActive = true
    }
    
    @objc open func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
