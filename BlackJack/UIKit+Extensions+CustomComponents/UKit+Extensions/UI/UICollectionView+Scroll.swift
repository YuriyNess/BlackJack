//
//  UICollectionView.swift
//  BlackJack
//
//  Created by YuriyFpc on 21.07.2020.
//  Copyright © 2020 YuriyFpc. All rights reserved.
//

import UIKit

extension UICollectionView {
    func lastIndexPath() -> IndexPath? {
        for sectionIndex in (0..<self.numberOfSections).reversed() {
            if self.numberOfItems(inSection: sectionIndex) > 0 {
                return IndexPath.init(item: self.numberOfItems(inSection: sectionIndex)-1, section: sectionIndex)
            }
        }

        return nil
    }
}

