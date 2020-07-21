//
//  SoundedButton.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 12/15/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import UIKit
import AudioToolbox

///Plays default keyboard tap sound on button tap
open class SoundedButton: UIButton {
    open override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        AudioServicesPlaySystemSoundWithCompletion(1104, nil)
        return super.beginTracking(touch, with: event)
    }
}
