//
//  RoundHeightButton.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 12/30/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import UIKit

open class RoundHeightButton: UIButton {
    public override func layoutSubviews() {
        super.layoutSubviews()
        roundHeight()
    }
}
