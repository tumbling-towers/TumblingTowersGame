//
//  CGPath+Dimensions.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 23/3/23.
//

import Foundation
import CoreGraphics

extension CGPath {
    var height: Double {
        Double(self.boundingBox.height)
    }

    var width: Double {
        Double(self.boundingBox.width)
    }
}
