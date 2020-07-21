//
//  GameView.swift
//  BlackJack
//
//  Created by YuriyFpc on 21.07.2020.
//  Copyright © 2020 YuriyFpc. All rights reserved.
//

import UIKit
import SnapKit

final class GameView: UIView {
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        
    }
}
