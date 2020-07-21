//
//  HighlitedButton.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 12/15/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import UIKit

///Using with extension on UIButton, touch events, with setting proper button state
open class HighlitedButton: SoundedButton {
    
    private struct Constants {
        static let defaultGray = UIColor.rgb(red: 112, green: 112, blue: 112)
        static let highlightedGray = UIColor.rgb(red: 212, green: 212, blue: 212)
    }
    
    open var borderColor = Constants.defaultGray {
        didSet {setupViews()}
    }
    open var highlitedColor = Constants.highlightedGray {
        didSet {setupViews()}
    }

    open override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                layer.borderColor = highlitedColor.cgColor
            } else {
                layer.borderColor = borderColor.cgColor
            }
        }
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        setupViews()
    }
    
    public init(borderColor: UIColor) {
        self.borderColor = borderColor
        super.init(frame: CGRect.zero)
        setupViews()
    }

    private func setupViews() {
        tintColor = Constants.highlightedGray
        backgroundColor = .clear
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = 1
        setTitleColor(highlitedColor, for: .highlighted)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

